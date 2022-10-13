
import 'package:nkg_quanly/const/utils.dart';

class DatePickerController extends GetxController {
  final RxMap<int, String> listStateStatus = <int, String>{}.obs;
  final RxSet<int> listStatePriority = <int>{}.obs;
  final RxMap<int, String> listPriorityStatus = <int, String>{}.obs;
  final RxMap<int, String> listDepartmentStatus = <int, String>{}.obs;
  final Rx<int> rxMonth = dateNow.month.obs;
  final Rx<int> rxYear = dateNow.year.obs;
  final Rx<int> rxDay = dateNow.day.obs;
  final Rx<int> rxWeekDay = dateNow.weekday.obs;
  final Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;

  //thu 6, ngay 31 thang 10,2020
  Rx<String> rxToDateWithWeekDay = "".obs;
  Rx<String> rxFromDateWithWeekDay = "".obs;

  //31 thang 10,2020
  Rx<String> rxToDateWithoutWeekDay = "".obs;
  Rx<String> rxFromDateWithoutWeekDay ="".obs;

  //han xu ly
  Rx<String> rxEndDate = "".obs;

  Rx<String> rxToDate = formatDateToString(dateNow).obs;
  Rx<String> rxFromDate = formatDateToString(dateNow).obs;



  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
  }

  void changeEndDate(int value) {
    rxEndDate.value = value;
  }


  void changeMonthInDateTable(int value) {
    rxMonth.value = value;
  }

  void changeYearInDateTable(int value) {
    rxYear.value = value;
  }

  void changeDayInDateTable(int value) {
    rxDay.value = value;
  }

  void changeWeekDayInDateTable(int value) {
    rxWeekDay.value = value;
  }

  void changeSelectedDayInDateTable(DateTime value) {
    rxSelectedDay.value = value;
  }

  void checkboxPriorityState(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      listPriorityStatus.addAll(map);
    } else {
      listPriorityStatus.remove(key);
    }
  }

  void checkboxDepartmentState(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      listDepartmentStatus.addAll(map);
    } else {
      listDepartmentStatus.remove(key);
    }
  }

  void checkboxStatusState(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      listStateStatus.addAll(map);
    } else {
      listStateStatus.remove(key);
    }
    print(listStateStatus.toString());
  }

  //show more info in screen list eoffice
  Rx<bool> rxShowStatistic = false.obs;

  void changeStateShowStatistic(bool value) {
    rxShowStatistic.value = value;
  }

  void changeToDate(String? valueWeekDay, String valueWithoutWeekDay,DateTime date) {
    rxToDateWithWeekDay.value = valueWeekDay!;
    rxToDate.value = valueWithoutWeekDay;
    rxToDateWithoutWeekDay.value = convertDateToWeekDayFormatWithoutWeeked(date);

  }

  void changeFromDate(String? valueWeekDay, String valueWithoutWeekDay,DateTime date) {
    rxFromDateWithWeekDay.value = valueWeekDay!;
    rxFromDate.value = valueWithoutWeekDay;
    rxFromDateWithoutWeekDay.value = convertDateToWeekDayFormatWithoutWeeked(date);
  }
}
