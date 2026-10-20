import 'package:academic/l10n/l10n.dart';
import 'package:academic/core/api_constants.dart';
import 'package:academic/core/settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:academic/core/injection/injection.dart';
import 'package:academic/core/player/global_player.dart';
import 'package:academic/widgets/mini_player.dart';
import 'package:academic/widgets/player_sheet.dart';
import 'package:academic/core/services/deep_link_service.dart';
import 'package:academic/core/services/reading_progress_service.dart';
import 'package:academic/pages/product/logic/product_cubit.dart';
import 'package:academic/pages/product/product_page.dart';
import 'package:app_links/app_links.dart';
import 'package:get_it/get_it.dart';

import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettings.init();
  await configureDependencies();

  // Register ProductCubit and EpubHandler
  GetIt.I.registerFactory<ProductCubit>(() => ProductCubit());
  GetIt.I.registerFactory<EpubHandler>(() => EpubHandler(
    GetIt.I<ProductCubit>(),
    GetIt.I<ReadingProgressService>(),
  ));

  // Set global status bar style for light mode (dark icons on light background)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppSettings _settings = AppSettings.instance;

  @override
  void initState() {
    super.initState();
    _settings.addListener(_onSettingsChanged);
  }

  @override
  void dispose() {
    _settings.removeListener(_onSettingsChanged);
    super.dispose();
  }

  /// Texts are read through the global `l10n` accessor, so after a language
  /// or theme change every element is rebuilt in place (navigation stack and
  /// page state are kept).
  void _onSettingsChanged() {
    setState(() {});
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return Provider<ReadingProgressService>(
          create: (_) => GetIt.I<ReadingProgressService>(),
          child: GlobalPlayerScope(
            child: MaterialApp.router(
              locale: _settings.locale,
              title: l10n.appName,
              themeMode: _settings.themeMode,
              darkTheme: AppTheme().myTheme(false),
              theme: AppTheme().myTheme(true),
              debugShowCheckedModeBanner: false,
              supportedLocales: AppSettings.supportedLocales,
              builder: (context, child) {
                // Limit text scale factor to prevent layout breaking
                final mediaQuery = MediaQuery.of(context);
                final limitedMediaQuery = mediaQuery.copyWith(
                  textScaleFactor: mediaQuery.textScaleFactor.clamp(1.0, 1.2),
                );
                
                final isDark = Theme.of(context).brightness == Brightness.dark;

                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: isDark
                      ? SystemUiOverlayStyle.light
                          .copyWith(statusBarColor: Colors.transparent)
                      : SystemUiOverlayStyle.dark
                          .copyWith(statusBarColor: Colors.transparent),
                  child: MediaQuery(
                    data: limitedMediaQuery,
                    child: Directionality(
                      textDirection: _settings.textDirection,
                      child: Navigator(
                        onGenerateRoute: (settings) {
                          return MaterialPageRoute(
                            settings: settings,
                            builder: (context) => _PlayerScaffold(child: child),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              scaffoldMessengerKey: scaffoldMessengerKey,
              routerConfig: typedRouter,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                FormBuilderLocalizations.delegate,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlayerScaffold extends StatefulWidget {
  final Widget? child;
  const _PlayerScaffold({this.child});
  @override
  State<_PlayerScaffold> createState() => _PlayerScaffoldState();
}

class _PlayerScaffoldState extends State<_PlayerScaffold> {
  bool _isSheetOpen = false;
  late AppLinks _appLinks;
  late DeepLinkService _deepLinkService;
  final Map<String, DateTime> _processedLinks = {}; // Track processed deep links with timestamp

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _deepLinkService = GetIt.I<DeepLinkService>();
    _initDeepLinks();
  }

  void _initDeepLinks() async {
    // Handle app links while app is running (NOT initial link)
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print('Deep link received: $uri');
        // Handle deep link before GoRouter gets it
        _handleDeepLink(uri.toString());
      }
    }, onError: (err) {
      print('Deep link error: $err');
    });
  }

  void _handleDeepLink(String url) {
    // Use the centralized DeepLinkService for all deep link handling
    print('🔗 Main app deep link received: $url');

    // Check if this link has been processed recently (within last 30 seconds)
    final now = DateTime.now();
    if (_processedLinks.containsKey(url)) {
      final lastProcessed = _processedLinks[url]!;
      final difference = now.difference(lastProcessed);
      if (difference.inSeconds < 30) {
        print('⚠️ Deep link already processed ${difference.inSeconds}s ago, ignoring: $url');
        return;
      }
    }

    // Mark this link as processed with current timestamp
    _processedLinks[url] = now;

    // Clean old entries (older than 1 minute)
    _processedLinks.removeWhere((key, value) => now.difference(value).inMinutes > 1);

    // Special handling for API host callback URLs
    if (url.contains('${ApiConstants.host}/api/callback')) {
      print('🔵 Detected callback URL, handling as payment return');
    }

    // Add delay to ensure context is ready
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _deepLinkService.handlePaymentReturn(context, url);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openPlayerSheet(BuildContext context, GlobalPlayer globalPlayer) async {
    setState(() => _isSheetOpen = true);
    final playerCubit = globalPlayer.playerCubit;
    final state = playerCubit.state;

    if (state.currentTitle == null || state.currentCover == null) {
      setState(() => _isSheetOpen = false);
      return;
    }

    final product = ProductModel(
      id: '0',
      name: state.currentTitle ?? '',
      image: state.currentCover ?? '',
      publisher: '',
      author: null,
      translator: null,
      audioTime: null,
      content: null,
      price: null,
      discountPrice: null,
      peopleRates: null,
      numOfPeopleRates: null,
      menuOfContents: null,
      bookId: null,
      type: null,
      authors: null,
      speaker: null,
      categories: null,
      excerpts: null,
      comments: null,
      commentCount: null,
      authorBooks: null,
      publisherBooks: null,
      epub: null,
      sampleEpub: null,
      sampleAudio: null,
      time: null,
      avgRate: null,
      fileSize: null,
      isPurchased: null,
      publishYear: null,
      headlines: null,
    );

    if (!mounted) return;

    // Show the bottom sheet using the current context
    await showPlayerSheet(context, product);

    if (!mounted) return;
    setState(() => _isSheetOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final globalPlayer = GlobalPlayer.of(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: globalPlayer == null || _isSheetOpen
            ? const SizedBox.shrink()
            : Builder(
                builder: (context) {
                  // Get the current route name from the ModalRoute
                  final currentRoute = ModalRoute.of(context)?.settings.name;
                  // Hide mini player if we're on the player page
                  if (currentRoute == '/player') return const SizedBox.shrink();
                  return MiniPlayer(
                    cover: globalPlayer.currentCover ?? '',
                    title: globalPlayer.currentTitle ?? '',
                    onTap: () => _openPlayerSheet(context, globalPlayer),
                  );
                },
              ),
      ),
    );
  }
}
