import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show Navigator;
import 'package:pixura_ai/core/constants/app_string.dart';
import 'package:pixura_ai/core/exceptions/app_exceptions.dart';
import 'package:pixura_ai/core/config/appconfig.dart';
import 'package:pixura_ai/core/router/routes.dart';
import 'package:pixura_ai/core/utils/debug_point.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:pixura_ai/core/utils/navigator_key.dart';
import 'dart:convert';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(minutes: 10),
        receiveTimeout: const Duration(minutes: 10),
        sendTimeout: const Duration(minutes: 10),
      ),
    );
    _setupInterceptors();
  }
  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleRequest,
        onResponse: _handleResponse,
        onError: _handleError,
      ),
    );
  }

  Future<void> _handleRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      DebugPoint.log("-------- 📤 REQUEST --------");
      DebugPoint.log("URI: ${options.uri}");
      DebugPoint.log("METHOD: ${options.method}");
      DebugPoint.log("HEADERS: ${options.headers}");
      DebugPoint.log("BODY: ${options.data}");
      final token = await secureStorage.getStringAsync(AppString.tokenKey);
      if (token.isNotEmpty && !options.path.contains('/clerk-login')) {
        options.headers['Authorization'] = 'Bearer $token';
        DebugPoint.log('Api Request Authorization: Bearer $token');
        DebugPoint.log("----------------------------");
      }
      handler.next(options);
    } catch (e) {
      DebugPoint.error('Request error $e');
      handler.reject(
        DioException(
          requestOptions: options,
          error: NetworkException('Failed to make request: ${e.toString()}'),
        ),
      );
    }
  }

  void _handleResponse(Response response, ResponseInterceptorHandler handler) {
    DebugPoint.log("-------- 📥 RESPONSE --------");
    DebugPoint.log("URI: ${response.requestOptions.uri}");
    DebugPoint.log("STATUS: ${response.statusCode}");
    DebugPoint.log("DATA: ${response.data}");
    DebugPoint.log("-----------------------------");

    // If we can’t parse, just continue
    handler.next(response);
  }

  Future<void> _handleError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    // Log error details for debugging
    DebugPoint.error("-------- ❌ ERROR --------");
    DebugPoint.error("URI: ${requestOptions.uri}");
    DebugPoint.error("STATUS: ${err.response?.statusCode}");
    DebugPoint.error("ERROR DATA: ${err.response?.data}");
    DebugPoint.error("---------------------------");

    // If not 401 → forward the error
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    // Prevent refresh loop
    if (requestOptions.extra["retry"] == true) {
      // Already retried once → force logout
      await _clearStorage();
      handler.reject(err);
      return;
    }

    // Ignore login or refresh endpoints
    if (requestOptions.path.contains('profile') ||
        requestOptions.path.contains('get-otp') ||
        requestOptions.path.contains('login-with-otp') ||
        requestOptions.path.contains('login-with-password') ||
        requestOptions.path.contains('refresh-token')) {
      handler.next(err);
      return;
    }

    DebugPoint.warning("⚠️ Token expired → Refreshing token...");

    try {
      // Get refresh token from storage
      final refreshToken = await secureStorage.getStringAsync(
        AppString.refreshTokenKey,
      );

      if (refreshToken.isEmpty) {
        DebugPoint.error("❌ No refresh token available");
        await _clearStorage();
        handler.reject(err);
        return;
      }

      // Call refresh token endpoint
      final refreshResponse = await _dio.post(
        AppConfig.refreshToken,
        data: jsonEncode({"refreshToken": refreshToken}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (refreshResponse.statusCode == 200) {
        // Extract new tokens from response
        final responseData = refreshResponse.data;
        String? newAccessToken;
        String? newRefreshToken;

        if (responseData is Map) {
          newAccessToken = responseData["token"]?.toString();
          newRefreshToken = responseData["refreshToken"]?.toString();
        }

        if (newAccessToken == null || newAccessToken.isEmpty) {
          DebugPoint.error(
            "❌ Refresh token returned NULL / EMPTY access token",
          );
          await _clearStorage();
          handler.reject(err);
          return;
        }

        // Save new tokens
        if (newAccessToken.isNotEmpty) {
          await secureStorage.setValue(AppString.tokenKey, newAccessToken);
        }
        if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
          await secureStorage.setValue(
            AppString.refreshTokenKey,
            newRefreshToken,
          );
        }

        DebugPoint.log("✅ Token refreshed successfully");

        // Mark request as retried
        requestOptions.extra["retry"] = true;

        // Update header with new token
        requestOptions.headers["Authorization"] = "Bearer $newAccessToken";

        DebugPoint.log("🔄 Retrying original request → ${requestOptions.uri}");

        // Retry original request
        final response = await _dio.fetch(requestOptions);

        handler.resolve(response);
      } else {
        DebugPoint.error(
          "❌ Refresh token failed with status: ${refreshResponse.statusCode}",
        );
        await _clearStorage();
        handler.reject(err);
      }
    } catch (e) {
      DebugPoint.error("❌ Refresh failed: $e");

      await _clearStorage();

      handler.reject(
        DioException(
          requestOptions: requestOptions,
          error: UnauthorizedException("Session expired"),
        ),
      );
    }
  }

  Future<void> _clearStorage() async {
    await secureStorage.removeKey(AppString.tokenKey);
    await secureStorage.removeKey(AppString.userData);

    final navigatorState = navigatorKey.currentState;
    if (navigatorState == null || !navigatorState.mounted) return;

    Navigator.of(
      // ignore: use_build_context_synchronously
      navigatorState.context,
    ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }
}
