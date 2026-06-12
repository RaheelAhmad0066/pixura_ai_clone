import 'package:pixura_ai/features/auth/controller/auth_provider.dart';
import 'package:pixura_ai/features/auth/controller/profile_provider.dart';
import 'package:pixura_ai/features/auth/controller/account_setup_provider.dart';
import 'package:pixura_ai/features/tab/controller/tabs_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:pixura_ai/core/theme/theme_controller.dart';

class MultiProviderClass {
  static List<SingleChildWidget> get providersList => [
    ChangeNotifierProvider(create: (context) => ThemeController()),
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => ProfileProvider()),
    ChangeNotifierProvider(create: (context) => TabsController()),
    ChangeNotifierProvider(create: (context) => AccountSetupProvider()),
  ];
}
