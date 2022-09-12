import 'package:intl/intl.dart';

String formatDate(String value){
  try {
    var format = DateFormat("yyyy-MM-DDThh:mm:ss");
    var format2 = DateFormat("dd/MM/yyyy");
    var str = format.parse(value);
    var str2 = format2.format(str);
    return str2;
  }catch (_){
    return "";
  }
}