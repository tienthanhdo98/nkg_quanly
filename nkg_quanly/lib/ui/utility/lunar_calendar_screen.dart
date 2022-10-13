import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import '../../const/const.dart';
import '../../const/lunar_calendar.dart';
import '../../const/widget.dart';
import '../profile/profile_viewmodel.dart';

class LunarCalendarScreen extends GetView {
  final String? header;


  final profileViewModel = Get.put(ProfileViewModel());

  LunarCalendarScreen({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget(header!, context),
              Expanded(
                child: Container(
                  color: kgray,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Obx(() =>
                                Text(
                                  "${menuController
                                      .rxYear} Tháng ${menuController.rxMonth}",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline2,
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
                                  return const SizedBox(
                                      height: 300,
                                      child:
                                      DayPickerBottomSheetForLunarCalendar());
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
                      Obx(() =>
                          Expanded(
                            child: TableCalendar(
                              locale: 'vi_VN',
                              headerVisible: false,
                              calendarFormat: CalendarFormat.month,
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: menuController.rxSelectedDay.value,
                              selectedDayPredicate: (day) {
                                return isSameDay(
                                    menuController.rxSelectedDay.value, day);
                              },
                              onPageChanged: (value) {
                                print("onPageChanged");
                                menuController.changeMonthInDateTable(
                                    value.month);
                                menuController.changeYearInDateTable(value.year);
                              },
                              onDaySelected: (selectedDay, focusedDay) async {
                                print("onDaySelected");
                                if (!isSameDay(menuController.rxSelectedDay.value,
                                    selectedDay)) {
                                  menuController.changeSelectedDayInDateTable(
                                      selectedDay);
                                }
                              },
                              daysOfWeekHeight: 40,
                              // height between the date rows, default is 52.0
                              rowHeight: 80,
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  return Column(children: [
                                    Text(formatDateToStringDD(day),
                                      style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration:BoxDecoration(
                                          color:kBlueButtonOpa80,
                                          borderRadius: BorderRadius.circular(8),

                                      ) ,
                                      child: Text(convertDateToLunarDate(day),
                                        style: const TextStyle(
                                            fontSize: 14, color: kBlueButton,fontWeight: FontWeight.w500),),
                                    )

                                  ],);
                                },
                                outsideBuilder: (context, day, focusedDay) {
                                  return Column(children: [
                                    Text(formatDateToStringDD(day),
                                      style: const TextStyle(
                                          fontSize: 18, color: kDark2Gray,fontWeight: FontWeight.w600),),
                                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration:BoxDecoration(
                                          color:kBlueButtonOpa80,
                                          borderRadius: BorderRadius.circular(8),
                                      ) ,
                                      child: Text(convertDateToLunarDate(day),
                                        style: const TextStyle(
                                            fontSize: 14, color: kBlueButton),),
                                    )

                                  ],);
                                },
                                todayBuilder: (context, day, focusedDay) {
                                  return Column(children: [
                                    Text(formatDateToStringDD(day),
                                      style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                    Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration:BoxDecoration(
                                        color:kBlueButtonOpa80,
                                        borderRadius: BorderRadius.circular(8),

                                      ) ,
                                      child: Text(convertDateToLunarDate(day),
                                        style: const TextStyle(
                                            fontSize: 14, color: kBlueButton,fontWeight: FontWeight.w500),),
                                    )

                                  ],);
                                },
                                selectedBuilder: (context, day, focusedDay) {
                                  return Column(children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                                      decoration:BoxDecoration(
                                        color: kBlueButton,
                                        borderRadius: BorderRadius.circular(30),

                                      ),
                                      child: Text(formatDateToStringDD(day),
                                        style: const TextStyle(
                                            fontSize: 18, color: kWhite,fontWeight: FontWeight.w600),),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration:BoxDecoration(
                                        color:kBlueButtonOpa80,
                                        borderRadius: BorderRadius.circular(8),

                                      ) ,
                                      child: Text(convertDateToLunarDate(day),
                                        style: const TextStyle(
                                            fontSize: 14, color: kBlueButton),),
                                    )
                                  ],);
                                },
                              ),

                            ),
                          )),
                      Obx(() => Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border(
                                top: BorderSide(
                                    color: Theme.of(context).dividerColor))),
                        height: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {

                                  profileViewModel.swtichBottomButton(0);
                                },
                                child: bottomDateButton(
                                    "Ngày",
                                    profileViewModel.selectedBottomButton.value,
                                    0),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  profileViewModel.swtichBottomButton(1);
                                },
                                child: bottomDateButton(
                                    "Tuần",
                                    profileViewModel.selectedBottomButton.value,
                                    1),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  profileViewModel.swtichBottomButton(2);
                                },
                                child: bottomDateButton(
                                    "Tháng",
                                    profileViewModel.selectedBottomButton.value,
                                    2),
                              ),
                            )
                          ],
                        ),
                      ))

                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}