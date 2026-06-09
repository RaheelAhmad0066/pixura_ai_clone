import 'package:intl/intl.dart';

class AppDateUtils {
  /// Parse API date string with proper timezone handling
  static DateTime? parseApiDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      // Parse as UTC and convert to local time for display
      final utcDate = DateTime.parse(dateString).toUtc();
      return utcDate.toLocal();
    } catch (e) {
      // Fallback to tryParse if the string format is different
      return DateTime.tryParse(dateString)?.toLocal();
    }
  }

  /// Standard date format: January 19, 2002
  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMMM d, y').format(date);
  }

  /// Parse date from formatted string: January 19, 2002
  static DateTime? parseDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      return DateFormat('MMMM d, y').parse(dateString);
    } catch (e) {
      // Try alternative formats if the main format fails
      try {
        return DateFormat('MMM d, y').parse(dateString);
      } catch (e) {
        try {
          return DateFormat('yyyy-MM-dd').parse(dateString);
        } catch (e) {
          return null;
        }
      }
    }
  }

  /// Format with time: January 19, 2002 - 10:00 AM
  static String formatDateWithTime(DateTime? date) {
    if (date == null) return '';
    return '${formatDate(date)} - ${formatTime(date)}';
  }

  /// Standard time format: 10:00 AM
  static String formatTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('h:mm a').format(date);
  }

  /// Format with timezone info: 10:00 AM EST
  static String formatTimeWithTimezone(DateTime? date) {
    if (date == null) return '';
    final timeFormat = DateFormat('h:mm a');
    try {
      final timezoneFormat = DateFormat('zzz');
      return '${timeFormat.format(date)} ${timezoneFormat.format(date)}';
    } catch (e) {
      // Fallback to just time if timezone formatting fails
      return timeFormat.format(date);
    }
  }

  /// Compact date format if needed (e.g. for small cards): Jan 19, 2002
  static String formatShortDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM d, y').format(date);
  }

  /// Format date and time with timezone: January 19, 2002 - 10:00 AM EST
  static String formatDateTimeWithTimezone(DateTime? date) {
    if (date == null) return '';
    return '${formatDate(date)} - ${formatTimeWithTimezone(date)}';
  }
}
