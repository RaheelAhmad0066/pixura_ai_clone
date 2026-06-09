// import 'dart:async';
// import 'dart:developer';
// import 'package:clerk_auth/clerk_auth.dart' as clerk;
// import 'package:clerk_flutter/clerk_flutter.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import '../config/app_config.dart';
// import '../config/api_endpoints.dart';
// import '../config/storage_keys.dart';
// import '../services/secure_storage_service.dart';
// import '../utils/utils.dart';

// class AuthService {
//   AuthService._();
//   static final AuthService instance = AuthService._();

//   late final ClerkAuthState _auth;
//   ClerkAuthState get auth => _auth;

//   final _authStateController = StreamController<clerk.User?>.broadcast();

//   Future<void> init() async {
//     _auth = await ClerkAuthState.create(
//       config: ClerkAuthConfig(
//         publishableKey:
//             "pk_test_Y3Jpc3AtdW5pY29ybi01Mi5jbGVyay5hY2NvdW50cy5kZXYk",
//         persistor: clerk.DefaultPersistor(
//           getCacheDirectory: getApplicationDocumentsDirectory,
//         ),
//       ),
//     );

//     _auth.addListener(_onAuthChanged);

//     // Initial push and await token storage for the first time
//     final user = _auth.user;
//     _authStateController.add(user);
//     await _updateToken(user);
//   }

//   void _onAuthChanged() {
//     final user = _auth.user;
//     _authStateController.add(user);

//     // Update token in background
//     _updateToken(user);
//   }

//   Future<void> _updateToken(clerk.User? user) async {
//     try {
//       if (user != null) {
//         final sessionToken = await _auth.sessionToken();
//         final clerkToken = sessionToken.jwt;
//         log('🔑 [AUTH] clerk token stored successfully: $clerkToken');
//         // Exchange Clerk token for Backend JWT
//         await _getJWTToken(clerkToken: clerkToken);
//       } else {
//         await SecureStorageService.instance.delete(StorageKeys.accessToken);
//         log('🔑 [AUTH] Token cleared');
//       }
//     } catch (e) {
//       log('❌ [AUTH] Failed to update token: $e');
//     }
//   }

//   Future<void> _getJWTToken({required String clerkToken}) async {
//     final response = await AppConfig.dio.post(
//       ApiEndpoints.clerkLogin,
//       options: Options(headers: {'Authorization': 'Bearer $clerkToken'}),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final data = response.data;
//       final backendJwt = data['jwt'] as String?;
//       if (backendJwt != null) {
//         await SecureStorageService.instance.write(
//           StorageKeys.accessToken,
//           backendJwt,
//         );
//         log('🔑 [AUTH] Backend JWT stored successfully');
//       } else {
//         log('❌ [AUTH] Backend JWT not found in response');
//       }
//     } else {
//       log('❌ [AUTH] Token exchange failed: ${response.statusCode}');
//     }
//   }

//   /// Get the latest backend access token.
//   Future<String?> getToken() async {
//     final result = await SecureStorageService.instance.read(
//       StorageKeys.accessToken,
//     );
//     return result.getOrElse((_) => null);
//   }

//   /// Stream of user state changes.
//   Stream<clerk.User?> get authStateChanges => _authStateController.stream;

//   /// Get current user
//   clerk.User? get currentUser => _auth.user;

//   /// Get current session
//   clerk.Session? get currentSession => _auth.session;

//   // FutureEither<clerk.User?> login({
//   //   required String email,
//   //   required String password,
//   // }) async {
//   //   return runTask(() async {
//   //     await _auth.attemptSignIn(
//   //       strategy: clerk.Strategy.password,
//   //       identifier: email,
//   //       password: password,
//   //     );
//   //     return _auth.user;
//   //   }, requiresNetwork: true);
//   // }

//   // FutureEither<clerk.User?> signUp({
//   //   required String name,
//   //   required String email,
//   //   required String password,
//   // }) async {
//   //   return runTask(() async {
//   //     // Split name into first and last if possible, or just use as first name
//   //     final nameParts = name.split(' ');
//   //     final firstName = nameParts.first;
//   //     final lastName =
//   //         nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
//   //     log('message: $firstName');
//   //     log('message: $lastName');
//   //     log('message: $password');
//   //     log('message: $email');
//   //     await _auth.attemptSignUp(
//   //         strategy: clerk.Strategy.password,
//   //         emailAddress: email,
//   //         password: password,
//   //         firstName: firstName,
//   //         lastName: lastName,
//   //         passwordConfirmation: password);
//   //     return _auth.user;
//   //   }, requiresNetwork: true);
//   // }

//   // FutureEither<void> forgotPassword({required String email}) async {
//   //   return runTask(() async {
//   //     await _auth.initiatePasswordReset(
//   //       identifier: email,
//   //       strategy: clerk.Strategy.resetPasswordEmailCode,
//   //     );
//   //   }, requiresNetwork: true);
//   // }

//   // FutureEither<void> logout() async {
//   //   return runTask(() async {
//   //     await _auth.signOut();
//   //   }, requiresNetwork: true);
//   // }

//   // FutureEither<clerk.User?> getCurrentUser() async {
//   //   return runTask(() async {
//   //     return _auth.user;
//   //   });
//   // }

//   void dispose() {
//     _auth.removeListener(_onAuthChanged);
//     _authStateController.close();
//     _auth.terminate();
//   }
// }
