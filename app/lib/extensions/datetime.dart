import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toReadableFormat() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.isNegative) {
      return DateFormat.yMMMd().format(this);
    }

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }

    return DateFormat('MMM d, yyyy').format(this);
  }
}
