import 'package:pixura_ai/core/services/deep_link_service.dart';
import 'package:pixura_ai/core/dio/dio_client.dart';
import 'package:pixura_ai/core/services/api_service.dart';
import 'package:pixura_ai/features/auth/repository/profile_repository.dart';
import 'package:pixura_ai/core/services/clerk_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  // Register DeepLinkService
  locator.registerLazySingleton<DeepLinkService>(() => DeepLinkService());

  // Register DioClient with all its configurations and interceptors
  locator.registerLazySingleton<DioClient>(() => DioClient());

  // Register ApiService with Dio from DioClient
  locator.registerLazySingleton<ApiService>(
    () => ApiService(locator<DioClient>().dio),
  );

  // Register ProfileRepository (migrated to auth)
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(locator<ApiService>()),
  );

  // Register ClerkService
  locator.registerLazySingleton<ClerkService>(() => ClerkService());
}
