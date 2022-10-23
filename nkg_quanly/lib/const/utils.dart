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

String convertNameToPreSchoolChartAnalysicReportViName(String value) {
  var title = "";
  switch (value) {
    case "BieuDoCoCauTreEmTheoCapHoc":
      title = "Biểu đồ cơ cấu trẻ em theo cấp học";
      break;
    case "BieuDoCoCauTreEmTheoNhom":
      title = "Biểu đồ cơ cấu trẻ em theo nhóm";
      break;
    case "BieuDoCoCauTreEmTheoDonVi":
      title = "Biểu đồ cơ cấu trẻ em theo đơn vị";
      break;
    case "BieuDoCoCauTreEmTheoGioiTinh":
      title = "Biểu đồ cơ cấu trẻ em theo giới tính";
      break;
    case "BieuDoCoCauTreEmTheoDanToc":
      title = "Biểu đồ cơ cấu trẻ em theo dân tộc";
      break;
    case "BieuDoCoCauTreEmTheoHinhThucHoc":
      title = "Biểu đồ cơ cấu trẻ em theo hình thức học";
      break;
    case "BieuDoSoSanhSoLuongTreEm":
      title = "Biểu đồ so sánh số lượng trẻ em";
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom12":
      title = "Biểu đồ so sánh số lượng bình quân trẻ em/nhóm 1-2t";
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom23":
      title = "Biểu đồ so sánh số lượng bình quân trẻ em/nhóm 2-3t";
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom34":
      title = "Biểu đồ so sánh số lượng bình quân trẻ em/nhóm 3-4t";
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom45":
      title = "Biểu đồ so sánh số lượng bình quân trẻ em/nhóm 4-5t";
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom56":
      title = "Biểu đồ so sánh số lượng bình quân trẻ em/nhóm 5-6t";
      break;
    case "BieuDoTyLeTreTheoDinhDuong":
      title = "Biểu đồ tỷ lệ trẻ theo dinh dưỡng";
      break;
    case "BieuDoSoSanhTyLeTreEmNuSuyDinhDuongTheoDanToc":
      title = "Biểu đồ thống kê tỷ lệ trẻ em nữ suy dinh dưỡng theo dân tộc";
      break;
    case "TongSoTreDuocKiemTraSucKhoe":
      title = "Tổng số trẻ được kiểm tra sức khỏe";
      break;
    case "CoCauMamNonTheoLoaiTruong":
      title = "Cơ cấu trường mầm non theo loại trường";
      break;
    case "CoCauMamNonTheoDonViThanhLap":
      title = "Cơ cấu trường mầm non theo đơn vị thành lập";
      break;
    case "CoCauMamNonTheoMucDoTruongChuanQuocGia":
      title = "Cơ cấu trường mầm non theo mức độ trường chuẩn quốc gia";
      break;
    case "CoCauPhongHocTheoLoaiPhong":
      title = "Cơ cấu phòng học theo loại phòng";
      break;
    case "BieuDoSoSanhSoLuongPhongHoc":
      title = "Biểu đồ so sánh số lượng phòng học";
      break;
    case "BieuDoSoSanhSoLuongPhongHocNhoMuon":
      title = "Biểu đồ so sánh số lượng phòng học nhờ, mượn";
      break;
    case "BieuDoSoSanhSoLuongPhongHocPhucVuHocTap":
      title = "Biểu đồ so sánh số lượng phòng phục vụ học tập";
      break;
    case "BieuDoSoSanhSoLuongPhongHocKhac":
      title = "Biểu đồ so sánh số lượng phòng khác";
      break;
    case "BieuDoSoSanhSoLuongTruong":
      title = "Biểu đồ so sánh số lượng trường";
      break;
    case "BieuDoSoSanhSoLuongTruongDatChuan":
      title = "Biểu đồ so sánh số lượng trường đạt chuẩn";
      break;
    case "BieuDoSoSanhSoLuongLop":
      title = "Biểu đồ thống kê tỷ lệ trường đạt chuẩn quốc gia";
      break;
    case "BieuDoSoSanhSoLuongTheoLop":
      title = "Biểu đồ so sánh số lượng theo lớp";
      break;
    case "BieuDoSoSanhSoLuongTheoNhomTre":
      title = "Biểu đồ so sánh số lượng theo nhóm trẻ";
      break;
    case "BieuDoSoSanhTyLeTruongDatChuanQuocGia":
      title = "Biểu đồ so sánh số lượng lớp";
      break;
    case "BieuDoSoSanhSoLuongNhom":
      title = "Biểu đồ so sánh số lượng nhóm trẻ theo vùng";
      break;
    case "BieuDoCoCauCanBoGiaoVienNhanVienLaNuTheoDanTocThieuSo":
      title = "Biểu đồ cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số";
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVien":
      title = "Biểu đồ cơ cấu giáo viên theo trình độ đào tạo";
      break;
    case "BieuDoSoSanhBinhQuanSoGiaoVienNhom":
      title = "Biểu đồ cơ cấu giáo viên theo độ tuổi";
      break;
    case "BieuDoSoSanhBinhQuanSoGiaoVienLop":
      title = "Biểu đồ cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp";
      break;
    case "BieuDoSoSanhBinhQuanSoTreNhaTreGiaoVien":
      title = "";
      break;
    case "BieuDoSoSanhBinhQuanSoTreMauGiaoGiaoVien":
      title = "";
      break;
    case "BieuDoCoCauGiaoVienCapMamNonChiaTheoTrinhDoDaoTao":
      title = "";
      break;
    case "BieuDoCoCauGiaoVienCapMamNonChiaTheoDanhGiaChuanChuyenNghiep":
      title = "";
      break;
    case "BieuDoSoSanhSoBinhQuanGiaoVien":
      title = "";
      break;
    case "SoGiaoVienNghiHuuTuyenMoi":
      title = "";
      break;
    case "BieuDoCoCauGiaoVienCapMamNonChiaTheoDoTuoi":
      title = "";
      break;
    case "BieuDoSoSanhSoLuongGiaoVien":
      title = "";
      break;
    case "BieuDoSoSanhSoLuongGiaoVienDatChuan":
      title = "";
      break;
    case "BieuDoSoSanhTyLeGiaoVienDatChuan":
      title = "";
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
