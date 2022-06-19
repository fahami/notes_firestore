import 'package:intl/intl.dart';

String simpleDate(String? date) {
  if (date == null) {
    return "Tidak diketahui";
  }
  return DateFormat('d MMM yyyy HH:mm aa')
      .format(DateTime.parse(date).toLocal());
}
