import 'package:pixura_ai/core/services/service_locator.dart';
import 'package:pixura_ai/core/utils/system_ui_utils.dart';
import 'package:pixura_ai/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixura_ai/core/services/secure_storage_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pixura_ai/core/config/environment.dart';
import 'package:pixura_ai/core/services/deep_link_service.dart';
import 'package:pixura_ai/core/services/clerk_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> mainCommon(AppEnvironment env) async {
  ErrorWidget.builder = (details) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        "Error is ${details.exception}",
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  };

  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  await dotenv.load(fileName: ".env");

  // Initialize environment
  EnvConfig.initialize(env);

  // Initialize nb_utils and register dependencies in parallel
  await Future.wait([initialize(), initDependencies()]);

  // Clear keychain data if fresh install and initialize deep link service in parallel
  await Future.wait([
    secureStorage.clearKeychainOnFreshInstall(),
    locator<DeepLinkService>().initialize(),
    locator<ClerkService>().initialize(),
  ]);

  // Initialize system UI with proper status bar configuration
  SystemUIUtils.initializeSystemUI();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}
