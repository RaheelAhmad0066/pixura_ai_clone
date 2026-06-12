import 'package:flutter/material.dart';
import 'package:pixura_ai/core/constants/app_string.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:pixura_ai/core/router/routes.dart';

enum AuthMode { phone, email }

class AccountSetupProvider extends ChangeNotifier {
  int _currentStep = 0; // 0: Intro, 1: Form, 2: OTP, 3: Welcome
  AuthMode _authMode = AuthMode.phone;
  String _phone = '';
  String _email = '';
  String _otp = '';
  bool _isInputValid = false;
  bool _isOtpComplete = false;

  int get currentStep => _currentStep;
  AuthMode get authMode => _authMode;
  String get phone => _phone;
  String get email => _email;
  String get otp => _otp;
  bool get isInputValid => _isInputValid;
  bool get isOtpComplete => _isOtpComplete;

  void setStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void setAuthMode(AuthMode mode) {
    _authMode = mode;
    _phone = '';
    _email = '';
    _isInputValid = false;
    notifyListeners();
  }

  void updatePhone(String val) {
    _phone = val;
    final cleanVal = val.replaceAll(RegExp(r'\D'), '');
    _isInputValid = cleanVal.length >= 7;
    notifyListeners();
  }

  void updateEmail(String val) {
    _email = val;
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    _isInputValid = emailRegex.hasMatch(val.trim());
    notifyListeners();
  }

  void updateOtp(String val) {
    _otp = val;
    _isOtpComplete = val.length == 5;
    notifyListeners();
  }

  Future<void> completeSetup(BuildContext context) async {
    await secureStorage.setValue(AppString.hasSeenOnboarding, true);
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.tabs);
    }
  }

  void reset() {
    _currentStep = 0;
    _authMode = AuthMode.phone;
    _phone = '';
    _email = '';
    _otp = '';
    _isInputValid = false;
    _isOtpComplete = false;
    notifyListeners();
  }
}
