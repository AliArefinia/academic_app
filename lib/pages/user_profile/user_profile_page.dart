import 'package:academic/l10n/l10n.dart';
import 'package:academic/core/api_constants.dart';
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
              title: l10n.profile,
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
                            : '${ApiConstants.baseUrl}${user.avatar!}')
                        : null,
                    child: (user.avatar == null ||
                            user.avatar!.isEmpty)
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  Text(
                    user.name ?? l10n.user,
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
                          text: l10n.profile,
                          iconPath: Assets.icProfile,
                          onTap: () {
                            const ProfilemanagementRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: l10n.myBooks,
                          iconPath: Assets.icBooks,
                          onTap: () {
                            const MybooksRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: l10n.myPurchases,
                          iconPath: Assets.icShop,
                          onTap: () {
                            const MypurchasesRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: l10n.mySubscriptions,
                          iconPath: Assets.icWallet,
                          onTap: () {
                            const MysubscriptionsRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: l10n.buySubscription,
                          iconPath: Assets.icShop,
                          onTap: () {
                            const BuysubscriptionRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          onTap: () =>
                              const MycommentsmainRoute().push(context),
                          text: l10n.myCommentsMenu,
                          iconPath: Assets.icStar,
                        ),
                        ReusableDropdownMenu(
                          onTap: () => const StudyTourListRoute().push(context),
                          text: l10n.studyTour,
                          iconPath: Assets.icBookId,
                        ),
                        ReusableDropdownMenu(
                          text: l10n.myClippingsMenu,
                          iconPath: Assets.icSave,
                          onTap: () {
                            const MyClippingsRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: l10n.bookTour,
                          iconPath: Assets.icBooks,
                          onTap: () {
                            const BooktourRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: l10n.myNoteCards,
                          iconPath: Assets.icFolder,
                          onTap: () {
                            const MychaptersRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: l10n.giftCard,
                          iconPath: Assets.icWallet,
                          onTap: () {
                            const GiftcardRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          text: l10n.paymentHistory,
                          iconPath: Assets.icPayment,
                          onTap: () {
                            const PaymenthistoryRoute().push(context);
                          },
                        ),
                        ReusableDropdownMenu(
                          isIconDifference: true,
                          onTap: () => const InvitefriendsRoute().push(context),
                          text: l10n.inviteFriends,
                          iconPath: Assets.icPeople,
                        ),
                        ReusableDropdownMenu(
                          text: l10n.settings,
                          iconPath: Assets.icFilter,
                          onTap: () => const SettingsRoute().push(context),
                        ),
                        ReusableDropdownMenu(
                          text: l10n.update,
                          iconPath: Assets.icUpdate,
                        ),
                        ReusableDropdownMenu(
                          text: l10n.logout,
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
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
