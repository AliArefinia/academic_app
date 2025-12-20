import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/gen/assets.gen.dart';
import 'package:academic/data/api/subscription/model/subscription_plan_model.dart';
import 'package:academic/core/services/payment_service.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:get_it/get_it.dart';
import 'logic/buy_subscription_cubit.dart';

class BuysubscriptionPage extends StatelessWidget {
  const BuysubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuysubscriptionCubit, BuysubscriptionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "خرید اشتراک",
            icon: Icons.credit_card_rounded,
          ),
          body: state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (plans, expandedItems) =>
                _buildContent(context, plans, expandedItems),
            error: (message) => ErrorStateWidget(
              error: message,
              onRetry: () => context
                  .read<BuysubscriptionCubit>()
                  .fetchSubscriptionPlans(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, List<SubscriptionPlanModel> plans,
      Map<int, bool> expandedItems) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.s32),
          GridView.builder(
            padding: EdgeInsets.symmetric(
                vertical: AppSpacing.s10, horizontal: AppSpacing.s20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 60,
              childAspectRatio: 1.0,
            ),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return SubscriptionCard(
                plan: plan,
                onTap: () => _handleSubscriptionPurchase(context, plan),
              );
            },
          ),
          const SizedBox(height: AppSpacing.s30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            child: Column(
              children: [
                CustomExpandableTile(
                  text: "سوالات متداول",
                  expandedText: "پاسخ سوالات متداول در اینجا قرار می‌گیرد...",
                  index: 0,
                  isExpanded: expandedItems[0] ?? false,
                ),
                const SizedBox(height: AppSpacing.s16),
                CustomExpandableTile(
                  text: "قوانین و مقررات",
                  expandedText:
                      "قوانین و مقررات اشتراک در اینجا قرار می‌گیرد...",
                  index: 1,
                  isExpanded: expandedItems[1] ?? false,
                ),
                const SizedBox(height: AppSpacing.s16),
                CustomExpandableTile(
                  text: "شرایط استفاده",
                  expandedText:
                      "شرایط استفاده از اشتراک در اینجا قرار می‌گیرد...",
                  index: 2,
                  isExpanded: expandedItems[2] ?? false,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s48),
        ],
      ),
    );
  }

  void _handleSubscriptionPurchase(
      BuildContext context, SubscriptionPlanModel plan) async {
    try {
      final paymentService = GetIt.I<PaymentService>();
      await paymentService.processSubscriptionPayment(
        amount: plan.price,
        planId: plan.id,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا در پردازش پرداخت: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class CustomExpandableTile extends StatelessWidget {
  final String text;
  final String expandedText;
  final int index;
  final bool isExpanded;

  const CustomExpandableTile({
    super.key,
    required this.text,
    required this.expandedText,
    required this.index,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.s12,
        horizontal: AppSpacing.s16,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.read<BuysubscriptionCubit>().toggleExpansion(index);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.s10),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(
                    isExpanded ? Assets.icNegative : Assets.icPositive,
                    key: ValueKey(isExpanded),
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(height: AppSpacing.s20),
            Text(
              expandedText,
              style: context.textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionPlanModel plan;
  final VoidCallback onTap;

  const SubscriptionCard({
    super.key,
    required this.plan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.fullWidth * 0.435,
        height: context.fullHeight * 0.28,
        padding: const EdgeInsets.all(AppSpacing.s12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner16),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 40),
                // عنوان اشتراک
                Text(
                  plan.title,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                // قیمت
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "${plan.formattedPrice} ",
                          style: context.textTheme.headlineMedium
                              ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "تومان",
                          style: context.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                // دکمه خرید
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.corner12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Text("خرید اشتراک",
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ],
            ),
            // دایره بالایی
            Positioned(
              top: -35,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "${plan.days} روز",
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
