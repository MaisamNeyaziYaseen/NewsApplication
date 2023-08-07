class DataHelper {
  static String formatTimeAgo(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString).toLocal();
    const jordanTimeZoneOffset = Duration(hours: 3); // Jordan is at GMT+3
    final now = DateTime.now().add(jordanTimeZoneOffset);
    final difference = now.difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? "day" : "days"} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? "hour" : "hours"} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? "minute" : "minutes"} ago';
    } else {
      return 'just now';
    }
  }
}
