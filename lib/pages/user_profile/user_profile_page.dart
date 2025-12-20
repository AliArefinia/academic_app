import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import '../../gen/assets.gen.dart';
import 'logic/user_profile_cubit.dart';
import '../../widgets/reusable_dropdown_menu.dart';
import '../../widgets/custom_app_bar.dart';

class UserprofilePage extends StatelessWidget {
  const UserprofilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserprofileCubit, UserprofileState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (user) => Scaffold(
            appBar: CustomAppBar(
              title: "پروفایل",
              icon: Icons.person_rounded,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.s24),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: (user.avatar != null &&
                            user.avatar!.isNotEmpty)
                        ? NetworkImage(user.avatar!.startsWith('http') 
                            ? user.avatar!
                            : 'https://demo.halalread.ir${user.avatar!}')
                        : null,
                    child: (user.avatar == null ||
                            user.avatar!.isEmpty)
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  Text(
                    user.name ?? 'کاربر',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (user.lastName != null && user.lastName!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.s4),
                    Text(
                      user.lastName!,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.s32),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                    child: Column(
                      children: [
                        ReusableDropdownMenu(
                          text: "پروفایل",
                          iconPath: Assets.icProfile,
                          onTap: () {
                            const ProfilemanagementRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: "کتاب های من",
                          iconPath: Assets.icBooks,
                          onTap: () {
                            const MybooksRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: "خرید های من",
                          iconPath: Assets.icShop,
                          onTap: () {
                            const MypurchasesRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: "اشتراک های من",
                          iconPath: Assets.icWallet,
                          onTap: () {
                            const MysubscriptionsRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: "خرید اشتراک",
                          iconPath: Assets.icShop,
                          onTap: () {
                            const BuysubscriptionRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          onTap: () =>
                              const MycommentsmainRoute().push(context),
                          text: "نظرات من",
                          iconPath: Assets.icStar,
                        ),
                        ReusableDropdownMenu(
                          onTap: () => const StudyTourListRoute().push(context),
                          text: "سیر مطالعاتی",
                          iconPath: Assets.icBookId,
                        ),
                        // ReusableDropdownMenu(
                        //   text: "بریده های من",
                        //   iconPath: Assets.icSave,
                        //   onTap: () {
                        //     const MyClippingsRoute().push(context);
                        //   },
                        // ),
                        ReusableDropdownMenu(
                          text: "سرفصل‌های من",
                          iconPath: Assets.icFolder,
                          onTap: () {
                            const MychaptersRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: "کارت هدیه",
                          iconPath: Assets.icWallet,
                          onTap: () {
                            const GiftcardRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: "تاریخچه پرداخت ها",
                          iconPath: Assets.icPayment,
                          onTap: () {
                            const PaymenthistoryRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          isIconDifference: true,
                          onTap: () => const InvitefriendsRoute().push(context),
                          text: "دعوت از دوستان",
                          iconPath: Assets.icPeople,
                        ),
                        ReusableDropdownMenu(
                          text: "بروز رسانی",
                          iconPath: Assets.icUpdate,
                        ),
                        ReusableDropdownMenu(
                          text: "خروج از حساب کاربری",
                          iconPath: Assets.icExit,
                          onTap: () async {
                            await context.read<UserprofileCubit>().logout();
                            const LoginRoute().go(context);
                          },
                        ),
                        SizedBox(height: AppSpacing.s30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message),
                const SizedBox(height: AppSpacing.s16),
                ElevatedButton(
                  onPressed: () =>
                      context.read<UserprofileCubit>().loadUserData(),
                  child: const Text('تلاش مجدد'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
