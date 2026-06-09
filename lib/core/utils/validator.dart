mixin Validators {
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return RegExp(
          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
        ).hasMatch(value)
        ? null
        : 'Please enter a valid email address';
  }

  String? validatePhoneNumber(value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.length < 7 || value.length > 15) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
