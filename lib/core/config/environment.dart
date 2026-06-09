enum AppEnvironment { dev, staging, prod }

class EnvConfig {
  final AppEnvironment environment;
  final String baseUrl;
  final String deepLinkHost;

  EnvConfig({
    required this.environment,
    required this.baseUrl,
    required this.deepLinkHost,
  });

  static EnvConfig? _instance;
  // 'https://postlo-backend-production.up.railway.app/'
  // https://postlo-backend-dev.up.railway.app/
  static void initialize(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.dev:
        _instance = EnvConfig(
          environment: AppEnvironment.dev,
          baseUrl: 'https://postlo-backend-production.up.railway.app/',
          deepLinkHost: 'postlo.ai',
        );
        break;
      case AppEnvironment.staging:
        _instance = EnvConfig(
          environment: AppEnvironment.staging,
          baseUrl: 'https://postlo-backend-production.up.railway.app/',
          deepLinkHost: 'postlo.ai',
        );
        break;
      case AppEnvironment.prod:
        _instance = EnvConfig(
          environment: AppEnvironment.prod,
          baseUrl: 'https://postlo-backend-production.up.railway.app/',
          deepLinkHost: 'postlo.ai',
        );
        break;
    }
  }

  static EnvConfig get instance {
    if (_instance == null) {
      // Default to dev if not initialized (though it should be)
      initialize(AppEnvironment.dev);
    }
    return _instance!;
  }
}
