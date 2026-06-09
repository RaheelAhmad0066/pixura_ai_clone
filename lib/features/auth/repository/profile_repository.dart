import 'dart:io';
import 'package:pixura_ai/core/config/appconfig.dart';
import 'package:pixura_ai/core/constants/error_constants.dart';
import 'package:pixura_ai/core/services/api_service.dart';
import 'package:pixura_ai/core/utils/debug_point.dart';
import 'package:pixura_ai/core/utils/error_utils.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart' show Either, Left, Right;
import 'package:pixura_ai/features/auth/model/profile_model.dart';

class ProfileRepository {
  final ApiService apiService;
  ProfileRepository(this.apiService);

  /// Upload a profile picture via POST /media/upload-simple
  /// Returns {id, path} on success.
  Future<Either<String, ({String id, String path})>> uploadProfilePicture(
    File file,
  ) async {
    try {
      final filename = file.uri.pathSegments.last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: filename),
      });
      final response = await apiService.post(
        apiPath: AppConfig.mediaUploadSimple,
        apiData: formData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        final id = data['id'] as String? ?? '';
        final path = data['path'] as String? ?? '';
        return Right((id: id, path: path));
      }
      final msg = response.data?['message'] ?? ErrorConstants.unknownError;
      return Left(msg as String);
    } catch (e) {
      DebugPoint.error('Upload profile picture error: ${e.toString()}');
      if (e is DioException) return Left(ErrorUtils.extractErrorMessage(e));
      return Left(ErrorConstants.generalError);
    }
  }

  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      final response = await apiService.get(AppConfig.userProfile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          final profile = ProfileModel.fromJson(response.data);
          return Right(profile);
        }
        return Left(ErrorConstants.unknownError);
      } else {
        final errorMessage =
            response.data["message"] ?? ErrorConstants.unknownError;
        return Left(errorMessage);
      }
    } catch (e) {
      DebugPoint.error('Get profile error: ${e.toString()}');
      if (e is DioException) {
        return Left(ErrorUtils.extractErrorMessage(e));
      }
      return Left(ErrorConstants.generalError);
    }
  }

  Future<Either<String, ProfileModel>> updateProfile(
    ProfileModel profile, {
    String? profilePictureId,
  }) async {
    try {
      final response = await apiService.put(
        AppConfig.userProfile,
        apiData: profile.toJson(profilePictureId: profilePictureId),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          final updatedProfile = ProfileModel.fromJson(response.data);
          return Right(updatedProfile);
        }
        return Right(profile);
      } else {
        final errorMessage =
            response.data["message"] ?? ErrorConstants.unknownError;
        return Left(errorMessage);
      }
    } catch (e) {
      DebugPoint.error('Update profile error: ${e.toString()}');
      if (e is DioException) {
        return Left(ErrorUtils.extractErrorMessage(e));
      }
      return Left(ErrorConstants.generalError);
    }
  }

  Future<Either<String, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await apiService.put(
        AppConfig.changePassword,
        apiData: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        final errorMessage =
            response.data["message"] ?? ErrorConstants.unknownError;
        return Left(errorMessage);
      }
    } catch (e) {
      DebugPoint.error('Change password error: ${e.toString()}');
      if (e is DioException) {
        return Left(ErrorUtils.extractErrorMessage(e));
      }
      return Left(ErrorConstants.generalError);
    }
  }
}
