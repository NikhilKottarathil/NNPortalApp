import 'package:intl/intl.dart';

class DateTimeConversion {
  String convertToDateFormat(
      {required String inputString, String format = 'dd-MM-yyyy',String inputFormat = 'yyyy-MM-ddThh:mm:ss'}) {
    DateTime dateTime = DateFormat(inputFormat).parse(inputString);
    return DateFormat(format).format(dateTime);
  }
  String convertToDateTimeFormat(
      {required String inputString, String format = 'dd-MM-yyyy HH:mm'}) {
    DateTime dateTime = DateFormat('yyyy-MM-ddThh:mm:ss').parse(inputString);
    return DateFormat(format).format(dateTime);
  }
}
