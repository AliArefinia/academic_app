import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/main_button.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../../core/helper/app_helper.dart';
import '../../core/helper/image_ur_handler.dart';
import 'logic/reply_to_book_clipping_cubit.dart';
import 'package:academic/core/storage/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/data/api/auth/model/auth_response_model.dart';

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

  String _getUserFullName(UserModel? user) {
    if (user == null) return l10n.user;
    final name = user.name?.trim() ?? '';
    final lastName = user.lastName?.trim() ?? '';
    if (name.isEmpty && lastName.isEmpty) {
      return user.phone ?? l10n.user;
    }
    return [name, lastName].where((s) => s.isNotEmpty).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReplytobookclippingCubit, ReplytobookclippingState>(
      builder: (context, state) {
        final cubit = context.read<ReplytobookclippingCubit>();
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.replyToBookClipping),
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
                      text: l10n.send,
                      textColor: context.colorScheme.secondary,
                      backgroundColor: context.colorScheme.primary,
                      onPressed: () {
                        final user = GetIt.I<LocalStorage>().getUser();
                        final personNameAndFamily = _getUserFullName(user);
                        ShareviewRoute(
                          userNameAndFamily: userNameAndFamily,
                          userImage: userImage,
                          userDescription: userDescription,
                          date: date,
                          opinion: cubit.textEditingController.text,
                          numOfComment: numOfComment,
                          numOfLike: numOfLike,
                          todayDate: '12 آبان 1403',
                          personNameAndFamily: personNameAndFamily,
                        ).pushReplacement(context);
                      },
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
              child: ClipOval(
                child: UniversalImageLoader(
                  path: buildImageUrl(userImage) ?? userImage,
                  option: UniversalImageLoaderOption(
                    width: AppRadius.corner25 * 2,
                    height: AppRadius.corner25 * 2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.corner8),
        child: UniversalImageLoader(
          path: buildImageUrl(image) ?? image,
          option: UniversalImageLoaderOption(
            width: 80,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
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
          hintText: l10n.yourComment,
          hintStyle: context.textTheme.bodyMedium,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
