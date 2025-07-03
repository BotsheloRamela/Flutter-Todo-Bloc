
import 'package:flutter_todo_bloc/core/logger.dart';
import 'package:intl/intl.dart' show DateFormat;

class DateTimeUtils {
  /// Generates a UTC timestamp for the current time.
  static String getCurrentUtcTimestamp() => DateTime.now().toUtc().toIso8601String();

  /// Converts a UTC timestamp string to a formatted date string.
  /// The input timestamp is expected to be in ISO 8601 format.
  /// Returns the date in "day, Month, year"
  static String? formatUtcTimestampToDate(String utcTimestamp) {
    try {
      final dateTime = DateTime.parse(utcTimestamp).toLocal();
      // Using 'd' for day, 'MMM' for abbreviated month, and 'yyyy' for year.
      return DateFormat('d, MMM, yyyy').format(dateTime);
    } catch (e) {
      // Handle invalid timestamp format
      logger.e('Error parsing UTC timestamp: $e');
      return null;
    }
  }
}
