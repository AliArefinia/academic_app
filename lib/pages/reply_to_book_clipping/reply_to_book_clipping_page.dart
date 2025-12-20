import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/main_button.dart';
import '../../core/helper/app_helper.dart';
import 'logic/reply_to_book_clipping_cubit.dart';

class ReplytobookclippingPage extends StatelessWidget {
  final String bookImage;
  final String userNameAndFamily;
  final String date;
  final String userDescription;
  final String userImage;
  final int? numOfLike;
  final int? numOfComment;

  const ReplytobookclippingPage(
      {super.key,
      required this.bookImage,
      required this.userNameAndFamily,
      required this.date,
      required this.userImage,
      this.numOfLike,
      this.numOfComment,
      required this.userDescription});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReplytobookclippingCubit, ReplytobookclippingState>(
      builder: (context, state) {
        final cubit = context.read<ReplytobookclippingCubit>();
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('پاسخ به بریده کتاب'),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                child: Column(
                  spacing: AppSpacing.s20,
                  children: [
                    TopContainer(
                      bookImage: bookImage,
                      userNameAndFamily: userNameAndFamily,
                      date: date,
                      userImage: userImage,
                    ),
                    TextFieldContainer(
                      textEditingController: cubit.textEditingController,
                    ),
                    MainButton(
                      textSize: 16,
                      text: 'ارسال',
                      textColor: context.colorScheme.secondary,
                      backgroundColor: context.colorScheme.primary,
                      onPressed: () => ShareviewRoute(
                        userNameAndFamily: userNameAndFamily,
                        userImage: userImage,
                        userDescription: userDescription,
                        date: date,
                        opinion: cubit.textEditingController.text,
                        numOfComment: numOfComment,
                        numOfLike: numOfLike,
                        todayDate: '12 آبان 1403',
                        personNameAndFamily: 'تینا یاوری',
                      ).pushReplacement(context),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TopContainer extends StatelessWidget {
  final String bookImage;
  final String userNameAndFamily;
  final String date;
  final String userImage;

  const TopContainer(
      {super.key,
      required this.bookImage,
      required this.userNameAndFamily,
      required this.date,
      required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner10),
      ),
      width: double.infinity,
      height: context.fullHeight * 0.15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
        child: Row(
          children: [
            ProfileSection(
              userNameAndFamily: userNameAndFamily,
              date: date,
              userImage: userImage,
            ),
            const Spacer(),
            BookImageSection(image: bookImage)
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String userNameAndFamily;
  final String date;
  final String userImage;

  const ProfileSection(
      {super.key,
      required this.userNameAndFamily,
      required this.date,
      required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.s8,
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ]),
          child: CircleAvatar(
            radius: AppRadius.corner30,
            backgroundColor: context.colorScheme.background,
            child: CircleAvatar(
              radius: AppRadius.corner25,
              child: Image.asset(userImage),
            ),
          ),
        ),
        Column(
          spacing: AppSpacing.s4,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userNameAndFamily,
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xff558219),
              ),
            ),
            Text(
              date,
              style: context.textTheme.labelMedium,
            )
          ],
        )
      ],
    );
  }
}

class BookImageSection extends StatelessWidget {
  final String image;

  const BookImageSection({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.corner8),
          ),
          child: Image.asset(image)),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final TextEditingController textEditingController;

  const TextFieldContainer({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.corner10),
        color: context.colorScheme.surface,
      ),
      width: double.infinity,
      height: context.fullHeight * 0.25,
      child: TextField(
        controller: textEditingController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: context.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'نظر شما',
          hintStyle: context.textTheme.bodyMedium,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
