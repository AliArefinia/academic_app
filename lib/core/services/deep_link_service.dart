import 'package:academic/l10n/l10n.dart';
import 'package:academic/core/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/data/api/payment/model/payment_model.dart';
import 'package:academic/pages/payment/logic/payment_cubit.dart';
import 'package:academic/pages/cart/logic/cart_cubit.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/pages/payment/payment_result_page.dart';
import 'package:academic/pages/payment/payment_success_page.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/data/repository/product_repository.dart';
import 'package:academic/data/api/home/model/book_model.dart';
import 'package:academic/core/error/error_message_mapper.dart';

@injectable
class DeepLinkService {
  final PaymentCubit _paymentCubit;
  final CartCubit _cartCubit;

  DeepLinkService(this._paymentCubit, this._cartCubit);

  /// Handle deep link for payment return
  void handlePaymentReturn(BuildContext context, String url) {
    print('🔗 Deep link received: $url');
    final uri = Uri.parse(url);

    // Check if it's our app scheme
    if (uri.scheme == 'academic') {
      print('✅ Handling academic scheme');
      _handleAcademicScheme(context, uri);
      return;
    }

    // Check if it's a payment gateway return URL
    if (uri.host.contains('zarinpal') || uri.host.contains('mellat')) {
      print('✅ Handling payment gateway return');
      _handlePaymentGatewayReturn(context, uri);
      return;
    }

    // Handle verification URLs (when user comes back from payment success page)
    if (uri.host.contains(ApiConstants.host) && uri.path.contains('/api/pay/verify')) {
      print('✅ Handling payment verification page');
      // Extract authority from the URL if present
      final authority = uri.queryParameters['Authority'] ?? 
                       uri.queryParameters['authority'];
      
      if (authority != null && authority.isNotEmpty) {
        _verifyPaymentAndNavigate(context, authority, '0', 'unknown');
      } else {
        // Show generic success since we know they reached the success page
        _handlePaymentSuccessPage(context);
      }
      return;
    }

    // Handle callback URLs with Authority parameters
    if ((uri.host.contains(ApiConstants.host) || 
         uri.host.contains('zarinpal')) && 
        uri.queryParameters.containsKey('Authority')) {
      print('✅ Handling callback with Authority');
      _handleZarinpalRedirect(context, uri);
      return;
    }

    // Handle direct Authority/Status URLs (Zarinpal callbacks)
    if (uri.queryParameters.containsKey('Authority') && 
        uri.queryParameters.containsKey('Status')) {
      print('✅ Handling direct Authority/Status URL');
      _handleZarinpalRedirect(context, uri);
      return;
    }

    // Handle HTTP/HTTPS URLs that might be payment callbacks
    if ((uri.scheme == 'http' || uri.scheme == 'https') && 
        uri.queryParameters.containsKey('Authority')) {
      print('✅ Handling HTTP payment callback');
      _handleZarinpalRedirect(context, uri);
      return;
    }

    // Handle unknown deep links
    print('❌ Unknown deep link - scheme: ${uri.scheme}, host: ${uri.host}, path: ${uri.path}');
    print('❌ Query parameters: ${uri.queryParameters}');
    
    // If we can't identify the link, show a generic message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.unknownLinkReceived(uri.toString())),
        backgroundColor: Colors.orange,
      ),
    );
  }

  /// Handle payment verification without navigation
  Future<void> handlePaymentVerification(BuildContext context, String authority, String amount, String type) async {
    try {
      // Show loading
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.verifyingPayment),
            backgroundColor: Colors.blue,
          ),
        );
      }

      await _paymentCubit.verifyPayment(authority);
      
      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.paymentVerifiedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Verification error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorVerifyingPaymentWithMessage(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Handle academic:// scheme
  void _handleAcademicScheme(BuildContext context, Uri uri) {
    switch (uri.host) {
      case 'payment':
        final status = uri.queryParameters['status'];
        final authority = uri.queryParameters['authority'] ?? uri.queryParameters['Authority'];
        final amount = uri.queryParameters['amount'];
        final type = uri.queryParameters['type'];
        
        print('DEBUG: Deep link parameters - status: $status, authority: $authority, amount: $amount, type: $type');

        // Accept both 'OK' and 'success' as valid status
        if ((status == 'success' || status == 'OK') && authority != null && authority.isNotEmpty) {
          // Verify payment with server using the verify endpoint
          _verifyPaymentAndNavigate(context, authority, amount ?? '0', type ?? 'unknown');
        } else {
          // Payment failed or cancelled - navigate to result page
          print('❌ Payment failed or cancelled: status=$status');
          
          final paymentStatus = status == 'NOK' || status == 'failed' 
              ? PaymentStatus.failed 
              : PaymentStatus.cancelled;
          
          Future.delayed(const Duration(milliseconds: 300), () {
            final navigator = rootNavigatorKey.currentState;
            if (navigator != null && navigator.context.mounted) {
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => PaymentResultPage(
                    status: paymentStatus,
                    amount: int.tryParse(amount ?? '0') ?? 0,
                    paymentType: type ?? 'book',
                    errorMessage: status == 'NOK' ? l10n.paymentFailedMessage : l10n.paymentCancelledByUser,
                  ),
                ),
              );
            }
          });
        }
        break;

      case 'book':
        _handleBookDeepLink(context, uri);
        break;

      case 'excerpt':
        _handleExcerptDeepLink(context, uri);
        break;

      default:
        // Unknown scheme, go to home
        try {
          context.go('/home');
        } catch (e) {
          print('Navigation error: $e');
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        }
    }
  }

  /// Handle book deep link: academic://book?id=123
  Future<void> _handleBookDeepLink(BuildContext context, Uri uri) async {
    final bookIdStr = uri.queryParameters['id'];
    if (bookIdStr == null || bookIdStr.isEmpty) {
      print('❌ Book deep link missing id parameter');
      _showErrorSnackBar(context, l10n.invalidBookLink);
      return;
    }

    final bookId = int.tryParse(bookIdStr);
    if (bookId == null) {
      print('❌ Invalid book ID: $bookIdStr');
      _showErrorSnackBar(context, l10n.invalidBookId);
      return;
    }

    try {
      print('📚 Fetching book with ID: $bookId');
      
      // Show loading
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.loadingBook),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 2),
          ),
        );
      }

      // Fetch product to get full BookModel
      final productRepository = GetIt.I<IProductRepository>();
      final product = await productRepository.getProduct(bookId);
      
      // ProductModel extends BookModel, so we can use it directly
      final bookModel = product as BookModel;

      // Navigate to product page
      if (context.mounted) {
        Future.delayed(const Duration(milliseconds: 300), () {
          try {
            ProductRoute(bookModel).push(context);
            print('✅ Navigated to book with ID: $bookId');
          } catch (e) {
            print('❌ Navigation error: $e');
            _showErrorSnackBar(context, l10n.errorOpeningBook);
          }
        });
      }
    } catch (e) {
      print('❌ Error fetching book: $e');
      if (context.mounted) {
        _showErrorSnackBar(context, l10n.errorLoadingBookWithMessage(e.toString()));
      }
    }
  }

  /// Handle excerpt deep link: academic://excerpt?id=123
  void _handleExcerptDeepLink(BuildContext context, Uri uri) {
    final excerptIdStr = uri.queryParameters['id'];
    if (excerptIdStr == null || excerptIdStr.isEmpty) {
      print('❌ Excerpt deep link missing id parameter');
      _showErrorSnackBar(context, l10n.invalidClippingLink);
      return;
    }

    print('📝 Navigating to book tour for excerpt ID: $excerptIdStr');
    
    // Navigate to book tour page
    // Note: The excerpt will be shown in the book tour list
    // If you need to highlight a specific excerpt, you'll need to pass it as a parameter
    try {
      Future.delayed(const Duration(milliseconds: 300), () {
        const BooktourRoute().push(context);
        print('✅ Navigated to book tour');
      });
    } catch (e) {
      print('❌ Navigation error: $e');
      _showErrorSnackBar(context, l10n.errorOpeningClipping);
    }
  }

  /// Show error snackbar
  void _showErrorSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Handle payment gateway return URL
  void _handlePaymentGatewayReturn(BuildContext context, Uri uri) {
    final status = uri.queryParameters['Status'];
    final authority = uri.queryParameters['Authority'] ?? uri.queryParameters['authority'];

    if (status == 'OK' && authority != null && authority.isNotEmpty) {
      // Payment was successful, verify it
      _verifyPaymentAndNavigate(context, authority, '0', 'book');
    } else {
      // Payment failed - navigate to result page
      print('❌ Zarinpal payment failed');
      Future.delayed(const Duration(milliseconds: 300), () {
        final navigator = rootNavigatorKey.currentState;
        if (navigator != null && navigator.context.mounted) {
          navigator.push(
            MaterialPageRoute(
              builder: (context) => PaymentResultPage(
                status: PaymentStatus.failed,
                amount: 0,
                paymentType: 'book',
                errorMessage: l10n.paymentFailedMessage,
              ),
            ),
          );
        }
      });
    }
  }

  /// Handle Zarinpal redirect URLs that don't use our deep link
  void _handleZarinpalRedirect(BuildContext context, Uri uri) {
    final authority = uri.queryParameters['Authority'] ?? uri.queryParameters['authority'];
    final status = uri.queryParameters['Status'] ?? 'OK'; // Default to OK for redirects

    print('🟡 Zarinpal redirect received: Status=$status, Authority=$authority');

    if (authority != null && authority.isNotEmpty) {
      // Payment was successful, verify it
      _verifyPaymentAndNavigate(context, authority, '0', 'unknown');
    } else {
      // Payment failed or invalid parameters - navigate to result page
      print('❌ Zarinpal redirect invalid parameters');
      Future.delayed(const Duration(milliseconds: 300), () {
        final navigator = rootNavigatorKey.currentState;
        if (navigator != null && navigator.context.mounted) {
          navigator.push(
            MaterialPageRoute(
              builder: (context) => PaymentResultPage(
                status: PaymentStatus.error,
                amount: 0,
                paymentType: 'unknown',
                errorMessage: l10n.invalidPaymentParameters,
              ),
            ),
          );
        }
      });
      context.pop();
    }
  }

  /// Handle payment success page (HTML page from server)
  void _handlePaymentSuccessPage(BuildContext context) {
    print('🟢 Handling payment success HTML page');
    
    // Show success message and navigate to home or payment success page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.paymentCompletedSuccessfully),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to home or payment success page
    try {
      final router = GoRouter.of(context);
      router.go('/'); // Go to home page
    } catch (e) {
      print('Navigation error: $e');
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  /// Verify payment and navigate to success page
  Future<void> _verifyPaymentAndNavigate(
    BuildContext context,
    String authority,
    String amount,
    String type
  ) async {
    try {
      // Show loading
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.verifyingPayment),
            backgroundColor: Colors.blue,
          ),
        );
      }

      await _paymentCubit.verifyPayment(authority);

      // Extract type and error from payment cubit state
      String? actualPaymentType;
      bool isVerified = false;
      String? errorMessage;
      final state = _paymentCubit.state;
      state.whenOrNull(
        verified: (response) {
          isVerified = true;
          if (response.data != null) {
            actualPaymentType = response.data!.type;
            print('DEBUG: Payment verification response type: $actualPaymentType');
            print('DEBUG: Payment verification order number: ${response.data!.orderNumber}');
            print('DEBUG: Payment verification transaction ID: ${response.data!.transactionId}');
          }
        },
        error: (message) {
          errorMessage = message;
          print('DEBUG: Payment verification error from cubit: $errorMessage');
        },
      );

      // If there's an error, throw it with the proper message
      if (errorMessage != null) {
        // Map technical errors to user-friendly messages
        final userFriendlyMessage = ErrorMessageMapper.mapApiError(errorMessage);
        throw Exception(userFriendlyMessage);
      }

      // Only refresh cart if payment was successfully verified AND it's a book purchase
      if (isVerified) {
        final finalPaymentType = actualPaymentType ?? type;
        
        // Only refresh cart for book purchases, not for subscriptions or wallet
        if (finalPaymentType == 'book') {
          print('🛒 Refreshing cart after successful book purchase...');
          try {
            // First refresh
            await _cartCubit.getCart();
            print('✅ Cart refreshed (1st time)');
            
            // Wait 2 seconds and refresh again (in case server needs time to clear cart)
            Future.delayed(const Duration(seconds: 2), () async {
              try {
                await _cartCubit.getCart();
                print('✅ Cart refreshed (2nd time)');
              } catch (e) {
                print('⚠️ Failed to refresh cart (2nd time): $e');
              }
            });
          } catch (e) {
            print('⚠️ Failed to refresh cart: $e');
          }
        } else {
          print('🛒 Skipping cart refresh for payment type: $finalPaymentType');
        }
      } else {
        print('⚠️ Payment not verified, skipping cart refresh');
        // Throw error to be caught in catch block
        throw Exception(l10n.paymentNotVerified);
      }

      // Hide loading message
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
      
      // Navigate to Payment Success page with order details
      final finalPaymentType = actualPaymentType ?? type;
      Future.delayed(const Duration(milliseconds: 500), () {
        final navigator = rootNavigatorKey.currentState;
        if (navigator != null) {
          try {
            // First, pop any current payment-related pages to avoid navigation conflicts
            if (navigator.canPop()) {
              navigator.popUntil((route) => route.isFirst);
            }
            
            // Extract order information from payment response
            String? orderNumber;
            String? transactionId;
            List<Map<String, dynamic>>? items;
            
            final state = _paymentCubit.state;
            state.whenOrNull(
              verified: (response) {
                if (response.data != null) {
                  orderNumber = response.data!.orderNumber;
                  transactionId = response.data!.transactionId;
                  items = response.data!.items.map((item) => {
                    'product_id': item.productId,
                    'price': item.price,
                  }).toList();
                }
              },
            );
            
            // Navigate to payment success page with order details
            print('DEBUG: DeepLinkService paymentType: $finalPaymentType (from API: $actualPaymentType, from URL: $type)');
            
            // Use push instead of go to avoid GoRouter parsing issues with custom schemes
            navigator.push(
              MaterialPageRoute(
                builder: (context) => PaymentSuccessPage(
                  trackingCode: authority,
                  amount: int.tryParse(amount) ?? 0,
                  paymentType: finalPaymentType,
                  orderNumber: orderNumber,
                  transactionId: transactionId,
                  items: items,
                ),
              ),
            );
            print('✅ Navigated to payment success page for payment type: $finalPaymentType');
          } catch (e) {
            print('⚠️ Navigation error: $e');
            // Fallback: go to home
            try {
              GoRouter.of(navigator.context).push('/home');
              print('✅ Fallback navigation to home');
            } catch (goRouterError) {
              print('⚠️ GoRouter fallback failed: $goRouterError');
            }
          }
        } else {
          print('⚠️ Navigator not available');
        }
      });
    } catch (e) {
      print('Verification error: $e');
      // Hide loading message
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }

      // Extract error message cleanly
      String errorMsg = e.toString();
      // Remove "Exception: " prefix if present
      if (errorMsg.startsWith('Exception: ')) {
        errorMsg = errorMsg.substring(11);
      }

      // Determine payment status based on error
      PaymentStatus errorStatus = PaymentStatus.failed; // Default to failed for verification errors
      final lowerErrorMsg = errorMsg.toLowerCase();

      if (lowerErrorMsg.contains('زمان پرداخت منقضی') || 
          lowerErrorMsg.contains('expired') ||
          lowerErrorMsg.contains('منقضی')) {
        errorStatus = PaymentStatus.expired;
      } else if (lowerErrorMsg.contains('لغو') || 
                 lowerErrorMsg.contains('cancel') ||
                 lowerErrorMsg.contains('cancelled')) {
        errorStatus = PaymentStatus.cancelled;
      } else if (lowerErrorMsg.contains('مشکلی در سرور') ||
                 lowerErrorMsg.contains('server error') ||
                 lowerErrorMsg.contains('خطا در پردازش')) {
        errorStatus = PaymentStatus.failed;
      }

      // Navigate to Payment Result page with error status
      Future.delayed(const Duration(milliseconds: 500), () {
        final navigator = rootNavigatorKey.currentState;
        if (navigator != null) {
          try {
            // First, pop any current payment-related pages to avoid navigation conflicts
            if (navigator.canPop()) {
              navigator.popUntil((route) => route.isFirst);
            }
            
            navigator.push(
              MaterialPageRoute(
                builder: (context) => PaymentResultPage(
                  status: errorStatus,
                  amount: int.tryParse(amount) ?? 0,
                  paymentType: type,
                  errorMessage: errorMsg,
                ),
              ),
            );
            print('✅ Navigated to Payment Result page with error status: $errorStatus');
          } catch (e) {
            print('⚠️ Navigation error: $e');
            // Fallback: go to home
            try {
              GoRouter.of(navigator.context).push('/home');
              print('✅ Fallback navigation to home');
            } catch (goRouterError) {
              print('⚠️ GoRouter fallback failed: $goRouterError');
            }
          }
        }
      });
    }
  }

  /// Generate return URL for payment gateway
  String generateReturnUrl({
    required String status,
    required String authority,
    int? amount,
    PaymentType? type,
  }) {
    final params = <String, String>{
      'status': status,
      'authority': authority,
    };
    
    if (amount != null) {
      params['amount'] = amount.toString();
    }
    
    if (type != null) {
      params['type'] = type.apiValue;
    }
    
    final queryString = params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    
    return 'academic://payment?$queryString';
  }
}
