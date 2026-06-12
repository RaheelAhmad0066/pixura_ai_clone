import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pixura_ai/features/auth/controller/account_setup_provider.dart';
import 'package:pixura_ai/features/auth/widget/account_setup/setup_intro_widget.dart';
import 'package:pixura_ai/features/auth/widget/account_setup/setup_input_widget.dart';
import 'package:pixura_ai/features/auth/widget/account_setup/setup_verification_widget.dart';
import 'package:pixura_ai/features/auth/widget/account_setup/setup_welcome_widget.dart';

class AccountSetupScreen extends StatelessWidget {
  const AccountSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccountSetupProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: provider.currentStep > 0 && provider.currentStep < 3
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => provider.prevStep(),
              ),
            )
          : null,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildStepContent(provider.currentStep),
        ),
      ),
    );
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return const SetupIntroWidget(key: ValueKey('setup_intro'));
      case 1:
        return const SetupInputWidget(key: ValueKey('setup_input'));
      case 2:
        return const SetupVerificationWidget(key: ValueKey('setup_verification'));
      case 3:
        return const SetupWelcomeWidget(key: ValueKey('setup_welcome'));
      default:
        return const SetupIntroWidget(key: ValueKey('setup_intro'));
    }
  }
}
