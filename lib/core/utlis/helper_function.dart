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

  static String remainingamount(String totalprice, String amount) {
    double total = double.tryParse(totalprice) ?? 0.0;
    double paid = double.tryParse(amount) ?? 0.0;
    return (total - paid).toStringAsFixed(2);
  }
}
