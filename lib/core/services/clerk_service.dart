import 'dart:async';
import 'dart:developer' show log;
import 'package:clerk_auth/clerk_auth.dart';
import 'package:pixura_ai/core/config/appconfig.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixura_ai/core/dio/dio_client.dart';
import 'package:pixura_ai/core/services/service_locator.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:pixura_ai/core/constants/app_string.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ClerkService {
  late final Auth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  ClerkService();

  Future<void> initialize() async {
    final directory = await getApplicationSupportDirectory();
    _auth = Auth(
      config: AuthConfig(
        publishableKey: AppConfig.clerkPublishableKey,
        persistor: DefaultPersistor(getCacheDirectory: () => directory),
      ),
    );
    await _auth.initialize();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await signOut();
      await _auth.attemptSignIn(
        strategy: Strategy.password,
        identifier: email,
        password: password,
      );

      log('✅ Sign in successful');

      final clerkToken = _auth.client.activeSession?.lastActiveToken?.jwt;

      await _getJWTToken(clerkToken: clerkToken ?? '');
    } catch (e) {
      rethrow;
    }
  }

  Future<Client> signUp(String email, String password) async {
    try {
      await signOut();

      final client = await _auth.attemptSignUp(
        strategy: Strategy.password,
        emailAddress: email,
        password: password,
        passwordConfirmation: password,
      );
      log('Sign up result status: ${client.signUp?.status}');

      // If email is unverified, trigger code sending
      if (client.signUp?.status == Status.missingRequirements &&
          client.signUp?.unverified(Field.emailAddress) == true) {
        log('Email unverified, sending code...');
        await _auth.attemptSignUp(strategy: Strategy.emailCode);
      }

      return client;
    } catch (e) {
      rethrow;
    }
  }

  Future<Client> verifySignUpOtp(String code) async {
    try {
      final client = await _auth.attemptSignUp(
        strategy: Strategy.emailCode,
        code: code,
      );

      if (client.user != null) {
        log('User is successfully verified');

        final clerkToken = _auth.client.activeSession?.lastActiveToken?.jwt;

        await _getJWTToken(clerkToken: clerkToken ?? '');
      }
      return client;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      log('Signed out successfully');
    } catch (e) {
      log('Error signing out: $e');
      rethrow;
    }
  }

  Future<void> resendCode(Strategy strategy) async {
    try {
      await _auth.resendCode(strategy);
      log('Resend code successful');
    } catch (e) {
      log('Error resending code: $e');
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.initiatePasswordReset(
        identifier: email,
        strategy: Strategy.resetPasswordEmailCode,
      );
      log('Password reset initiated for $email');
    } catch (e) {
      log('Error initiating password reset: $e');
      rethrow;
    }
  }

  Future<void> resetPassword(String code, String newPassword) async {
    try {
      await _auth.attemptSignIn(
        strategy: Strategy.resetPasswordEmailCode,
        code: code,
        password: newPassword,
      );
      log('Password reset successful');
    } catch (e) {
      log('Error resetting password: $e');
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await signOut();
      await _auth.oauthSignIn(
        strategy: Strategy.oauthGoogle,
        redirect: Uri.parse('postloapp://callback'),
      );

      final url = _auth.signIn?.verification?.externalVerificationRedirectUrl;
      log('OAuth URL: $url');
      if (url != null && url.isNotEmpty) {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.inAppWebView);
        } else {
          throw 'Could not launch $url';
        }
      } else {
        throw 'No external verification URL found';
      }
    } catch (e) {
      log('Error in signInWithGoogle: $e');
      rethrow;
    }
  }

  Future<void> signInWithGoogleNative() async {
    try {
      await signOut(); // Ensure signed out

      await _googleSignIn.initialize();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'Failed to get ID token from Google';
      }

      log('Got Google ID Token, passing to Clerk');

      await _auth.oauthSignIn(
        strategy: Strategy.oauthTokenGoogle,
        redirect: null,
      );

      await _auth.completeOAuthSignIn(token: idToken);

      final sessionToken = await _auth.sessionToken();
      final clerkToken =
          (sessionToken as dynamic).jwt ?? sessionToken.toString();
      await _getJWTToken(clerkToken: clerkToken);
    } catch (e) {
      log('Error in signInWithGoogleNative: $e');
      rethrow;
    }
  }

  Future<void> completeOAuth(String token) async {
    try {
      await _auth.completeOAuthSignIn(token: token);

      final sessionToken = await _auth.sessionToken();
      final clerkToken =
          (sessionToken as dynamic).jwt ?? sessionToken.toString();
      await _getJWTToken(clerkToken: clerkToken);
    } catch (e) {
      log('Error in completeOAuth: $e');
      rethrow;
    }
  }

  void checkSignInStatus() {
    log('Current signIn status: ${_auth.signIn?.status}');
    log('Current user: ${_auth.user}');
  }

  User? get currentUser => _auth.user;

  Future<void> _getJWTToken({required String clerkToken}) async {
    try {
      final response = await locator<DioClient>().dio.post(
        AppConfig.clerkLogin, // Guessing the endpoint
        options: Options(headers: {'Authorization': 'Bearer $clerkToken'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final backendJwt = data['jwt'] as String?;
        if (backendJwt != null) {
          await secureStorage.setValue(AppString.tokenKey, backendJwt);
          log('🔑 [AUTH] Backend JWT stored successfully');
        } else {
          log('❌ [AUTH] Backend JWT not found in response');
        }
      } else {
        log('❌ [AUTH] Token exchange failed: ${response.statusCode}');
      }
    } catch (e) {
      log('❌ [AUTH] Failed to exchange token: $e');
    }
  }
}
