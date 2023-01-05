import 'package:intl/intl.dart';

class DateConverter
{
 static String dateTimeConverter(String date)
 {
   DateTime parseDate =
   new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
   var format = DateFormat.yMMMMEEEEd();
   var dateString = format.format(parseDate);
   var formatHM = DateFormat.jm();
   var timeString = formatHM.format(parseDate);
   return dateString + ' - ' + timeString;
 }


}