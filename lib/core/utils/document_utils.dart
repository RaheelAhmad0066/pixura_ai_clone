import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pixura_ai/core/utils/toast_utils.dart';
import 'package:pixura_ai/core/services/service_locator.dart';
import 'package:pixura_ai/core/services/api_service.dart';

class DocumentUtils {
  /// View a document or image URL.
  /// Handles viewing via the in-app/system browser.
  static Future<void> viewDocument(
    String? url, {
    required BuildContext context,
    String title = 'Document',
  }) async {
    if (url == null || url.isEmpty) {
      ToastUtils.error('No file available');
      return;
    }

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      } else {
        ToastUtils.error('Could not open document');
      }
    } catch (e) {
      debugPrint('DocumentUtils: Error opening document: $e');
      ToastUtils.error('Failed to open document');
    }
  }

  /// Export (Download and Share) a document.
  static Future<void> exportDocument(
    String? url, {
    required BuildContext context,
    String fileNamePrefix = 'Document',
    String? subject,
  }) async {
    if (url == null || url.isEmpty) {
      ToastUtils.error('No document available for export');
      return;
    }

    try {
      // Show informational toast
      ToastUtils.show('Preparing file for export...');

      final apiService = locator<ApiService>();
      final tempDir = await getTemporaryDirectory();

      // Determine extension from URL
      String extension = '.pdf'; // Default fallback
      final lowerUrl = url.toLowerCase();
      if (lowerUrl.contains('.jpg') || lowerUrl.contains('.jpeg')) {
        extension = '.jpg';
      } else if (lowerUrl.contains('.png')) {
        extension = '.png';
      } else if (lowerUrl.contains('.docx')) {
        extension = '.docx';
      } else if (lowerUrl.contains('.doc')) {
        extension = '.doc';
      } else if (lowerUrl.contains('.xls')) {
        extension = '.xls';
      } else if (lowerUrl.contains('.xlsx')) {
        extension = '.xlsx';
      }

      final fileName =
          '${fileNamePrefix}_${DateTime.now().millisecondsSinceEpoch}$extension';
      final savePath = '${tempDir.path}/$fileName';

      // Download the file
      await apiService.download(url, savePath);

      if (context.mounted) {
        // Share the file
        await Share.shareXFiles([
          XFile(savePath),
        ], subject: subject ?? 'File share');
      }
    } catch (e) {
      debugPrint('DocumentUtils: Error exporting document: $e');
      ToastUtils.error('Failed to export document');
    }
  }
}
