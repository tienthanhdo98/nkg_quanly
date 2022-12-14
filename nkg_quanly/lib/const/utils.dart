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
        "${converWeekday(thu)}, ng??y $ngay th??ng $thang N??m ${caluAsianYear(nam)}";
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

    var strDate = "${converWeekday(thu)}, $ngay th??ng $thang N??m $nam";

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

    var strDate = "$ngay th??ng $thang,$nam";

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
    timeUnit = 'ph??t';
  } else if (diffInHours < 24) {
    timeValue = diffInHours;
    timeUnit = 'gi???';
  } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
    timeValue = (diffInHours / 24).floor();
    timeUnit = 'ng??y';
  } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
    timeValue = (diffInHours / (24 * 7)).floor();
    timeUnit = 'tu???n';
  } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
    timeValue = (diffInHours / (24 * 30)).floor();
    timeUnit = 'th??ng';
  } else {
    timeValue = (diffInHours / (24 * 365)).floor();
    timeUnit = 'n??m';
  }
  timeAgo = '$timeValue $timeUnit';
  return '$timeAgo tr?????c';
}

String converWeekday(int weekday) {
  var thu = "";
  switch (weekday) {
    case 1:
      thu = "Th??? hai";
      break;
    case 2:
      thu = "Th??? ba";
      break;
    case 3:
      thu = "Th??? t??";
      break;
    case 4:
      thu = "Th??? n??m";
      break;
    case 5:
      thu = "Th??? s??u";
      break;
    case 6:
      thu = "Th??? b???y";
      break;
    case 7:
      thu = "Ch??? nh???t";
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
      can = "T??n";
      break;
    case 2:
      can = "Nh??m";
      break;
    case 3:
      can = "Qu??";
      break;
    case 4:
      can = "Gi??p";
      break;
    case 5:
      can = "???t";
      break;
    case 6:
      can = "B??nh";
      break;
    case 7:
      can = "??inh";
      break;
    case 8:
      can = "M???u";
      break;
    case 9:
      can = "K???";
      break;
  }
  String chi = "";
  switch (year % 12) {
    case 0:
      chi = "Th??n";
      break;
    case 1:
      chi = "D???u";
      break;
    case 2:
      chi = "Tu???t";
      break;
    case 3:
      chi = "H???i";
      break;
    case 4:
      chi = "T??";
      break;
    case 5:
      chi = "S???u";
      break;
    case 6:
      chi = "D???n";
      break;
    case 7:
      chi = "M??o";
      break;
    case 8:
      chi = "Th??n";
      break;
    case 9:
      chi = "T???";
      break;
    case 10:
      chi = "Ng???";
      break;
    case 11:
      chi = "M??i";
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
      title = "TH???NG K?? T??? L??? GI???I T??NH TRONG C??NG CH???C";
      break;
    case "TyLeDangVienCongChuc":
      title = "TH???NG K?? T??? L??? ?????NG VI??N TRONG C??NG CH???C";
      break;
    case "CoCauCongChucTheoNgach":
      title = "C?? C???U C??NG CH???C THEO NG???CH C??NG CH???C";
      break;
    case "CoCauCongChucTheoChuyenMon":
      title = "C?? C???U C??NG CH???C THEO CHUY??N M??N";
      break;
    case "CoCauCongChucTheoQuanLyNhaNuoc":
      title = "C?? C???U C??NG CH???C THEO NH?? N?????C";
      break;
    case "DanTocThieuSoTrongCongChuc":
      title = "TH???NG K?? T??? L??? D??N T???C THI???U S??? TRONG C??NG CH???C";
      break;
    case "CoCauCongChucTheoChinhTri":
      title = "C?? C???U C??NG CH???C THEO CH??NH TR???";
      break;
    case "CoCauCongChucTheoNgoaiNgu":
      title = "C?? C???U C??NG CH???C THEO NGO???I NG???";
      break;
    case "CoCauCongChucTheoDoTuoi":
      title = "C?? C???U C??NG CH???C THEO ????? TU???I";
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
      title = "Bi???u ????? so s??nh ph??? c???p m???m non";
      break;
    case "BieuDoSoSanhPhoCapTieuHoc":
      title = "Bi???u ????? so s??nh ph??? c???p ti???u h???c";
      break;
    case "BieuDoSoSanhPhoCapTrungHocCoSo":
      title = "Bi???u ????? so s??nh ph??? c???p trung h???c c?? s???";
      break;
    case "BieuDoSoSanhMucDoXoaMuChu":
      title = "Bi???u ????? so s??nh m???c ????? x??a m?? ch???";
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
