import 'package:intl/intl.dart';
import 'package:nkg_quanly/const/ultils.dart';

export 'package:table_calendar/table_calendar.dart';
export 'package:intl/intl.dart';
export 'package:get/get.dart';


DateTime dateNow = DateTime.now();
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
String formatDateToString(DateTime value){
  try {
    var format2 = DateFormat("yyyy-MM-dd");
    var str2 = format2.format(value);
    return str2;
  }catch (_){
    return "";
  }
}
String formatDateToStringHour(String fromTime,String toTime){
  try {
    var baseFormat = DateFormat("yyyy-MM-DDThh:mm:ss");
    var resFormat = DateFormat("hh:mm");
    DateTime fromtime = baseFormat.parse(fromTime);
    var strFromTime = resFormat.format(fromtime);

    DateTime totime = baseFormat.parse(toTime);
    var strtoTime = resFormat.format(totime);

    return "$strFromTime - $strtoTime";
  }catch (_){
    return "";
  }
}
String formatDateToStringtype2(DateTime value){
  try {
    var format2 = DateFormat("dd/MM/yyyy");
    var str2 = format2.format(value);
    return str2;
  }catch (_){
    return "";
  }
}
DateTime convertStringToDate(String value){
  try {
    var format2 = DateFormat("dd/MM/yyyy");
    var str2 = format2.parse(value);
    return str2;
  }catch (_){
    return DateTime.now();
  }
}
String convertDateToViDate(DateTime value){
  try {
    var thu = dateNow.weekday;
    var ngay = dateNow.day;
    var thang = dateNow.month;
    var nam = dateNow.year;

    var strDate = "${converWeekday(thu)}, ngày $ngay tháng $thang Năm ${caluAsianYear(nam)}";
    print(thu);
    print(ngay);
    print(thang);
    print(nam);
    return strDate;
  }catch (_){
    return "";
  }
}
String converWeekday(int weekday)
{
  var thu = "";
  switch(weekday)
  {
    case 1: thu = "Thứ hai";
    break;
    case 2: thu = "Thứ ba";
    break;
    case 3: thu = "Thứ tư";
    break;
    case 4: thu = "Thứ năm";
    break;
    case 5: thu = "Thứ sáu";
    break;
    case 6: thu = "Thứ bảy";
    break;
    case 7: thu = "Chủ nhật";
    break;
  }
  return thu;
}
String caluAsianYear(int year)
{
  String can = "";
  switch (year % 10) {
    case 0:
      can = "Canh";
      break;
    case 1:
      can = "Tân";
      break;
    case 2:
      can = "Nhâm";
      break;
    case 3:
      can = "Quý";
      break;
    case 4:
      can = "Giáp";
      break;
    case 5:
      can = "Ất";
      break;
    case 6:
      can = "Bính";
      break;
    case 7:
      can = "Đinh";
      break;
    case 8:
      can = "Mậu";
      break;
    case 9:
      can = "Kỷ";
      break;
  }
  String chi = "";
  switch(year % 12){
    case 0:
      chi="Thân";
      break;
    case 1:
      chi="Dậu";
      break;
    case 2:
      chi="Tuất";
      break;
    case 3:
      chi="Hợi";
      break;
    case 4:
      chi="Tý";
      break;
    case 5:
      chi="Sửu";
      break;
    case 6:
      chi="Dần";
      break;
    case 7:
      chi="Mão";
      break;
    case 8:
      chi="Thìn";
      break;
    case 9:
      chi="Tỵ";
      break;
    case 10:
      chi="Ngọ";
      break;
    case 11:
      chi="Mùi";
      break;
  }

  return "$can $chi";
}
String getStringFilterFromMap(RxMap mapPickAll,RxMap rxMapSelect,int indexOfMap)
{
  var res = "";
  if(mapPickAll.containsKey(indexOfMap))
  {
    res = "";
  }
  else
  {
    rxMapSelect.forEach((key, value) {
      res += value;
    });
  }
  return res;
}
String checkingStringNull(String? value)
{
  if(value != null)
    {
      return value;
    }
  else
    {
      return "";
    }
}
// bool isSameDay(DateTime? a, DateTime? b) {
//   if (a == null || b == null) {
//     return false;
//   }
//
//   return a.year == b.year && a.month == b.month && a.day == b.day;
// }
