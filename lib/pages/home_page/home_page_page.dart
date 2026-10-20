// 📁 lib/ui/home/home_page.dart

import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:academic/widgets/animated_section.dart';
import 'package:academic/widgets/audio_book_progress.dart';
import 'package:academic/widgets/category_item.dart';
import 'package:academic/widgets/other_booksBy_author_widget.dart';
import 'package:academic/widgets/search_input_field.dart';
import 'package:academic/widgets/shimmer_loading.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../../core/helper/image_ur_handler.dart';
import '../../data/api/home/model/book_model.dart';
import 'logic/home_page_cubit.dart';
import 'logic/home_page_state.dart';
import 'package:academic/core/services/reading_progress_service.dart';
import 'package:academic/data/api/home/model/reading_progress_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/pages/product/product_page.dart' show EpubHandler;
import 'package:academic/core/helper/premium_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/widgets/player_sheet.dart';
import 'package:academic/widgets/cart_badge_icon.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/widgets/custom_pdf_viewer.dart';

class HomepagePage extends StatefulWidget {
  const HomepagePage({super.key});

  @override
  State<HomepagePage> createState() => _HomepagePageState();
}

class _HomepagePageState extends State<HomepagePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  PageController? _pageController;
  bool _showContent = false;
  HomePageState? _previousState;
  List<ReadingProgressModel> _readingProgress = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _pageController = PageController();
    _loadReadingProgress();
  }

  Future<void> _loadReadingProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progressService = ReadingProgressService(prefs);
      final progress = await progressService.getProgressList();
      
      print('[HomePage] Loaded ${progress.length} reading progress items');
      
      // Filter out books that don't have proper access (purchased or subscription)
      final isPremiumUser = PremiumHelper.isPremiumUser();
      final filteredProgress = progress.where((p) {
        final isPurchased = p.product.isPurchased ?? false;
        final hasSubscription = p.product.hasSubscription ?? false;
        
        // Only include books that are purchased or have subscription access
        return isPurchased || (hasSubscription && isPremiumUser);
      }).toList();
      
      print('[HomePage] Filtered to ${filteredProgress.length} reading progress items with proper access');
      
      // Sort progress by last read date (newest first)
      filteredProgress.sort((a, b) => b.lastReadAt.compareTo(a.lastReadAt));
      
      setState(() {
        _readingProgress = filteredProgress;
      });
    } catch (e) {
      print('[HomePage] Error loading reading progress: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_showContent) {
      setState(() {
        _showContent = true;
      });
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(HomepagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentState = context.read<HomePageCubit>().state;
    if (_previousState != currentState) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _startAnimation();
      });
    }
    _previousState = currentState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => _buildLoadingState(context),
          empty: () => Scaffold(
                appBar: CustomAppBar(
                  title: l10n.appName,
                  icon: Icons.home_rounded,
                ),
                body: EmptyStateWidget(
                  title: l10n.noContent,
                  message: l10n.noContentToShow,
                  iconAsset: Assets.icBooks,
                ),
              ),
          error: (message) => Scaffold(
                appBar: CustomAppBar(
                  title: l10n.appName,
                  icon: Icons.home_rounded,
                ),
                body: ErrorStateWidget(
                  error: message,
                  onRetry: () => context.read<HomePageCubit>().fetchHomeData(),
                ),
              ),
          success: (data) {
            final audioBooks = data.audioBooks?.data;
            final textBooks = data.textBooks?.data;
            final latestProducts = data.latestProducts?.data;
            final offerProducts = data.offerProducts?.data;
            final featuredProducts = data.featuredProducts?.data;
            final categories = data.categories?.data ?? [];
            final sliders = data.sliders?.data ?? [];

            // Start animation when data is loaded
            if (!_showContent) {
              Future.delayed(const Duration(milliseconds: 300), () {
                _startAnimation();
              });
            }

            return GestureDetector(
              onTap: () => MyAppHelper().hideKeyboard(context),
              child: Scaffold(
                appBar: CustomAppBar(
                  title: l10n.appName,
                  icon: Icons.home_rounded,
                  actions: [
                    // Cart Icon with Badge
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: const CartBadgeIcon(),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    const SizedBox(height: AppSpacing.s16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                      child: SearchInputField(
                        controller: TextEditingController(),
                        Text: l10n.searchInApp,
                        onTap: () => context.push('/bookCategories'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    Expanded(
                      child: ListView(
                        children: [
                          if (_readingProgress.isNotEmpty) ...[
                            AnimatedSection(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeOutCubic,
                              offset: 40,
                              isVisible: _showContent,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(l10n.currentlyReading, style: context.textTheme.headlineSmall),
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.s16),
                                  AspectRatio(
                                    aspectRatio: 16 / 6,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: _readingProgress.map((progress) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
                                            child: AudioBookProgress(
                                              bookTitle: progress.product.name ?? l10n.untitled,
                                              bookDetails: progress.product.type == 'audio' ? l10n.audioBook : l10n.textBook,
                                              progress: (progress.progress * 100).toInt(),
                                              bookIcon: progress.product.image ?? '',
                                              bookType: progress.product.type,
                                              onTap: () {
                                                _onBookTap(progress.product);
                                              },
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.s24),
                          ],

                          if (sliders.isNotEmpty) ...[
                            AnimatedSection(
                              duration: const Duration(milliseconds: 1200),
                              curve: Curves.easeOutCubic,
                              offset: 50,
                              isVisible: _showContent,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.36,
                                child: UniversalImageLoader(
                                  path: buildImageUrl(sliders[0].image),
                                  option: UniversalImageLoaderOption(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * 0.36,
                                    fit: BoxFit.cover,
                                    fadeInDuration: const Duration(milliseconds: 1200),
                                    fadeInCurve: Curves.easeOutCubic,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.s30),
                          ],

                          if (categories.isNotEmpty) ...[
                            AnimatedSection(
                              duration: const Duration(milliseconds: 1400),
                              curve: Curves.easeOutCubic,
                              offset: 45,
                              isVisible: _showContent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                                    child: Text(
                                      l10n.categories,
                                      style: context.textTheme.headlineSmall,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.s16),
                                  SizedBox(
                                    height: 80,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: categories.length,
                                      itemBuilder: (context, index) {
                                        final category = categories[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(left: AppSpacing.s12),
                                          child: SizedBox(
                                            width: 130,
                                            child: GestureDetector(
                                              onTap: () => context.push('/category-products/${category.id}/${category.displayName}'),
                                              child: CategoryItem(
                                                iconPath: buildImageUrl(category.icon) ?? '',
                                                title: category.displayName,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.s24),
                          ],

                          if (latestProducts != null && latestProducts.isNotEmpty)
                            AnimatedSection(
                              duration: const Duration(milliseconds: 1600),
                              curve: Curves.easeOutCubic,
                              offset: 35,
                              isVisible: _showContent,
                              child: _section(context, l10n.newestProducts, latestProducts.map((p) => p as BookModel).toList()),
                            ),
                          if (offerProducts != null && offerProducts.isNotEmpty)
                            AnimatedSection(
                              duration: const Duration(milliseconds: 1800),
                              curve: Curves.easeOutCubic,
                              offset: 30,
                              isVisible: _showContent,
                              child: _section(context, l10n.featuredProducts, offerProducts.map((p) => p as BookModel).toList()),
                            ),
                          if (featuredProducts != null && featuredProducts.isNotEmpty)
                            AnimatedSection(
                              duration: const Duration(milliseconds: 2000),
                              curve: Curves.easeOutCubic,
                              offset: 25,
                              isVisible: _showContent,
                              child: _section(context, l10n.suggestedProducts, featuredProducts.map((p) => p as BookModel).toList()),
                            ),
                          if (audioBooks != null && audioBooks.isNotEmpty)
                            AnimatedSection(
                              duration: const Duration(milliseconds: 2200),
                              curve: Curves.easeOutCubic,
                              offset: 20,
                              isVisible: _showContent,
                              child: _section(context, l10n.weeklySuggestion, audioBooks),
                            ),
                          if (textBooks != null && textBooks.isNotEmpty)
                            AnimatedSection(
                              duration: const Duration(milliseconds: 2400),
                              curve: Curves.easeOutCubic,
                              offset: 15,
                              isVisible: _showContent,
                              child: _section(context, l10n.newTextBooks, textBooks),
                            ),
                          if (audioBooks != null && audioBooks.isNotEmpty)
                            AnimatedSection(
                              duration: const Duration(milliseconds: 2600),
                              curve: Curves.easeOutCubic,
                              offset: 10,
                              isVisible: _showContent,
                              child: _section(context, l10n.newAudioBooks, audioBooks),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName, style: context.textTheme.headlineMedium),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            child: ShimmerLoading(
              width: double.infinity,
              height: 50,
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          const ShimmerSlider(),
          const SizedBox(height: AppSpacing.s30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.s12),
                  child: const ShimmerCategory(),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            child: ShimmerLoading(
              width: 150,
              height: 24,
            ),
          ),
          const SizedBox(height: AppSpacing.s12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
                  child: const ShimmerBookCard(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title, List<BookModel> books) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: AppSpacing.s12),
          AspectRatio(
            aspectRatio: 16 / 11,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
                  child: OtherBooksByAuthorWidget(
                    onTap: () => ProductRoute(books[index]).push(context),
                    bookModel: books[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isPdfContent(ProductModel product) {
    // Check if type is "1" (PDF type from API)
    if (product.type == '1') {
      return true;
    }
    // Check if file extension is .pdf
    final fileUrl = product.file ?? product.epub;
    if (fileUrl != null && fileUrl.toLowerCase().endsWith('.pdf')) {
      return true;
    }
    return false;
  }

  bool _canReadPdf(ProductModel product) {
    if (!_isPdfContent(product)) return false;
    final isPurchased = product.isPurchased ?? false;
    final isPremiumUser = PremiumHelper.isPremiumUser();
    final hasSubscription = product.hasSubscription ?? false;
    
    // قدم اول: اگر کتاب را خریده، دسترسی کامل
    if (isPurchased) {
      return product.file != null && product.file!.isNotEmpty;
    }
    
    // قدم دوم: اگر کتاب را نخریده ولی subscription دارد و کاربر پریمیوم است
    if (hasSubscription && isPremiumUser) {
      return product.file != null && product.file!.isNotEmpty;
    }
    
    // در غیر این صورت فقط نمونه
    return product.sample != null && product.sample!.isNotEmpty;
  }

  void _openPdf(String url, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomPdfViewer(
          pdfUrl: url,
          product: product,
          isSample: !(product.isPurchased ?? false) && 
                    !(PremiumHelper.isPremiumUser() && (product.hasSubscription ?? false)),
          themeColor: context.colorScheme.primary,
        ),
      ),
    );
  }

  void _onBookTap(ProductModel product) {
    debugPrint('Opening book: ${product.id} - ${product.name}');
    debugPrint('Product epub: ${product.epub}');
    debugPrint('Product sampleEpub: ${product.sampleEpub}');

    // If it's an audio book, show the player sheet
    if (product.type == 'audio') {
      showPlayerSheet(context, product);
      return;
    }

    // If it's a PDF, open it with url_launcher
    if (_isPdfContent(product)) {
      if (_canReadPdf(product)) {
        final isPurchased = product.isPurchased ?? false;
        final isPremiumUser = PremiumHelper.isPremiumUser();
        final hasSubscription = product.hasSubscription ?? false;
        
        String? pdfUrl;
        
        if (isPurchased) {
          pdfUrl = product.file;
        } else if (hasSubscription && isPremiumUser) {
          pdfUrl = product.file;
        } else {
          pdfUrl = product.sample;
        }
        
        if (pdfUrl != null && pdfUrl.isNotEmpty) {
          _openPdf(pdfUrl, product);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.pdfNotAvailable),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.pdfNotAvailable),
          ),
        );
      }
      return;
    }

    ReadingProgressModel? progress;
    try {
      progress = _readingProgress.firstWhere(
        (p) => p.product.id == product.id,
      );
    } catch (e) {
      progress = null;
    }
    
    if (progress != null) {
      debugPrint('Found saved progress for book ${product.id}');
      debugPrint('Saved epub: ${progress.product.epub}');
      debugPrint('Saved sampleEpub: ${progress.product.sampleEpub}');
      debugPrint('Saved lastPosition: ${progress.lastPosition}');
    }

    final epubUrl = product.epub ?? progress?.product.epub;
    final sampleEpubUrl = product.sampleEpub ?? progress?.product.sampleEpub;
    final lastPosition = progress?.lastPosition ?? 0;

    debugPrint('Selected epub URL: $epubUrl');
    debugPrint('Selected sampleEpub URL: $sampleEpubUrl');
    debugPrint('Selected lastPosition: $lastPosition');

    if (epubUrl == null || epubUrl.isEmpty) {
      if (sampleEpubUrl == null || sampleEpubUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorOpeningBook),
          ),
        );
        return;
      }
    }

    GetIt.I<EpubHandler>().openEpub(
      epubUrl ?? sampleEpubUrl!,
      context,
      product,
      isSample: product.type == 'sample',
      lastPosition: lastPosition,
    );
  }
}
