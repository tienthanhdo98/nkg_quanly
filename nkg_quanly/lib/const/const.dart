import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/birthday/birthday_viewmodel.dart';
import 'package:nkg_quanly/ui/book_room_meet/room_meeting_viewmodel.dart';
import 'package:nkg_quanly/ui/booking_car/booking_car_viewmodel.dart';
import 'package:nkg_quanly/ui/calendarwork/calendar_work_viewmodel.dart';
import 'package:nkg_quanly/ui/document_nonapproved/document_nonapproved_viewmodel.dart';
import 'package:nkg_quanly/ui/document_out/doc_out_viewmodel.dart';
import 'package:nkg_quanly/ui/document_unprocess/document_unprocess_viewmodel.dart';
import 'package:nkg_quanly/viewmodel/date_picker_controller.dart';
import 'package:nkg_quanly/ui/profile/profile_viewmodel.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';
import 'package:nkg_quanly/ui/profile_work/profile_work_viewmodel.dart';
import 'package:nkg_quanly/ui/report/report_viewmodel.dart';
import 'package:nkg_quanly/ui/theme/theme_data.dart';
import 'package:nkg_quanly/ui/workbook/workbook_viewmodel.dart';

import '../ui/helpdesk/helpdesk_viewmodel.dart';
import '../ui/mission/mission_viewmodel.dart';
import '../viewmodel/login_viewmodel.dart';
import 'style.dart';
import 'utils.dart';
import 'widget.dart';

const kBackGround = Color(0xFFf0f2f5);
const kLightGray = Color(0xFFfafafa);
const kLightGray2 = Color(0xFFdedede);
const kSecondText = Color(0xFFa4a4a4);
const kWhite = Color(0xFFffffff);
const kPink = Color(0xFF6510B4);
const kBlueButton = Color(0xFF3D34FF);
const kOrange = Color(0xFFf3722c);
const kViolet = Color(0xFFa155b9);
const kLoginButton = Color(0xFF5149ef);
const kBlueChart = Color(0xFF16bfd6);
const kRedChart = Color(0xFFf94144);
// const kBlueButton = Color(0xFF0060ff);
const kLightBlue = Color(0xFF3D34FF);
const kLightBlueSign = Color(0xFF65C0F7);
// const kLightBlue = Color(0xFFdbeafe);
const kLightBlueButton = Color(0xFF3797fb);

const kLightBlueNotification= Color(0xffccdcfa);

//chart
const kBlueLineChart2 = Color(0xFF61a9f3);
const kBlackText = Color(0xFF494949);

//Dark Mode
const kDBackGround = Color(0xFF1b1c30);
const kDBackgroundItem = Color(0xFF2a2b40);
const kDTable = Color(0xFF5b5c6e);
const kDLine = Color(0xFF727586);

//
const kgray = Color(0xFFF0F2F5);
const kgrayText = Color(0xFFAEAEAE);
const kDarkGray = Color(0xFFD9D9D9);
const kDarkGrayIcon = Color(0xFF6B6B6B);
const kDark2Gray = Color(0xFFCCCCCC);
const kGrayPriority = Color(0xFFBBBBBB);
const kBluePriority = Color(0xFF3D9DF6);
const kRedPriority = Color(0xFFF63D3D);
const kGreenSign = Color(0xFF30A32E);
const kOrangeSign = Color(0xFFFF9D0B);
const kVioletButton = Color(0xFF3D34FF);
const kBlueButtonOpa80 = Color(0x1A3D34FF);
const kVioletBg = Color(0xFFEDECFF);
const kGrayButton = Color(0xFFD9D9D9);
const kDarkBlueChart = Color(0xFF3701AA);
const kDarkGreenChart = Color(0xFF005837);
const kGreenChart = Color(0xFF28a745);

Map<String, String> headers = {"Content-type": "application/json"};
//string

//list
var listColorChart = [
  kBlueChart,
  kGreenSign,
  kOrange,
  kViolet,
  kRedPriority,
  kDarkBlueChart,
  kDarkGreenChart,
  kDarkGreenChart,
];
var listLevel = ["Thấp", "Trung bình", "Cao"];
var listProfileWorkStatus = [
  "Tạo mới",
  "Đã thu hồi",
  "Đang xử lý",
  "Đã hoàn thành",
  "Quá hạn",
  "Trong hạn xử lý",
];
var listDocInStatus = [
  "Đã xử lý",
  "Đang xử lý",
  "Chưa xử lý",
  "Đã bút phê",
  "Chưa bút phê"
];
var listMissionState = [
  "Chưa xử lý",
  "Đang thực hiện",
  "Đã hủy",
  "Đã tạm dừng"
];
var listProfileState = [
  "Tạo mới",
  "Chờ duyệt",
  "Ý kiến đơn vị",
  "Đã thu hồi",
  "Đã duyệt",
  "Chờ tiếp nhận",
  "Đã tiếp nhận",
  "Chờ phát hành",
];
var listReportState = [
  "Đúng hạn",
  "Sớm hạn",
  "Chưa đến hạn",
  "Quá hạn",
  "Đã tiếp nhận",
  "Đã giao",
];

//string
String jsonGetByMonth =
    '{"pageIndex":1,"pageSize":10,"isMonth": true,"dayInMonth":"${formatDateToString(dateNow)}"}';

//key sharepref
const String keyTokebSSO = "tokenSSO";
const String keyTokenIOC = "tokenIOC";

//
final DatePickerController menuController = Get.put(DatePickerController());
final loginViewModel = Get.put(LoginViewModel());

void loadDataByRangeDay(
    GetxController viewModel, String fromDate, String toDate) {
  if (viewModel is MissionViewModel) {
    viewModel.getMissionByFromAndToDate(fromDate, toDate);
    Get.back();
  }
  if (viewModel is CalendarWorkViewModel) {
    viewModel.postCalendarWorkByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is ReportViewModel) {
    viewModel.postReportByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is DocumentNonApproveViewModel) {
    viewModel.getDocumentByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is BirthDayViewModel) {
    viewModel.postBirthDayByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is RoomMeetingViewModel) {
    viewModel.getMeetingRoomByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is BookingCarViewModel) {
    viewModel.postookingCarByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is DocumentOutViewModel) {
    viewModel.getDocumentOutByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is DocumentUnprocessViewModel) {
    viewModel.getDocumentByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is ProfileViewModel) {
    viewModel.postProfileByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is ProfilesProcedureViewModel) {
    viewModel.postProfileProcByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is ProfileWorkViewModel) {
    viewModel.postProfileWorkByWeek(fromDate, toDate);
    Get.back();
  }
  if (viewModel is WorkBookViewModel) {
    Get.back();
  }
  if (viewModel is HelpdeskViewModel) {
    viewModel.posHelpdeskListByWeek(fromDate, toDate);
    Get.back();
  }
}

const DATE_PICKER = "DatePicker";
const TO_DATE = "ToDate";
const FROM_DATE = "FromDate";
const END_DATE = "EndDate";

Widget headerWidgetSearch(
    String header, GetView searchScreen, BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
              bottom: BorderSide(
                width: 1,
                color: Theme.of(context).dividerColor,
              ))),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          menuController.clearAllDateData();
          Get.back();
        },
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios_outlined),
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Expanded(
              child: Text(
                header,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => searchScreen);
              },
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: kgray,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset(
                        'assets/icons/ic_search.png',
                        width: 20,
                        height: 20,
                      ))),
            )
          ],
        ),
      ),
    ),
  );
}

Widget headerTableDatePicker(BuildContext context, GetxController viewModel) {
  return Container(
    color: kgray,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Obx(() => Text(
                    "Tháng ${menuController.rxMonth}/${menuController.rxYear}",
                    style: Theme.of(context).textTheme.headline2,
                  )),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: 220,
                        child: DatePickerOptionBottomSheet(viewModel));
                  },
                );
              },
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Image.asset(
                    "assets/icons/ic_calendar.png",
                    width: 20,
                    height: 20,
                  )),
            ),
          ],
        ),
        Obx(() => TableCalendar(
            locale: 'vi_VN',
            headerVisible: false,
            calendarFormat: menuController.rxCalendarFormat.value,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: menuController.rxSelectedDay.value,
            selectedDayPredicate: (day) {
              return isSameDay(menuController.rxSelectedDay.value, day);
            },
            onPageChanged: (value) {
              menuController.changeMonthInDateTable(value.month);
              menuController.changeYearInDateTable(value.year);
            },
            onDaySelected: (selectedDay, focusedDay) async {
              if (!isSameDay(menuController.rxSelectedDay.value, selectedDay)) {
                menuController.changeSelectedDayInDateTable(selectedDay);
                loadDataByDayNoBack(viewModel);
              }
            },
            onFormatChanged: (format) {
              if (menuController.rxCalendarFormat.value != format) {
                // Call `setState()` when updating calendar format
                menuController.rxCalendarFormat.value = format;
              }
            })),
        Center(
            child: InkWell(
          onTap: () {
            if (menuController.rxCalendarFormat.value != CalendarFormat.month) {
              menuController.switchFormat(CalendarFormat.month);
            } else {
              menuController.switchFormat(CalendarFormat.week);
            }
          },
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Image.asset(
                "assets/icons/ic_showmore.png",
                height: 15,
                width: 80,
              )),
        )),
      ],
    ),
  );
}

class DayPickerBottomSheet extends StatelessWidget {
  const DayPickerBottomSheet(this.viewModel, this.dataType, {Key? key})
      : super(key: key);
  final GetxController? viewModel;
  final String dataType;

  @override
  Widget build(BuildContext context) {
    var day = dateNow.day.toInt();
    var month = dateNow.month.toInt();
    var year = dateNow.year.toInt();
    var strSelectedDate = "";
    var selectedDate = dateNow;
    return Column(children: [
      buttonLineInBottonSheet(),
      const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "Chọn ngày",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
                color: kBlueButton),
          )),
      Obx(() => Text(
            "${converWeekday(menuController.rxWeekDay.value)}, ${menuController.rxDay} tháng ${menuController.rxMonth}, ${menuController.rxYear}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatefulBuilder(
              builder: (context, dayStateChange) {
                return NumberPicker(
                  textStyle: const TextStyle(color: kDarkGray, fontSize: 24),
                  selectedTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 24),
                  value: day,
                  minValue: 1,
                  maxValue: 31,
                  onChanged: (value) => dayStateChange(() {
                    day = value;
                    menuController.changeDayInDateTable(day);
                    strSelectedDate = "$day/$month/$year";
                    selectedDate = convertStringToDate(strSelectedDate);
                    menuController
                        .changeWeekDayInDateTable(selectedDate.weekday);
                  }),
                );
              },
            ),
            StatefulBuilder(
              builder: (context, dayStateChange) {
                return NumberPicker(
                  textStyle: const TextStyle(color: kDarkGray, fontSize: 24),
                  selectedTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 24),
                  value: month,
                  minValue: 1,
                  maxValue: 12,
                  onChanged: (value) => dayStateChange(() {
                    month = value;
                    menuController.changeMonthInDateTable(month);
                    strSelectedDate = "$day/$month/$year";
                    selectedDate = convertStringToDate(strSelectedDate);
                    menuController
                        .changeWeekDayInDateTable(selectedDate.weekday);
                  }),
                );
              },
            ),
            StatefulBuilder(
              builder: (context, dayStateChange) {
                return NumberPicker(
                    textStyle: const TextStyle(color: kDarkGray, fontSize: 24),
                    selectedTextStyle:
                        const TextStyle(color: Colors.black, fontSize: 24),
                    value: year,
                    minValue: 2000,
                    maxValue: 2030,
                    onChanged: (value) => dayStateChange(() {
                          year = value;
                          menuController.changeYearInDateTable(year);
                          strSelectedDate = "$day/$month/$year";
                          selectedDate = convertStringToDate(strSelectedDate);
                          menuController
                              .changeWeekDayInDateTable(selectedDate.weekday);
                        }));
              },
            ),
          ],
        ),
      ),
      Align(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: buttonFilterWhite,
                    child: const Text('Đóng')),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () {
                      if (dataType == DATE_PICKER) {
                        var strSelectedDay = "$day/$month/$year";
                        var selectedDay = convertStringToDate(strSelectedDay);
                        menuController
                            .changeSelectedDayInDateTable(selectedDay);
                        loadDataByDay(viewModel!);
                      }
                      //get todate
                      else if (dataType == TO_DATE) {
                        var strSelectedDay = "$year-$month-$day";
                        var selectedDay =
                            convertStringToDateYYYYMMdd(strSelectedDay);
                        menuController.changeToDate(
                            convertDateToWeekDayFormat(selectedDay),
                            formatDateToString(selectedDay),
                            selectedDay);
                        Get.back();
                      }
                      //get fromdate
                      else if (dataType == FROM_DATE) {
                        var strSelectedDay = "$year-$month-$day";
                        var selectedDay =
                            convertStringToDateYYYYMMdd(strSelectedDay);
                        menuController.changeFromDate(
                            convertDateToWeekDayFormat(selectedDay),
                            formatDateToString(selectedDay),
                            selectedDay);
                        Get.back();
                      } else if (dataType == END_DATE) {
                        var strMonth = "";
                        var strDay = "";

                        if (month < 10) {
                          strMonth = "0$month";
                        } else {
                          strMonth = "$month";
                        }
                        if (day < 10) {
                          strDay = "0$day";
                        } else {
                          strDay = "$day";
                        }

                        var strSelectedDay = "$year-$strMonth-$strDay";
                        var selectedDay =
                            convertStringToDateYYYYMMdd(strSelectedDay);
                        menuController.changeEndDate(
                            convertDateToWeekDayFormatWithoutWeeked(
                                selectedDay),
                            strSelectedDay);
                        Get.back();
                      }
                    },
                    style: buttonFilterBlue,
                    child: const Text('Chọn')),
              ),
            )
          ],
        ),
      )
    ]);
  }
}

class DayPickerBottomSheetForLunarCalendar extends StatelessWidget {
  const DayPickerBottomSheetForLunarCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var day = dateNow.day.toInt();
    var month = dateNow.month.toInt();
    var year = dateNow.year.toInt();
    var strSelectedDate = "";
    var selectedDate = dateNow;
    return Column(children: [
      buttonLineInBottonSheet(),
      const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "Chọn ngày",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
                color: kBlueButton),
          )),
      Obx(() => Text(
            "${converWeekday(menuController.rxWeekDay.value)}, ${menuController.rxDay} tháng ${menuController.rxMonth}, ${menuController.rxYear}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatefulBuilder(
              builder: (context, dayStateChange) {
                return NumberPicker(
                  textStyle: const TextStyle(color: kDarkGray, fontSize: 24),
                  selectedTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 24),
                  value: day,
                  infiniteLoop: true,
                  minValue: 1,
                  maxValue: 31,
                  onChanged: (value) => dayStateChange(() {
                    day = value;
                    menuController.changeDayInDateTable(day);
                    strSelectedDate = "$day/$month/$year";
                    selectedDate = convertStringToDate(strSelectedDate);
                    menuController
                        .changeWeekDayInDateTable(selectedDate.weekday);
                  }),
                );
              },
            ),
            StatefulBuilder(
              builder: (context, dayStateChange) {
                return NumberPicker(
                  textStyle: const TextStyle(color: kDarkGray, fontSize: 24),
                  selectedTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 24),
                  value: month,
                  minValue: 1,
                  infiniteLoop: true,
                  maxValue: 12,
                  onChanged: (value) => dayStateChange(() {
                    month = value;
                    menuController.changeMonthInDateTable(month);
                    strSelectedDate = "$day/$month/$year";
                    selectedDate = convertStringToDate(strSelectedDate);
                    menuController
                        .changeWeekDayInDateTable(selectedDate.weekday);
                  }),
                );
              },
            ),
            StatefulBuilder(
              builder: (context, dayStateChange) {
                return NumberPicker(
                    textStyle: const TextStyle(color: kDarkGray, fontSize: 24),
                    selectedTextStyle:
                        const TextStyle(color: Colors.black, fontSize: 24),
                    value: year,
                    minValue: 2000,
                    maxValue: 2030,
                    onChanged: (value) => dayStateChange(() {
                          year = value;
                          menuController.changeYearInDateTable(year);
                          strSelectedDate = "$day/$month/$year";
                          selectedDate = convertStringToDate(strSelectedDate);
                          menuController
                              .changeWeekDayInDateTable(selectedDate.weekday);
                        }));
              },
            ),
          ],
        ),
      ),
      Align(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: buttonFilterWhite,
                    child: const Text('Đóng')),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () {
                      var strSelectedDay = "$day/$month/$year";
                      var selectedDay = convertStringToDate(strSelectedDay);
                      menuController.changeSelectedDayInDateTable(selectedDay);
                      Get.back();
                    },
                    style: buttonFilterBlue,
                    child: const Text('Chọn')),
              ),
            )
          ],
        ),
      )
    ]);
  }
}

class RangeDayPickerBottomSheet extends StatelessWidget {
  final GetxController? viewModel;

  const RangeDayPickerBottomSheet(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        menuController.clearAllDateData();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              headerWidget("Chọn khoảng thời gian", context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                          child: Text("Từ ngày")),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                  height: 300,
                                  child: DayPickerBottomSheet(
                                      viewModel, FROM_DATE));
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kDarkGray,
                              ),
                              borderRadius: BorderRadius.circular(
                                  5) // use instead of BorderRadius.all(Radius.circular(20))
                              ),
                          child: Row(children: [
                            Expanded(
                              child: Obx(() => Text(
                                    menuController.rxFromDateWithWeekDay.value,
                                  )),
                            ),
                            Obx(() => (menuController
                                        .rxFromDateWithWeekDay.value !=
                                    "")
                                ? IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Image.asset(
                                      "assets/icons/ic_close_2.png",
                                      width: 15,
                                      height: 15,
                                    ),
                                    onPressed: () {
                                      menuController.clearDataDateFrom();
                                    },
                                  )
                                : IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Image.asset(
                                      "assets/icons/ic_date.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                              height: 300,
                                              child: DayPickerBottomSheet(
                                                  viewModel, FROM_DATE));
                                        },
                                      );
                                    },
                                  ))
                          ]),
                        ),
                      ),
                      //den ngay
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                          child: Text("Đến ngày")),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                  height: 300,
                                  child:
                                      DayPickerBottomSheet(viewModel, TO_DATE));
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kDarkGray,
                              ),
                              borderRadius: BorderRadius.circular(
                                  5) // use instead of BorderRadius.all(Radius.circular(20))
                              ),
                          child: Row(children: [
                            Expanded(
                                child: Obx(
                              () => Text(
                                menuController.rxToDateWithWeekDay.value,
                              ),
                            )),
                            Obx(() =>
                                (menuController.rxToDateWithWeekDay.value != "")
                                    ? IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Image.asset(
                                          "assets/icons/ic_close_2.png",
                                          width: 15,
                                          height: 15,
                                        ),
                                        onPressed: () {
                                          menuController.clearDataDateTo();
                                        },
                                      )
                                    : IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Image.asset(
                                          "assets/icons/ic_date.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                  height: 300,
                                                  child: DayPickerBottomSheet(
                                                      viewModel, TO_DATE));
                                            },
                                          );
                                        },
                                      ))
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      loadDataByRangeDay(
                          viewModel!,
                          menuController.rxFromDate.value,
                          menuController.rxToDate.value);
                    },
                    child: buttonShowListScreen("Chọn"),
                    style: bottomButtonStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DatePickerOptionBottomSheet extends StatelessWidget {
  final GetxController? viewModel;

  const DatePickerOptionBottomSheet(this.viewModel, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buttonLineInBottonSheet(),
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 300,
                            child:
                                DayPickerBottomSheet(viewModel, DATE_PICKER));
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_date.png",
                          width: 25,
                          height: 25,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        const Text(
                          "Chọn ngày",
                          style: CustomTextStyle.roboto700TextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() => RangeDayPickerBottomSheet(viewModel));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_range_date.png",
                          width: 25,
                          height: 25,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        const Text(
                          "Chọn khoảng thời gian",
                          style: CustomTextStyle.roboto700TextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
              ]),
        )
      ],
    );
  }
}

Widget borderText(String? value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kgray,
        border: Border.all(color: kDarkGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          value!,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    ),
  );
}

Widget headerWidget(String header, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
            bottom: BorderSide(
          width: 1,
          color: Theme.of(context).dividerColor,
        ))),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          menuController.clearAllDateData();
          Get.back();
        },
        child: Row(
          children: [
            Image.asset(
              'assets/icons/ic_arrow_back.png',
              width: 18,
              height: 18,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Flexible(
              child: Text(
                header,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void loadDataByDay(GetxController viewModel) {
  if (viewModel is MissionViewModel) {
    // viewModel.onSelectDay(menuController.rxSelectedDay.value);
    String strdateFrom = formatDateToString(menuController.rxSelectedDay.value);
    String strdateTo = formatDateToString(menuController.rxSelectedDay.value);
    viewModel.getMissionByFromAndToDate(strdateFrom,strdateTo);
    Get.back();
  }
  if (viewModel is CalendarWorkViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is ReportViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is DocumentUnprocessViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is BirthDayViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is RoomMeetingViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is BookingCarViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is DocumentNonApproveViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is DocumentOutViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is ProfileViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is ProfilesProcedureViewModel) {
    viewModel.postProfileProcByWeek(
        formatDateToString(menuController.rxSelectedDay.value),
        formatDateToString(menuController.rxSelectedDay.value));
    Get.back();
  }
  if (viewModel is ProfileWorkViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is WorkBookViewModel) {
    //  viewModel.onSelectDay(menuController.rxSelectedDay.value);
    Get.back();
  }
  if (viewModel is HelpdeskViewModel) {
    viewModel.posHelpdeskListByWeek(
        formatDateToString(menuController.rxSelectedDay.value),
        formatDateToString(menuController.rxSelectedDay.value));
    Get.back();
  }
}

void loadDataByDayNoBack(GetxController viewModel) {
  if (viewModel is MissionViewModel) {
    // viewModel.onSelectDay(menuController.rxSelectedDay.value);
    String strdateFrom = formatDateToString(menuController.rxSelectedDay.value);
    String strdateTo = formatDateToString(menuController.rxSelectedDay.value);
    viewModel.getMissionByFromAndToDate(strdateFrom,strdateTo);
  }
  if (viewModel is CalendarWorkViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is ReportViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is DocumentUnprocessViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is BirthDayViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is RoomMeetingViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is BookingCarViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is DocumentNonApproveViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is DocumentOutViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is ProfileViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is ProfilesProcedureViewModel) {
    viewModel.postProfileProcByWeek(
        formatDateToString(menuController.rxSelectedDay.value),
        formatDateToString(menuController.rxSelectedDay.value));
  }
  if (viewModel is ProfileWorkViewModel) {
    viewModel.onSelectDay(menuController.rxSelectedDay.value);
  }
  if (viewModel is WorkBookViewModel) {
    //viewModel.onSelectDay(menuController.rxSelectedDay.value);

  }
  if (viewModel is HelpdeskViewModel) {
    viewModel.posHelpdeskListByWeek(
        formatDateToString(menuController.rxSelectedDay.value),
        formatDateToString(menuController.rxSelectedDay.value));
  }
}
