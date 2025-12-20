import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';

import '../../core/theme/const.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          IntroWidget(
              pageController: pageController,
              image: Assets.intro1,
              text:
                  'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد '),
          IntroWidget(
              image: Assets.intro2,
              pageController: pageController,
              text:
                  'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد '),
        ],
      ),
    );
  }
}

class IntroWidget extends StatelessWidget {
  final String image;
  final String text;
  final PageController pageController;

  const IntroWidget(
      {required this.pageController,
      super.key,
      required this.image,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          right: AppSpacing.s24,
          left: AppSpacing.s24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: context.fullHeight / 10,
              ),
              AspectRatio(
                aspectRatio: 1.1,
                child: UniversalImageLoader(
                  path: image,
                ),
              ).addVerticalSpacing(AppSpacing.s24),
              Text(
                text,
                textAlign: TextAlign.start,
                style: context.textTheme.bodyMedium,
              )
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: -150,
            right: -150,
            child: ClipPath(
              clipper: SemiCircleClipper(),
              child: Container(
                height: context.fullHeight / 5.5,
                color: context.colorScheme.primary,
              ),
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s32 * 1.5),
              child: OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(context.colorScheme.onPrimary),
                    side: WidgetStatePropertyAll(
                        BorderSide(color: context.colorScheme.onPrimary)),
                  ),
                  onPressed: () {
                    if (image == Assets.intro2) {
                      const LoginRoute().go(context);
                    } else {
                      pageController.nextPage(
                          duration: AppDuration.standardDuration,
                          curve: Curves.linear);
                    }
                  },
                  child: const Text('مرحله بعدی')),
            )),
      ],
    );
  }
}

class SemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, -size.height / 2, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
