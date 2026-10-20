import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/invite_friends_model.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:academic/widgets/main_button.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'logic/invite_friends_cubit.dart';
import 'widgets/gifts_widgets.dart';

class InvitefriendsPage extends StatelessWidget {
  const InvitefriendsPage({super.key});

  Widget _buildInvitedFriendItem(BuildContext context, InvitedFriendsModel friend) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s8),
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner12),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: context.colorScheme.primaryContainer,
            child: Text(
              friend.name.isNotEmpty ? friend.name[0].toUpperCase() : 'U',
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.invited,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: context.colorScheme.primary,
            size: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitefriendsCubit, InvitefriendsState>(
      builder: (context, state) {
        final cubit = context.read<InvitefriendsCubit>();
        return Scaffold(
          appBar: CustomAppBar(
            title: l10n.inviteFriends,
            icon: Icons.person_add_rounded,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.s12),
                    child:
                        Center(child: SvgPicture.asset(Assets.icInviteFriends)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.s20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TabButton(
                          tabName: l10n.invite,
                          isActive: state.currentTab == 'invite',
                          onTap: () => cubit.onTabTap('invite'),
                        ),
                        _TabButton(
                          tabName: l10n.rewards,
                          isActive: state.currentTab == 'rewards',
                          onTap: () => cubit.onTabTap('rewards'),
                        ),
                      ],
                    ),
                  ),
                  if (state.currentTab == 'invite')
                    Column(
                      children: [
                        const MidSection(),
                        BottomInviteCodeContainer(
                          inviteCode: state.inviteCode ?? l10n.inviteCodeUnavailable,
                        ),
                        const SizedBox(height: AppSpacing.s24),
                        // عنوان بخش لیست دعوت‌ها
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.s16),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(AppRadius.corner12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                l10n.invitedFriendsList,
                                style: context.textTheme.headlineSmall?.copyWith(
                                  color: context.colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (!state.isLoading && state.errorMessage == null)
                                Text(
                                  l10n.totalPeopleCount(state.invitedFriends.length),
                                  style: context.textTheme.titleMedium?.copyWith(
                                    color: context.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s16),
                        // لیست دعوت‌های کاربر
                        if (state.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (state.errorMessage != null)
                          ErrorStateWidget(
                            error: state.errorMessage,
                            compact: true,
                            onRetry: () => cubit.loadInvitedFriends(),
                          )
                        else if (state.invitedFriends.isEmpty)
                          EmptyStateWidget(
                            title: l10n.noInvitations,
                            message: l10n.noFriendsInvitedYet,
                            iconAsset: Assets.icInviteFriends,
                            compact: true,
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.invitedFriends.length,
                            itemBuilder: (context, index) {
                              final friend = state.invitedFriends[index];
                              return _buildInvitedFriendItem(context, friend);
                            },
                          ),
                      ],
                    )
                  else if (state.currentTab == 'rewards')
                    if (state.isGiftsLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (state.giftsErrorMessage != null)
                      ErrorStateWidget(
                        error: state.giftsErrorMessage,
                        compact: true,
                        onRetry: () => cubit.loadGifts(),
                      )
                    else if (state.gifts.isEmpty)
                      EmptyStateWidget(
                        title: l10n.noRewards,
                        message: l10n.noRewardsToShow,
                        iconAsset: Assets.icGift,
                        compact: true,
                      )
                    else
                      GiftsSection(gifts: state.gifts),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TabButton extends StatelessWidget {
  final String tabName;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.tabName,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary : colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(AppRadius.corner6),
        ),
        height: AppSpacing.s48,
        width: context.fullWidth * 0.4,
        alignment: Alignment.center,
        child: Text(
          tabName,
          style: context.textTheme.headlineSmall?.copyWith(
            color: isActive ? colorScheme.onPrimary : colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}

class MidSection extends StatelessWidget {
  const MidSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.s16),
        Text(
          l10n.inviteFriendsReadFree,
          style: context.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s16),
        SvgPicture.asset(Assets.pcPersonInvite),
        const SizedBox(height: AppSpacing.s16),
        Text(
          l10n.inviteFriendsDescription,
          style: context.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s16),
      ],
    );
  }
}

class BottomInviteCodeContainer extends StatelessWidget {
  final String inviteCode;

  const BottomInviteCodeContainer({super.key, required this.inviteCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.corner20),
              border: Border.all(color: context.colorScheme.outline, width: 1),
            ),
            width: double.infinity,
            height: context.fullHeight * 0.07,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    inviteCode,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CopyInviteCodeButton(inviteCode: inviteCode),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CopyInviteCodeButton extends StatelessWidget {
  final String inviteCode;

  const CopyInviteCodeButton({super.key, required this.inviteCode});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: inviteCode));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: colorScheme.primary,
            content: Text(l10n.inviteCodeCopied),
          ),
        );
      },
      child: Container(
        margin:
            const EdgeInsets.symmetric(vertical: AppSpacing.s4, horizontal: 4),
        height: double.infinity,
        width: context.fullWidth * 0.25,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.corner16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icCopy),
            const SizedBox(width: AppSpacing.s8),
            Text(
              l10n.copy,
              style: context.textTheme.titleSmall?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotInvitedFriendSection extends StatelessWidget {
  const NotInvitedFriendSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.s24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.surfaceContainer,
              context.colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(AppRadius.corner20),
          border: Border.all(
            color: context.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.corner35),
              ),
              child: Icon(
                Icons.people_outline,
                size: 40,
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            Text(
              l10n.noFriendInvitedYet,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s8),
            Text(
              l10n.inviteFriendsBothGetFreeMonth,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s8,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(AppRadius.corner20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.share,
                    color: context.colorScheme.onPrimary,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.s8),
                  Text(
                    l10n.shareYourInviteCode,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvitedFriendsSection extends StatelessWidget {
  final List<InvitedFriendsModel> invitedFriends;
  
  const InvitedFriendsSection({super.key, required this.invitedFriends});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: invitedFriends.length,
      itemBuilder: (context, index) => InvitedFriendsWidget(
        invitedFriendsModel: invitedFriends[index],
      ),
    );
  }
}

class InvitedFriendsWidget extends StatelessWidget {
  final InvitedFriendsModel invitedFriendsModel;

  const InvitedFriendsWidget({super.key, required this.invitedFriendsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.surface,
              context.colorScheme.surfaceContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: context.colorScheme.outline.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.corner16),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Row(
          children: [
            // Avatar/Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(AppRadius.corner25),
              ),
              child: Icon(
                Icons.person,
                color: context.colorScheme.onPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.s12),
            
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invitedFriendsModel.name,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Text(
                    l10n.invitationDateWithValue(invitedFriendsModel.created_at.toString()),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            // Score badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s12,
                vertical: AppSpacing.s6,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(AppRadius.corner20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: context.colorScheme.onPrimary,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.s4),
                  Text(
                    '${invitedFriendsModel.score}',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
