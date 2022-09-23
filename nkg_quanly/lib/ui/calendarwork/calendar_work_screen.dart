import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';
import 'package:nkg_quanly/const/ultils.dart';
import 'package:nkg_quanly/model/calendarwork_model/calendarwork_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import '../../const/widget.dart';
import 'calendar_work_detail.dart';
import 'calendar_work_search.dart';
import 'calendar_work_viewmodel.dart';

class CalendarWorkScreen extends GetView {
  CalendarWorkScreen({Key? key}) : super(key: key);
  final calendarWorkController = Get.put(CalendarWorkViewModel());
  DateTime dateNow = DateTime.now();
  int selected = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Column(
          children: [
            //header
            headerWidgetSeatch( "Lịch làm việc",CalendarWorkSearch()
            ,context),
            //date table
        headerTableDate( Obx(() =>  TableCalendar(
            locale: 'vi_VN',
            headerVisible: false,
            calendarFormat:  calendarWorkController.rxCalendarFormat.value,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: calendarWorkController.rxSelectedDay.value,
            selectedDayPredicate: (day) {
              return isSameDay(
                  calendarWorkController
                      .rxSelectedDay.value,
                  day);
            },
            onDaySelected: (selectedDay, focusedDay) async {
              if (!isSameDay(
                  calendarWorkController
                      .rxSelectedDay.value,
                  selectedDay)) {
                calendarWorkController.onSelectDay(selectedDay);
              }
            },
            onFormatChanged: (format) {
              if (calendarWorkController.rxCalendarFormat.value != format) {
                // Call `setState()` when updating calendar format
                calendarWorkController.rxCalendarFormat.value = format;
              }
            }
        )),
            Center(child: InkWell(
              onTap: (){
                if(calendarWorkController.rxCalendarFormat.value != CalendarFormat.month)
                {
                  calendarWorkController.switchFormat(CalendarFormat.month);
                }
                else
                {
                  calendarWorkController.switchFormat(CalendarFormat.week);
                }
              },
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Image.asset("assets/icons/ic_showmore.png",height: 15,width: 80,)),
            )),context,),
            //list work
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                color: Theme.of(context).cardColor,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                "Cả ngày",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5,
                              ),
                            ),
                          ),
                          const VerticalDivider(
                              width: 1, thickness: 1),
                          const Padding(
                              padding:
                              EdgeInsets.fromLTRB(0, 0, 10, 0)),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Danh sách lịch làm việc",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),

                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15))
                ]),
              ),
            ),
            Obx(() => (calendarWorkController.rxCalendarWorkListItems.isNotEmpty)
                ?
            Expanded(
              child: ListView.builder(
                  itemCount:  calendarWorkController.rxCalendarWorkListItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CalendarWorkItem(
                        index, calendarWorkController.rxCalendarWorkListItems[index]);
                  }),
            ) : Expanded(child: Text("Hôm nay không có lịch làm việc nào",style: Theme.of(context).textTheme.headline4))),
            //bottom button
            Obx(() =>  Container(
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
                        calendarWorkController.rxSelectedDay.value = DateTime.now();
                        calendarWorkController.onSelectDay(DateTime.now());
                        calendarWorkController.swtichBottomButton(0);
                      },
                      child:  bottomDateButton("Tuần",calendarWorkController.selectedBottomButton.value,0),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        DateTime dateTo =  dateNow.add(const Duration(days: 7));
                        String strdateFrom = formatDateToString(dateNow);
                        String strdateTo = formatDateToString(dateTo);
                        calendarWorkController.postCalendarWorkByWeek(strdateFrom,strdateTo);
                        calendarWorkController.swtichBottomButton(1);
                      },
                      child:  bottomDateButton("Tuần",calendarWorkController.selectedBottomButton.value,1),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        calendarWorkController.postCalendarWorkByMonth();
                        calendarWorkController.swtichBottomButton(2);
                      },
                      child:  bottomDateButton("Tháng",calendarWorkController.selectedBottomButton.value,2),
                    ),
                  )
                ],
              ),
            ))
            //bottom
          ],
        ),
      ),
    );
  }
}

class CalendarWorkItem extends StatelessWidget {
  const CalendarWorkItem(this.index, this.item, {Key? key}) : super(key: key);
  final int? index;
  final CalendarWorkListItems item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (BuildContext context) {
            return CarlendarWorkDetail(item);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Center(child: Text(item.time!, style: Theme.of(context).textTheme.headline4)),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name!,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                    Text(
                      item.location!,
                      style: CustomTextStyle.robotow400s12TextStyle,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_camera.png",
                          height: 20,
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                        Text(item.type!,    style: CustomTextStyle.robotow400s12TextStyle,)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
