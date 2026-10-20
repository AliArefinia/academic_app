import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:academic/data/api/subscription/model/user_subscription_model.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'logic/my_subscriptions_cubit.dart';

class MysubscriptionsPage extends StatelessWidget {
  const MysubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MysubscriptionsCubit, MysubscriptionsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: l10n.subscriptionHistory,
            icon: Icons.subscriptions_rounded,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (subscriptions, selectedIndex) => Column(
              children: [
                const SizedBox(height: AppSpacing.s12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTabButton(context, l10n.activeSubscription, 0, selectedIndex),
                      _buildTabButton(context, l10n.expiredStatus, 1, selectedIndex),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _buildContent(context, selectedIndex, subscriptions),
                ),
              ],
            ),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.errorWithMessage(message.toString())),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<MysubscriptionsCubit>()
                        .fetchUserSubscriptions(),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabButton(
      BuildContext context, String text, int index, int selectedIndex) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<MysubscriptionsCubit>().selectTab(index);
        },
        child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color:
                isSelected ? context.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.corner20),
            border: Border.all(
              color: isSelected ? context.colorScheme.primary : Colors.grey,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: context.textTheme.labelMedium?.copyWith(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, int selectedIndex,
      List<UserSubscriptionModel> subscriptions) {
    switch (selectedIndex) {
      case 0:
        final activeSubscriptions = subscriptions
            .where((sub) => sub.subscriptionStatus == SubscriptionStatus.active)
            .toList();
        if (activeSubscriptions.isEmpty) {
          return Activesubscription(
            title: l10n.appSubscription,
            description:
                l10n.subscriptionDescription,
          );
        } else {
          return ActiveSubscriptionsList(subscriptions: activeSubscriptions);
        }
      case 1:
        final expiredSubscriptions = subscriptions
            .where(
                (sub) => sub.subscriptionStatus == SubscriptionStatus.expired)
            .toList();
        return ExpiredSubscriptions(subscriptions: expiredSubscriptions);
      default:
        return const SizedBox();
    }
  }
}

class ActiveSubscriptionsList extends StatelessWidget {
  final List<UserSubscriptionModel> subscriptions;

  const ActiveSubscriptionsList({
    super.key,
    required this.subscriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.s24),
          Text(
            l10n.activeSubscriptions,
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.s16),
          Expanded(
            child: ListView.builder(
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];
                return ActiveSubscriptionCard(subscription: subscription);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveSubscriptionCard extends StatelessWidget {
  final UserSubscriptionModel subscription;

  const ActiveSubscriptionCard({
    super.key,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s16),
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner16),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.corner12),
                ),
                child: Center(
                  child: Text(
                    subscription.title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s4),
                    Text(
                      l10n.activeSubscription,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s12),
          Row(
            children: [
              Text(l10n.startDate, style: context.textTheme.bodySmall),
              const SizedBox(width: AppSpacing.s36),
              Text(subscription.purchaseDate,
                  style: context.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: AppSpacing.s8),
          Row(
            children: [
              Text(l10n.expiryDate, style: context.textTheme.bodySmall),
              const SizedBox(width: AppSpacing.s36),
              Text(subscription.expiryDate, style: context.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: AppSpacing.s12),
          Container(
            width: context.fullWidth * 0.385,
            height: context.fullHeight * 0.048,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(AppRadius.corner16),
            ),
            child: Text(
              l10n.active,
              style: context.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Activesubscription extends StatelessWidget {
  final String title;
  final String description;

  const Activesubscription({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.s24),
          SvgPicture.asset(
            Assets.pcBell,
          ),
          const SizedBox(height: AppSpacing.s16),
          Text(
            title,
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.s16),
          SizedBox(
            height: context.fullHeight * 0.095,
            child: Text(description,
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: AppSpacing.s52),
          const SizedBox(height: AppSpacing.s10),
          SizedBox(
            height: context.fullHeight * 0.065,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/buySubscriptionRoute');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.corner20),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.s12),
              ),
              child: Text(
                l10n.buyPremiumSubscription,
                style: context.textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ExpiredSubscriptions extends StatelessWidget {
  final List<UserSubscriptionModel> subscriptions;

  const ExpiredSubscriptions({
    super.key,
    required this.subscriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.s24),
          Text(
            l10n.expiredSubscriptions,
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.s16),
          if (subscriptions.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: AppSpacing.s16),
                    Text(
                      l10n.noExpiredSubscriptions,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: subscriptions.length,
                itemBuilder: (context, index) {
                  final subscription = subscriptions[index];
                  return ExpiredSubscriptionCard(subscription: subscription);
                },
              ),
            ),
        ],
      ),
    );
  }
}


class ExpiredSubscriptionCard extends StatelessWidget {
  final UserSubscriptionModel subscription;

  const ExpiredSubscriptionCard({
    super.key,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s16),
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner16),
        border: Border.all(color: context.subtleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subscription.title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.s12),
          Row(
            children: [
              Text(l10n.startDate, style: context.textTheme.bodySmall),
              const SizedBox(width: AppSpacing.s36),
              Text(subscription.purchaseDate,
                  style: context.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: AppSpacing.s8),
          Row(
            children: [
              Text(l10n.expiryDate, style: context.textTheme.bodySmall),
              const SizedBox(width: AppSpacing.s36),
              Text(subscription.expiryDate, style: context.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: AppSpacing.s12),
          Container(
            width: context.fullWidth * 0.385,
            height: context.fullHeight * 0.048,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(AppRadius.corner16),
            ),
            child: Text(
              l10n.expiredStatus,
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
