import 'package:intl/intl.dart'; // Import the intl package

class HelperFunction {
  static String formatDate(String? dateString) {
    if (dateString == null) {
      return '';
    }
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      // Handle error if the date string is not in the expected format
      return dateString;
    }
  }
}
