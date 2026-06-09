import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pixura_ai/core/services/service_locator.dart';
import 'package:pixura_ai/core/utils/toast_utils.dart';
import 'package:pixura_ai/features/auth/model/profile_model.dart';
import 'package:pixura_ai/features/auth/repository/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _profileRepository = locator<ProfileRepository>();

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // ── Fetch ──────────────────────────────────────────────────────────────────

  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();

    final result = await _profileRepository.getProfile();
    result.fold(
      (error) => ToastUtils.error(error),
      (profileData) => _profile = profileData,
    );

    _isLoading = false;
    notifyListeners();
  }

  // ── Update profile (with optional picture upload) ──────────────────────────

  /// If [imageFile] is provided it is uploaded first via POST /media/upload-simple.
  /// The returned media ID is then included in the PUT /user/profile payload.
  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String organization,
    required String phoneNumber,
    required String address,
    File? imageFile,
  }) async {
    _isLoading = true;
    notifyListeners();

    // 1 ── Upload picture if a new file was chosen
    String? newPictureId;
    if (imageFile != null) {
      final uploadResult = await _profileRepository.uploadProfilePicture(
        imageFile,
      );
      bool uploadOk = false;
      uploadResult.fold((error) => ToastUtils.error(error), (uploaded) {
        newPictureId = uploaded.id;
        uploadOk = true;
      });
      if (!uploadOk) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    }

    // 2 ── PUT /user/profile
    final model = ProfileModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      organization: organization.isEmpty ? null : organization,
      phoneNumber: phoneNumber.isEmpty ? null : phoneNumber,
      address: address.isEmpty ? null : address,
    );

    final result = await _profileRepository.updateProfile(
      model,
      profilePictureId: newPictureId,
    );
    bool isSuccess = false;

    result.fold((error) => ToastUtils.error(error), (updated) {
      _profile = updated;
      ToastUtils.success('Profile updated successfully');
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  // ── Change password ────────────────────────────────────────────────────────

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _profileRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    bool isSuccess = false;

    result.fold((error) => ToastUtils.error(error), (_) {
      ToastUtils.success('Password changed successfully');
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
