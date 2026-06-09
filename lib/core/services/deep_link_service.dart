import 'dart:async';
import 'dart:developer';
import 'package:app_links/app_links.dart';
import 'package:pixura_ai/core/config/appconfig.dart';
import 'package:pixura_ai/core/router/routes.dart';
import 'package:pixura_ai/core/utils/navigator_key.dart';
import 'package:pixura_ai/features/auth/controller/auth_provider.dart';
import 'package:pixura_ai/core/services/service_locator.dart';
import 'package:pixura_ai/core/services/clerk_service.dart';

import 'package:provider/provider.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  static const String customScheme = 'postloapp';

  Future<void> initialize() async {
    log('Initializing DeepLinkService');

    // Handle initial link (cold start)
    try {
      final initialUri = await _appLinks.getInitialLink();

      if (initialUri != null) {
        log('Initial deep link: $initialUri');
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      log('Error getting initial deep link: $e');
    }

    // Handle incoming links (warm start)
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        log('Incoming deep link: $uri');
        _handleDeepLink(uri);
      },
      onError: (err) {
        log('Deep link stream error: $err');
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    log(
      'Handling deep link: scheme=${uri.scheme}, host=${uri.host}, path=${uri.path}',
    );

    // Check scheme
    if (uri.scheme != customScheme && uri.scheme != 'https') {
      log('Unsupported scheme: ${uri.scheme}');
      return;
    }

    // Check host if it's https
    if (uri.scheme == 'https' && uri.host != AppConfig.deepLinkHost) {
      log('Deep link host mismatch: ${uri.host} != ${AppConfig.deepLinkHost}');
      return;
    }

    String path = uri.path;
    Map<String, String> params = Map.from(uri.queryParameters);

    // Also parse fragment parameters if present (sometimes used by Clerk or OAuth)
    if (uri.fragment.isNotEmpty) {
      try {
        params.addAll(Uri.splitQueryString(uri.fragment));
      } catch (e) {
        log('Failed to parse fragment as query string: ${uri.fragment}');
      }
    }

    // Ensure path starts with /
    if (!path.startsWith('/')) {
      path = '/$path';
    }

    log('Normalized path: $path, params: $params');
    _processRoute(path, params);
  }

  void _processRoute(String path, Map<String, String> params) {
    if (path == '/callback' || path == '/callback/') {
      // Log current status
      try {
        final clerkService = locator<ClerkService>();
        clerkService.checkSignInStatus();
      } catch (e) {
        log('Failed to get ClerkService from serviceLocator: $e');
      }

      final token =
          params['rotating_token'] ??
          params['token'] ??
          params['__clerk_ticket'];
      if (token != null) {
        log('Found token in callback: $token');
        final context = navigatorKey.currentContext;
        if (context != null) {
          Provider.of<AuthProvider>(
            context,
            listen: false,
          ).clerkCompleteOAuth(token).then((success) {
            if (success) {
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                AppRoutes.home,
                (route) => false,
              );
            }
          });
        }
      } else {
        log('No token found in callback params: $params');
      }
    } else {
      log('No route matched for path: $path');
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
