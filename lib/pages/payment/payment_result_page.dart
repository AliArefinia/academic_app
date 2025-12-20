import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/main_button.dart';
import 'package:intl/intl.dart';

enum PaymentStatus {
  success,
  failed,
  expired,
  cancelled,
  error,
}

class PaymentResultPage extends StatelessWidget {
  final PaymentStatus status;
  final String? trackingCode;
  final int amount;
  final String paymentType;
  final String? errorMessage;

  const PaymentResultPage({
    super.key,
    required this.status,
    this.trackingCode,
    required this.amount,
    required this.paymentType,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          // If popped, navigate to home
          Future.microtask(() {
            if (context.mounted) {
              context.go('/home');
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _navigateToHome(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Status Icon
                _buildStatusIcon(),
                const SizedBox(height: 32),

                // Status Title
                Text(
                  _getStatusTitle(),
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Status Description
                Text(
                  _getStatusDescription(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Payment Details Card
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
                      _buildDetailRow(context, 'نوع پرداخت', _getPaymentTypeText()),
                      const Divider(),
                      _buildDetailRow(context, 'مبلغ', _formatAmount(amount)),
                      if (trackingCode != null && trackingCode!.isNotEmpty) ...[
                        const Divider(),
                        _buildDetailRow(
                          context,
                          'کد پیگیری',
                          trackingCode!,
                          isCopyable: true,
                        ),
                      ],
                      if (errorMessage != null && errorMessage!.isNotEmpty) ...[
                        const Divider(),
                        _buildErrorRow(context, 'پیام خطا', errorMessage!),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Action Buttons
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    IconData icon;
    Color backgroundColor;
    Color iconColor;

    switch (status) {
      case PaymentStatus.success:
        icon = Icons.check_circle;
        backgroundColor = Colors.green.withOpacity(0.1);
        iconColor = Colors.green;
        break;
      case PaymentStatus.failed:
        icon = Icons.cancel;
        backgroundColor = Colors.red.withOpacity(0.1);
        iconColor = Colors.red;
        break;
      case PaymentStatus.expired:
        icon = Icons.access_time;
        backgroundColor = Colors.orange.withOpacity(0.1);
        iconColor = Colors.orange;
        break;
      case PaymentStatus.cancelled:
        icon = Icons.close_rounded;
        backgroundColor = Colors.grey.withOpacity(0.1);
        iconColor = Colors.grey;
        break;
      case PaymentStatus.error:
        icon = Icons.error;
        backgroundColor = Colors.red.withOpacity(0.1);
        iconColor = Colors.red;
        break;
    }

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 80,
        color: iconColor,
      ),
    );
  }

  String _getStatusTitle() {
    switch (status) {
      case PaymentStatus.success:
        return 'پرداخت موفق';
      case PaymentStatus.failed:
        return 'پرداخت ناموفق';
      case PaymentStatus.expired:
        return 'زمان پرداخت منقضی شده';
      case PaymentStatus.cancelled:
        return 'پرداخت لغو شد';
      case PaymentStatus.error:
        return 'خطا در پرداخت';
    }
  }

  String _getStatusDescription() {
    switch (status) {
      case PaymentStatus.success:
        return 'پرداخت شما با موفقیت انجام شد و خرید شما ثبت گردید';
      case PaymentStatus.failed:
        return 'متاسفانه پرداخت شما با موفقیت انجام نشد. لطفا دوباره تلاش کنید';
      case PaymentStatus.expired:
        return 'زمان پرداخت شما به پایان رسیده است. لطفا دوباره تلاش کنید';
      case PaymentStatus.cancelled:
        return 'پرداخت توسط شما لغو شد';
      case PaymentStatus.error:
        return 'خطایی در هنگام پردازش پرداخت رخ داد';
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case PaymentStatus.success:
        return Colors.green;
      case PaymentStatus.failed:
        return Colors.red;
      case PaymentStatus.expired:
        return Colors.orange;
      case PaymentStatus.cancelled:
        return Colors.grey;
      case PaymentStatus.error:
        return Colors.red;
    }
  }

  Widget _buildDetailRow(BuildContext context, String label, String value, {bool isCopyable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isCopyable) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    // Show snackbar
                  },
                  child: Icon(
                    Icons.copy,
                    size: 18,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: context.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    if (status == PaymentStatus.success) {
      return Column(
        children: [
          MainButton(
            text: 'بازگشت به صفحه اصلی',
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
      );
    } else {
      return Column(
        children: [
          MainButton(
            text: 'تلاش مجدد',
            backgroundColor: context.colorScheme.primary,
            textColor: context.colorScheme.onPrimary,
            onPressed: () => _handleRetryAction(context),
          ),
          const SizedBox(height: 12),
          MainButton(
            text: 'بازگشت به صفحه اصلی',
            backgroundColor: Colors.transparent,
            textColor: context.colorScheme.primary,
            onPressed: () => _navigateToHome(context),
          ),
        ],
      );
    }
  }

  String _getPaymentTypeText() {
    switch (paymentType) {
      case 'book':
        return 'خرید کتاب';
      case 'subscription':
        return 'خرید اشتراک';
      case 'gift_card':
        return 'خرید کارت هدیه';
      case 'wallet':
        return 'شارژ کیف پول';
      case 'unknown':
        return 'پرداخت';
      default:
        return 'پرداخت';
    }
  }

  String _getSecondaryButtonText() {
    print('DEBUG: PaymentResultPage paymentType: $paymentType');
    switch (paymentType) {
      case 'book':
        return 'مشاهده کتاب های من';
      case 'subscription':
        return 'مشاهده اشتراک های من';
      case 'gift_card':
        return 'مشاهده کارت های هدیه';
      case 'wallet':
        return 'مشاهده کیف پول';
      case 'unknown':
        return 'مشاهده کتاب های من';
      default:
        print('DEBUG: Unknown paymentType: $paymentType, using default');
        return 'مشاهده کتاب های من';
    }
  }

  void _handleSecondaryButtonAction(BuildContext context) {
    try {
      // First, pop the current route
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      // Then navigate to the target route
      Future.microtask(() {
        if (!context.mounted) return;
        
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
            context.push('/myBooks');
            break;
          default:
            context.push('/myBooks');
            break;
        }
      });
    } catch (e) {
      print('⚠️ Navigation error in _handleSecondaryButtonAction: $e');
      // Fallback: navigate to home
      if (context.mounted) {
        context.go('/home');
      }
    }
  }

  void _handleRetryAction(BuildContext context) {
    try {
      // First, pop the current route
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      // Then navigate to the target route
      Future.microtask(() {
        if (!context.mounted) return;
        
        switch (paymentType) {
          case 'book':
            context.go('/cart');
            break;
          case 'subscription':
            context.go('/mySubscriptionsRoute');
            break;
          case 'gift_card':
            context.go('/giftCardRoute');
            break;
          case 'wallet':
            context.go('/wallet');
            break;
          case 'unknown':
            context.go('/home');
            break;
          default:
            context.go('/home');
            break;
        }
      });
    } catch (e) {
      print('⚠️ Navigation error in _handleRetryAction: $e');
      // Fallback: navigate to home
      if (context.mounted) {
        context.go('/home');
      }
    }
  }

  String _formatAmount(int amount) {
    final formatter = NumberFormat('#,###', 'en_US');
    return '${formatter.format(amount)} تومان';
  }

  void _navigateToHome(BuildContext context) {
    try {
      // First, pop the current route
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      // Then navigate to home using GoRouter
      Future.microtask(() {
        if (context.mounted) {
          context.go('/home');
        }
      });
    } catch (e) {
      print('⚠️ Navigation error in PaymentResultPage: $e');
      // Fallback: try direct GoRouter access
      try {
        Future.microtask(() {
          if (context.mounted) {
            GoRouter.of(context).go('/home');
          }
        });
      } catch (goRouterError) {
        print('⚠️ GoRouter navigation failed: $goRouterError');
        // Last resort: just pop if possible
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      }
    }
  }
}