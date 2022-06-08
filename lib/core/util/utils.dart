import 'package:intl/intl.dart';

String simpleDate(String date) =>
    DateFormat('d MMM yyyy HH:mm').format(DateTime.parse(date).toLocal());
