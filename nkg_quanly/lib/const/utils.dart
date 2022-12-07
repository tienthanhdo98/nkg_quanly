import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nkg_quanly/const/style.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../model/contact_model/department_model.dart';
import '../model/contact_model/organ_model.dart';
import 'const.dart';
import 'lunar_calendar.dart';

export 'package:get/get.dart';
export 'package:intl/intl.dart';
export 'package:table_calendar/table_calendar.dart';
export 'package:numberpicker/numberpicker.dart';
export 'package:url_launcher/url_launcher.dart';

DateTime dateNow = DateTime.now();

String formatDate(String value) {
  try {
    var format = DateFormat("yyyy-MM-DDThh:mm:ss");
    var format2 = DateFormat("dd/MM/yyyy");
    var str = format.parse(value);
    var str2 = format2.format(str);
    return str2;
  } catch (_) {
    return "";
  }
}
String formatStrDateToStrDate(String value) {
  try {
    var format = DateFormat("yyyy-MM-DD");
    var format2 = DateFormat("dd/MM/yyyy");
    var str = format.parse(value);
    var str2 = format2.format(str);
    return str2;
  } catch (_) {
    return "";
  }
}

String formatDateToString(DateTime value) {
  try {
    var format2 = DateFormat("yyyy-MM-dd");
    var str2 = format2.format(value);
    return str2;
  } catch (_) {
    return "";
  }
}

String formatDateToStringDD(DateTime value) {
  try {
    var format2 = DateFormat("d");
    var str2 = format2.format(value);
    return str2;
  } catch (_) {
    return "";
  }
}

String convertDateToLunarDate(DateTime dateTime) {
  var ngay = dateTime.day;
  var thang = dateTime.month;
  var nam = dateTime.year;
  List<int> lunarVi = CalendarConverter.solarToLunar(nam, thang, ngay);
  print(lunarVi);
  return "${lunarVi[0]}/${lunarVi[1]}";
}

String formatDateToStringHour(String fromTime, String toTime) {
  try {
    var baseFormat = DateFormat("yyyy-MM-DDThh:mm:ss");
    var resFormat = DateFormat("hh:mm");
    DateTime fromtime = baseFormat.parse(fromTime);
    var strFromTime = resFormat.format(fromtime);

    DateTime totime = baseFormat.parse(toTime);
    var strtoTime = resFormat.format(totime);

    return "$strFromTime - $strtoTime";
  } catch (_) {
    return "";
  }
}

String formatDateToStringtype2(DateTime value) {
  try {
    var format2 = DateFormat("dd/MM/yyyy");
    var str2 = format2.format(value);
    return str2;
  } catch (_) {
    return "";
  }
}

String formatDateToStringWithWeekDay(DateTime value) {
  try {
    var weekDay = converWeekday(value.weekday);
    var format2 = DateFormat("dd/MM/yyyy");
    var str2 = format2.format(value);
    return "$weekDay, $str2";
  } catch (_) {
    return "";
  }
}

DateTime convertStringToDate(String value) {
  try {
    var format2 = DateFormat("dd/MM/yyyy");
    var str2 = format2.parse(value);
    return str2;
  } catch (_) {
    return DateTime.now();
  }
}

DateTime convertStringToDateYYYYMMdd(String value) {
  try {
    var format2 = DateFormat("yyyy-MM-dd");
    var str2 = format2.parse(value);
    return str2;
  } catch (_) {
    return DateTime.now();
  }
}

String convertDateToViDate() {
  try {
    var thu = dateNow.weekday;
    var ngay = dateNow.day;
    var thang = dateNow.month;
    var nam = dateNow.year;

    var strDate =
        "${converWeekday(thu)}, ngày $ngay tháng $thang Năm ${caluAsianYear(nam)}";
    return strDate;
  } catch (_) {
    return "";
  }
}

String convertDateToWeekDayFormat(DateTime value) {
  try {
    var thu = value.weekday;
    var ngay = value.day;
    var thang = value.month;
    var nam = value.year;

    var strDate = "${converWeekday(thu)}, $ngay tháng $thang Năm $nam";

    return strDate;
  } catch (_) {
    return "";
  }
}
String convertDateToWidget(DateTime value) {
  try {
    var thu = value.weekday;
    var ngay = value.day;
    var thang = value.month;
    var nam = value.year;

    var strDate = "${converWeekday(thu)}, $ngay/$thang/$nam";

    return strDate;
  } catch (_) {
    return "";
  }
}

String convertDateToWeekDayFormatWithoutWeeked(DateTime value) {
  try {
    var ngay = value.day;
    var thang = value.month;
    var nam = value.year;

    var strDate = "$ngay tháng $thang,$nam";

    return strDate;
  } catch (_) {
    return "";
  }
}
String displayTimeAgoFromTimestamp(String timestamp) {
  final year = int.parse(timestamp.substring(0, 4));
  final month = int.parse(timestamp.substring(5, 7));
  final day = int.parse(timestamp.substring(8, 10));
  final hour = int.parse(timestamp.substring(11, 13));
  final minute = int.parse(timestamp.substring(14, 16));

  final DateTime videoDate = DateTime(year, month, day, hour, minute);
  final int diffInHours = DateTime.now().difference(videoDate).inHours;

  String timeAgo = '';
  String timeUnit = '';
  int timeValue = 0;

  if (diffInHours < 1) {
    final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
    timeValue = diffInMinutes;
    timeUnit = 'phút';
  } else if (diffInHours < 24) {
    timeValue = diffInHours;
    timeUnit = 'giờ';
  } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
    timeValue = (diffInHours / 24).floor();
    timeUnit = 'ngày';
  } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
    timeValue = (diffInHours / (24 * 7)).floor();
    timeUnit = 'tuần';
  } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
    timeValue = (diffInHours / (24 * 30)).floor();
    timeUnit = 'tháng';
  } else {
    timeValue = (diffInHours / (24 * 365)).floor();
    timeUnit = 'năm';
  }
  timeAgo = '$timeValue $timeUnit';
  return '$timeAgo trước';
}

String converWeekday(int weekday) {
  var thu = "";
  switch (weekday) {
    case 1:
      thu = "Thứ hai";
      break;
    case 2:
      thu = "Thứ ba";
      break;
    case 3:
      thu = "Thứ tư";
      break;
    case 4:
      thu = "Thứ năm";
      break;
    case 5:
      thu = "Thứ sáu";
      break;
    case 6:
      thu = "Thứ bảy";
      break;
    case 7:
      thu = "Chủ nhật";
      break;
  }
  return thu;
}

String caluAsianYear(int year) {
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
  switch (year % 12) {
    case 0:
      chi = "Thân";
      break;
    case 1:
      chi = "Dậu";
      break;
    case 2:
      chi = "Tuất";
      break;
    case 3:
      chi = "Hợi";
      break;
    case 4:
      chi = "Tý";
      break;
    case 5:
      chi = "Sửu";
      break;
    case 6:
      chi = "Dần";
      break;
    case 7:
      chi = "Mão";
      break;
    case 8:
      chi = "Thìn";
      break;
    case 9:
      chi = "Tỵ";
      break;
    case 10:
      chi = "Ngọ";
      break;
    case 11:
      chi = "Mùi";
      break;
  }

  return "$can $chi";
}

String getStringFilterFromMap(
    RxMap mapPickAll, RxMap rxMapSelect, int indexOfMap) {
  var res = "";
  if (mapPickAll.containsKey(indexOfMap)) {
    res = "";
  } else {
    rxMapSelect.forEach((key, value) {
      res += value;
    });
  }
  return res;
}

String checkingStringNull(String? value) {
  if (value != null) {
    return value;
  } else {
    return "";
  }
}

String checkingNullNumberAndConvertToString(int? value) {
  if (value != null) {
    return value.toString();
  } else {
    return "0";
  }
}

String calcuPercen(int first, int total) {
  var f = NumberFormat("####.#", "en_US");
  var res = f.format((first / total) * 100).toString();
  return "$res%";
}

String findNameOfOrganById(List<OrganModel> listOrgan, String organId) {
  var organName = "";
  for (var element in listOrgan) {
    if (element.id == organId) {
      organName = element.name!;
    }
  }
  return organName;
}

String findNameOfDepartById(
    List<DepartmentModel> listDepartment, String departId) {
  var departIdName = "";
  for (var element in listDepartment) {
    if (element.id == departId) {
      departIdName = element.name!;
    }
  }
  return departIdName;
}

String convertTypeToTitleChartPmis(String value) {
  var title = "";
  switch (value) {
    case "TyLeGioiTinhCongChuc":
      title = "THỐNG KÊ TỈ LỆ GIỚI TÍNH TRONG CÔNG CHỨC";
      break;
    case "TyLeDangVienCongChuc":
      title = "THỐNG KÊ TỈ LỆ ĐẢNG VIÊN TRONG CÔNG CHỨC";
      break;
    case "CoCauCongChucTheoNgach":
      title = "CƠ CẤU CÔNG CHỨC THEO NGẠCH CÔNG CHỨC";
      break;
    case "CoCauCongChucTheoChuyenMon":
      title = "CƠ CẤU CÔNG CHỨC THEO CHUYÊN MÔN";
      break;
    case "CoCauCongChucTheoQuanLyNhaNuoc":
      title = "CƠ CẤU CÔNG CHỨC THEO NHÀ NƯỚC";
      break;
    case "DanTocThieuSoTrongCongChuc":
      title = "THỐNG KÊ TỈ LỆ DÂN TỘC THIỂU SỐ TRONG CÔNG CHỨC";
      break;
    case "CoCauCongChucTheoChinhTri":
      title = "CƠ CẤU CÔNG CHỨC THEO CHÍNH TRỊ";
      break;
    case "CoCauCongChucTheoNgoaiNgu":
      title = "CƠ CẤU CÔNG CHỨC THEO NGOẠI NGỮ";
      break;
    case "CoCauCongChucTheoDoTuoi":
      title = "CƠ CẤU CÔNG CHỨC THEO ĐỘ TUỔI";
      break;
    // case "" : title = "";
    // break;

  }
  return title;
}

String convertNameToEducationChartAnalysicReportViName(String value) {
  var title = "";
  switch (value) {
    case "BieuDoSoSanhPhoCapMamNon":
      title = "Biểu đồ so sánh phổ cập mầm non";
      break;
    case "BieuDoSoSanhPhoCapTieuHoc":
      title = "Biểu đồ so sánh phổ cập tiểu học";
      break;
    case "BieuDoSoSanhPhoCapTrungHocCoSo":
      title = "Biểu đồ so sánh phổ cập trung học cơ sở";
      break;
    case "BieuDoSoSanhMucDoXoaMuChu":
      title = "Biểu đồ so sánh mức độ xóa mù chữ";
      break;
  }
  return title;
}

void checkboxFilterValue(
    bool value, int key, String filterValue, RxMap rxMapFilter) {
  if (value == true) {
    var map = {key: filterValue};
    rxMapFilter.addAll(map);
  } else {
    rxMapFilter.remove(key);
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem(this.title, this.valueFilter, this.index, this.rxMapFilter,
      {Key? key})
      : super(key: key);

  final String title;
  final String valueFilter;
  final int index;
  final RxMap rxMapFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Obx(() => (rxMapFilter.containsKey(index))
              ? InkWell(
                  onTap: () {
                    checkboxFilterValue(
                        false, index, "$valueFilter;", rxMapFilter);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: CustomTextStyle.roboto400s16TextStyle,
                        ),
                      ),
                      Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                )
              : InkWell(
                  onTap: () {
                    checkboxFilterValue(
                        true, index, "$valueFilter;", rxMapFilter);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: CustomTextStyle.roboto400s16TextStyle,
                        ),
                      ),
                      Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                )),
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Divider(
              thickness: 1,
              color: kgray,
            )),
      ],
    );
  }
}

class FilterAllItem extends StatelessWidget {
  const FilterAllItem(
    this.title,
    this.index,
    this.mapAllFilter, {
    Key? key,
  }) : super(key: key);

  final String title;
  final int index;
  final RxMap mapAllFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Obx(
          () => (mapAllFilter.containsKey(index)
              ? InkWell(
                  onTap: () {
                    checkboxFilterValue(false, index, "", mapAllFilter);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: CustomTextStyle.roboto700TextStyle,
                        ),
                      ),
                      Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                )
              : InkWell(
                  onTap: () {
                    checkboxFilterValue(true, index, "", mapAllFilter);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: CustomTextStyle.roboto700TextStyle,
                        ),
                      ),
                      Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                )),
        ));
  }
}

void changeValueSelectedFilter(Rx<String> rxSelected, String value) {
  rxSelected.value = value;
}

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday));
}
DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime
      .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday - 1));
}
DateTime findLastDateOfTheMonth(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month + 1, 0);
}
DateTime findFirstDateOfTheMonth(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, 1);
}
