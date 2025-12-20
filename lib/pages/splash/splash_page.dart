import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/router/router.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../../gen/assets.gen.dart';
import 'logic/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Add a small delay to ensure the UI is ready
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        context.read<SplashCubit>().checkAuthStatus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: () {
            const HomeRouteData().go(context);
          },
          unauthenticated: () {
            const LoginRoute().go(context);
          },
          error: (message) {
            // On error, clear data and go to login
            const LoginRoute().go(context);
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: UniversalImageLoader(
                    path: Assets.icLogo.path,
                    option: const UniversalImageLoaderOption(
                      width: 100,
                      fit: BoxFit.contain,
                      height: 100,
                    ),
                  ),
                ),
                if (state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ))
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3.0,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
