import 'package:academic/core/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:academic/core/services/deep_link_service.dart';

@injectable
class UrlHandlerService {
  final DeepLinkService _deepLinkService;

  UrlHandlerService(this._deepLinkService);

  /// Handle URLs that should be intercepted by our app
  Future<bool> handleUrl(BuildContext context, String url) async {
    print('🌐 URL Handler received: $url');
    
    // Check if this is a callback URL we should handle
    if (_shouldInterceptUrl(url)) {
      print('✅ Intercepting URL for payment handling');
      _deepLinkService.handlePaymentReturn(context, url);
      return true; // Indicate we handled the URL
    }
    
    return false; // Let the system handle it normally
  }

  /// Check if we should intercept this URL
  bool _shouldInterceptUrl(String url) {
    // Handle payment callback URLs
    if (url.contains('${ApiConstants.host}/api/callback')) {
      return true;
    }
    
    // Handle Zarinpal URLs with Authority parameter
    if (url.contains('Authority=') && url.contains('Status=')) {
      return true;
    }
    
    // Handle our app's deep links
    if (url.startsWith('academic://')) {
      return true;
    }
    
    return false;
  }

  /// Create a proper deep link from callback URL
  String convertCallbackToDeepLink(String callbackUrl) {
    final uri = Uri.parse(callbackUrl);
    final authority = uri.queryParameters['Authority'];
    final status = uri.queryParameters['Status'];
    
    if (status == 'OK' && authority != null) {
      return 'academic://payment?status=success&authority=$authority&amount=0&type=book';
    }
    
    return 'academic://payment?status=failed';
  }
}
