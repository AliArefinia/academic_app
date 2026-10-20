import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/main_button.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String? trackingCode;
  final int amount;
  final String paymentType;
  final String? orderNumber;
  final String? transactionId;
  final List<Map<String, dynamic>>? items;

  const PaymentSuccessPage({
    super.key,
    this.trackingCode,
    required this.amount,
    required this.paymentType,
    this.orderNumber,
    this.transactionId,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.s24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              // Success Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 32),

              // Success Title
              Text(
                l10n.paymentDone,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Payment Details
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color ?? context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.shadow.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildDetailRow(context, l10n.paymentType, _getPaymentTypeText()),
                    const Divider(),
                    _buildDetailRow(context, l10n.amount, l10n.amountToman(amount.toString())),
                    if (orderNumber != null) ...[
                      const Divider(),
                      _buildDetailRow(context, l10n.orderNumber, orderNumber!),
                    ],
                    if (transactionId != null) ...[
                      const Divider(),
                      _buildDetailRow(context, l10n.transactionId, transactionId!),
                    ],
                    if (trackingCode != null) ...[
                      const Divider(),
                      _buildDetailRow(context, l10n.trackingCode, trackingCode!),
                    ],
                    if (items != null && items!.isNotEmpty) ...[
                      const Divider(),
                      _buildClickableItemsSection(context),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Column(
                children: [
                  MainButton(
                    text: l10n.backToHome,
                    backgroundColor: context.colorScheme.primary,
                    textColor: context.colorScheme.onPrimary,
                    onPressed: () => _navigateToHome(context),
                  ),
                  const SizedBox(height: 12),
                  MainButton(
                    text: _getSecondaryButtonText(),
                    backgroundColor: Colors.transparent,
                    textColor: context.colorScheme.primary,
                    onPressed: () => _handleSecondaryButtonAction(context),
                  ),
                ],
              ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableItemsSection(BuildContext context) {
    return GestureDetector(
      onTap: () => _showItemsBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.colorScheme.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: context.colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.purchasedItems,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.itemsCountTapToView(items!.length),
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.colorScheme.primary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showItemsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.onSurfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: context.colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n.purchasedItems,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Items list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  final item = items![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.shadow.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.book_outlined,
                            color: context.colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.productWithValue(item['product_id'] ?? l10n.unknown),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.productIdWithValue(item['product_id'] ?? l10n.unknown),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              l10n.amountToman(item['price'] ?? 0),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                l10n.purchased,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: context.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.totalPayment,
                          style: TextStyle(
                            fontSize: 14,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          l10n.amountToman(amount.toString()),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      l10n.itemsCount(items!.length),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onPrimary,
                      ),
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

  String _getPaymentTypeText() {
    switch (paymentType) {
      case 'book':
        return l10n.bookPurchase;
      case 'subscription':
        return l10n.buySubscription;
      case 'gift_card':
        return l10n.giftCardPurchase;
      case 'wallet':
        return l10n.walletCharge;
      case 'unknown':
        return l10n.pay;
      default:
        return l10n.pay;
    }
  }

  String _getSecondaryButtonText() {
    print('DEBUG: PaymentSuccessPage paymentType: $paymentType');
    switch (paymentType) {
      case 'book':
        return l10n.viewMyBooks;
      case 'subscription':
        return l10n.viewMySubscriptions;
      case 'gift_card':
        return l10n.viewGiftCards;
      case 'wallet':
        return l10n.viewWallet;
      case 'unknown':
        return l10n.viewPaymentHistory;
      default:
        print('DEBUG: Unknown paymentType: $paymentType, using default');
        return l10n.viewPaymentHistory;
    }
  }

  void _handleSecondaryButtonAction(BuildContext context) {
    switch (paymentType) {
      case 'book':
        context.push('/myBooks');
        break;
      case 'subscription':
        context.go('/mySubscriptionsRoute');
        break;
      case 'gift_card':
        context.push('/giftCardRoute');
        break;
      case 'wallet':
        context.push('/wallet');
        break;
      case 'unknown':
        context.push('/paymentHistory');
        break;
      default:
        context.push('/paymentHistory');
        break;
    }
  }

  void _navigateToHome(BuildContext context) {
    try {
      // First, pop all routes until we reach the first route
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        navigator.popUntil((route) => route.isFirst);
      }
      
      // Then navigate to home using GoRouter
      Future.microtask(() {
        if (context.mounted) {
          context.go('/home');
        }
      });
    } catch (e) {
      print('⚠️ Navigation error in PaymentSuccessPage: $e');
      // Fallback: try direct GoRouter access
      try {
        Future.microtask(() {
          if (context.mounted) {
            GoRouter.of(context).go('/home');
          }
        });
      } catch (goRouterError) {
        print('⚠️ GoRouter navigation failed: $goRouterError');
        // Last resort: try to pop and then navigate
        try {
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          }
          Future.microtask(() {
            if (context.mounted) {
              GoRouter.of(context).go('/home');
            }
          });
        } catch (finalError) {
          print('⚠️ Final navigation fallback failed: $finalError');
        }
      }
    }
  }
}
