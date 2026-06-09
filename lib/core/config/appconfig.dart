import 'package:pixura_ai/core/config/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const appName = "Pixura AI";
  static String get clerkPublishableKey =>
      dotenv.env['CLERK_PUBLISHABLE_KEY'] ?? '';
  static String get baseUrl => EnvConfig.instance.baseUrl;
  static String get deepLinkHost => EnvConfig.instance.deepLinkHost;

  // Auth Endpoints
  static const String refreshToken = "refresh-token";
  static const String clerkLogin = "auth/clerk-login";
  static const String userProfile = "user/profile";
  static const String changePassword = "user/password";

  // Social Media Endpoints
  static const String availableSocialMedias = "integrations";
  static const String getConnectedAccounts = "integrations/list";
  static String socialAuthUrl(String provider) =>
      "integrations/social/$provider";
  static String socialConnect(String provider) =>
      "integrations/social/$provider/connect";
  static const String integrationsFunction = "integrations/function";
  static String integrationProviderConnect(String id) =>
      "integrations/provider/$id/connect";

  // Media Endpoints
  static const String media = "media";
  static const String mediaUploadSimple = "media/upload-simple";
  static const String mediaCreateMultipartUpload =
      "media/create-multipart-upload";
  static const String mediaSignPart = "media/sign-part";
  static const String mediaCompleteMultipartUpload =
      "media/complete-multipart-upload";
  static const String replicateGenerateImage = "media/replicate/generate-image";
  static const String replicateSaveGenerated = "media/replicate/save-generated";

  // Schedule/Posts Endpoints
  static const String posts = "posts";
  static const String postsAiRewrite = "posts/ai-rewrite";
  static const String postsGenerator = "posts/generator";

  // Home/Overview Endpoints
  static const String overview = "overview";
  static const String recentPosts = "overview/recent-posts";
}
