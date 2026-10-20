import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/utils/price_parser.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/custom_outlined_button.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import '../../data/api/my_purchases/model/my_purchases_model.dart';
import 'logic/my_purchases_cubit.dart';
import 'logic/my_purchases_state.dart';

class MypurchasesPage extends StatelessWidget {
  const MypurchasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MypurchasesCubit, MypurchasesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (purchases) => Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: CustomAppBar(
                    title: l10n.myPurchases,
                    leading: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.s10),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final purchase = purchases[index];
                        return PurchaseItem(
                          purchase: purchase,
                        );
                      },
                      childCount: purchases.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.s10),
                      CustomOutlinedButton(
                        text: l10n.viewAll,
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSpacing.s48),
                    ],
                  ),
                ),
              ],
            ),
          ),
          empty: () => Center(child: Text(l10n.noPurchases)), 
          error: (msg) => Center(child: Text(l10n.errorWithMessage(msg.toString()))),
        );
      },
    );
  }
}

class PurchaseItem extends StatelessWidget {
  final PurchaseItemModel purchase;

  const PurchaseItem({
    super.key,
    required this.purchase,
  });

  bool get isSuccessful => purchase.status == 'موفق';

  @override
  Widget build(BuildContext context) {
    final parsedAmount = PriceParser.parseToDouble(purchase.amount);
    final formattedAmount = parsedAmount != null && parsedAmount > 0
        ? PriceParser.formatPrice(parsedAmount)
        : '0';

    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s16, vertical: AppSpacing.s8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.corner12),
      ),
      elevation: 0,
      color: context.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Status and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Badge
                _StatusBadge(status: purchase.status ?? ''),
                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formattedAmount,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      l10n.toman,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s16),
            // Divider
            Divider(
              height: 1,
              thickness: 1,
              color: context.colorScheme.outline.withOpacity(0.2),
            ),
            const SizedBox(height: AppSpacing.s16),
            // Details Section
            _DetailRow(
              icon: Icons.receipt_long,
              label: l10n.trackingCode,
              value: purchase.trackingCode ?? '-',
            ),
            const SizedBox(height: AppSpacing.s12),
            _DetailRow(
              icon: Icons.calendar_today,
              label: l10n.purchaseDate,
              value: purchase.date ?? '-',
            ),
            if (purchase.discountAmount != null &&
                PriceParser.parseToDouble(purchase.discountAmount) != null &&
                PriceParser.parseToDouble(purchase.discountAmount)! > 0) ...[
              const SizedBox(height: AppSpacing.s12),
              _DetailRow(
                icon: Icons.discount,
                label: l10n.discount,
                value:
                    l10n.amountToman(PriceParser.formatPrice(PriceParser.parseToDouble(purchase.discountAmount))),
                valueColor: context.colorScheme.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  bool get isSuccessful => status == 'موفق';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s12,
        vertical: AppSpacing.s6,
      ),
      decoration: BoxDecoration(
        color: isSuccessful
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.corner20),
        border: Border.all(
          color: isSuccessful
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccessful ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isSuccessful ? Colors.green : Colors.red,
          ),
          const SizedBox(width: AppSpacing.s4),
          Text(
            status,
            style: context.textTheme.labelMedium?.copyWith(
              color: isSuccessful ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: context.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: AppSpacing.s8),
        Text(
          '$label: ',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              color: valueColor ?? context.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
