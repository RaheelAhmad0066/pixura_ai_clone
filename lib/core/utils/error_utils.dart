import 'package:pixura_ai/core/constants/error_constants.dart';
import 'package:dio/dio.dart';

/// Utility class for handling API error responses
///
/// This class provides methods to extract user-friendly error messages
/// from various API error response formats commonly used in REST APIs.
///
/// Supported error formats:
/// - Simple string errors
/// - Object with error/message/detail fields
/// - Arrays of error objects
/// - Nested error structures
/// - HTTP status code based errors
class ErrorUtils {
  /// Extract error message from DioException response
  /// Handles various API error response formats:
  /// - {"error": "message"}
  /// - {"message": "message"}
  /// - {"detail": "message"}
  /// - {"errors": [{"message": "error message"}]}
  /// - {"success": false, "error": "error message"}
  /// - "string error"
  static String extractErrorMessage(DioException exception) {
    if (exception.response == null) {
      return _getErrorMessageFromType(exception.type);
    }

    final responseData = exception.response?.data;
    final statusCode = exception.response?.statusCode;

    if (responseData is Map) {
      return _extractFromMap(responseData.cast<String, dynamic>());
    } else if (responseData is String) {
      final trimmedData = responseData.trim();
      // Detect HTML responses (which often happen on 502/504 errors)
      if (trimmedData.toLowerCase().contains('<html') ||
          trimmedData.toLowerCase().startsWith('<!doctype')) {
        if (statusCode != null) {
          return getErrorMessageByStatusCode(statusCode);
        }
      }
      return responseData.isNotEmpty
          ? responseData
          : ErrorConstants.generalError;
    }

    if (statusCode != null) {
      return getErrorMessageByStatusCode(statusCode);
    }

    return ErrorConstants.generalError;
  }

  /// Extract error message from Map response data
  static String _extractFromMap(Map<String, dynamic> responseData) {
    // Handle different error response formats

    // Format 1: {"errors": [{"message": "error message"}]}
    if (responseData["errors"] is List) {
      final errors = responseData["errors"] as List;
      if (errors.isNotEmpty) {
        final firstError = errors.first;
        if (firstError is Map) {
          final errorMap = firstError as Map<String, dynamic>;
          final message =
              errorMap["message"] ?? errorMap["error"] ?? errorMap["detail"];
          if (message is String && message.isNotEmpty) {
            return message;
          }
        } else if (firstError is String && firstError.isNotEmpty) {
          return firstError;
        }
      }
    }

    // Format 2: {"success": false, "error": "error message"}
    // Format 3: {"error": "message"}
    // Format 4: {"message": "message"}
    // Format 5: {"detail": "message"}
    final errorMessage =
        responseData["error"] ??
        responseData["message"] ??
        responseData["detail"];

    if (errorMessage is String && errorMessage.isNotEmpty) {
      return errorMessage;
    } else if (errorMessage is Map) {
      // Handle nested error objects
      return _extractFromNestedMap(errorMessage.cast<String, dynamic>());
    } else if (errorMessage is List && errorMessage.isNotEmpty) {
      // Handle array of simple errors
      final firstError = errorMessage.first;
      if (firstError is Map) {
        final errorMap = firstError as Map<String, dynamic>;
        final message =
            errorMap["message"] ?? errorMap["error"] ?? errorMap["detail"];
        if (message is String && message.isNotEmpty) {
          return message;
        }
      } else if (firstError is String && firstError.isNotEmpty) {
        return firstError;
      }
    }

    return ErrorConstants.generalError;
  }

  /// Extract error message from nested error objects
  static String _extractFromNestedMap(Map<String, dynamic> errorMap) {
    // Try common error message fields
    final message =
        errorMap["message"] ?? errorMap["error"] ?? errorMap["detail"];

    if (message is String && message.isNotEmpty) {
      return message;
    }

    // If no direct message found, try to get the first non-null value
    for (final value in errorMap.values) {
      if (value is String && value.isNotEmpty) {
        return value;
      }
    }

    return ErrorConstants.generalError;
  }

  /// Get error message based on DioException type
  static String _getErrorMessageFromType(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Connection timeout. Please check your internet connection.";
      case DioExceptionType.connectionError:
        return "No internet connection. Please check your network.";
      case DioExceptionType.badResponse:
        return "Server error. Please try again later.";
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      default:
        return ErrorConstants.generalError;
    }
  }

  /// Get user-friendly error message based on HTTP status code
  static String getErrorMessageByStatusCode(
    int statusCode, [
    String? defaultMessage,
  ]) {
    switch (statusCode) {
      case 400:
        return defaultMessage ?? "Bad request. Please check your input.";
      case 401:
        return defaultMessage ?? "Authentication failed. Please login again.";
      case 403:
        return defaultMessage ?? "Access denied. You don't have permission.";
      case 404:
        return defaultMessage ?? "Resource not found.";
      case 422:
        return defaultMessage ?? "Validation failed. Please check your input.";
      case 429:
        return defaultMessage ?? "Too many requests. Please try again later.";
      case 500:
        return defaultMessage ??
            "Internal server error. Please try again later.";
      case 502:
        return defaultMessage ??
            "Server is not responding. Please try again later.";
      case 503:
        return defaultMessage ?? "Service unavailable. Please try again later.";
      default:
        return defaultMessage ?? ErrorConstants.generalError;
    }
  }

  /// Extract error message with fallback to status code message
  static String extractErrorMessageWithFallback(DioException exception) {
    // First try to extract from response data
    final extractedMessage = extractErrorMessage(exception);

    // If we got a generic error and have a status code, try to provide a more specific message
    if (extractedMessage == ErrorConstants.generalError &&
        exception.response?.statusCode != null) {
      return getErrorMessageByStatusCode(exception.response!.statusCode!);
    }

    return extractedMessage;
  }
}
