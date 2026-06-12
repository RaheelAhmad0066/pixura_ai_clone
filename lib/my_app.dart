import 'package:pixura_ai/core/config/appconfig.dart';
import 'package:pixura_ai/core/utils/system_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:pixura_ai/core/router/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixura_ai/core/router/router.dart' as router;
import 'package:pixura_ai/core/theme/app_theme.dart';
import 'package:pixura_ai/core/theme/theme_controller.dart';
import 'package:pixura_ai/core/services/multiprovider_class.dart';
import 'package:pixura_ai/core/utils/navigator_key.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MultiProviderClass.providersList,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => Builder(
          builder: (BuildContext context) {
            return Consumer<ThemeController>(
              builder: (context, value, child) {
                // Update system UI overlay style based on theme
                SystemUIUtils.setStatusBarForTheme(value.currentTheme, context);

                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: AppConfig.appName,
                  navigatorKey: navigatorKey,
                  themeMode: value.currentTheme,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  onGenerateRoute: router.generateRoute,
                  initialRoute: AppRoutes.onboarding,
                  builder: (context, child) => GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: child!,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// flutter run --flavor dev -t lib/flavors/main_dev.dart --release
// flutter build apk --flavor dev -t lib/flavors/main_dev.dart --release
