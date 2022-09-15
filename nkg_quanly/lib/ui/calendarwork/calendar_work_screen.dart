import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';
import 'package:nkg_quanly/model/calendarwork_model/calendarwork_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import '../../viewmodel/home_viewmodel.dart';
import 'calendar_work_detail.dart';
import 'calendar_work_search.dart';

class CalendarWorkScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WorkScheduleInfoState();
}

class WorkScheduleInfoState extends State<CalendarWorkScreen> {
  DateTime dateNow = DateTime.now();
  int selected = 0;
  int selectedButton = 0;

  final homeController = Get.put(HomeViewModel());

  @override
  void initState() {
    int curDay = dateNow.weekday;
    selected = curDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: homeController.postCalendarWork(),
          builder: (context, AsyncSnapshot<CalendarWorkModel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  //header
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/icons/ic_arrow_back.png',
                              width: 18,
                              height: 18,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                          Text(
                            "Lịch làm việc",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    Get.to(() => CalendarWorkSearch(
                                    ));
                                  },
                                child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.search)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  //date table
                  Container(
                    width: double.infinity,
                    height: 155,
                    color: kgray,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "${dateNow.year} Tháng ${dateNow.month}",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        //date header
                        TableCalendar(
                          calendarStyle: CalendarStyle(
                              todayTextStyle: const TextStyle(color: kWhite),
                              todayDecoration: BoxDecoration(
                                color: kBlueButton,
                                borderRadius: BorderRadius.circular(20),
                              )),
                          calendarBuilders: CalendarBuilders(
                              selectedBuilder: (context, day, focusday) {
                            return Container(
                              decoration:
                                  const BoxDecoration(color: kBlueButton),
                            );
                          }),
                          locale: 'vi_VN',
                          headerVisible: false,
                          calendarFormat: CalendarFormat.week,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: DateTime.now(),
                        ),
                        //list work
                      ],
                    ),
                  ),
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
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                ),
                                const VerticalDivider(width: 1, thickness: 1),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Lịch làm việc",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
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
                        SizedBox(
                          height: 350,
                          child: ListView.builder(
                              itemCount: snapshot.data!.items!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CalendarWorkItem(
                                    index, snapshot.data!.items![index]);
                              }),
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15))
                      ]),
                    ),
                  ),
                  //bottom
                  Expanded(
                      child: Container(
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
                              setState(() {
                                selectedButton = 0;
                              });
                            },
                            child: Container(
                                decoration: (selectedButton == 0)
                                    ? BoxDecoration(
                                        color: kLightBlue,
                                        borderRadius: BorderRadius.circular(50),
                                      )
                                    : const BoxDecoration(),
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: Text("Ngày",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: (selectedButton == 0)
                                                ? kBlueButton
                                                : Colors.black)))),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedButton = 1;
                              });
                            },
                            child: Container(
                                decoration: (selectedButton == 1)
                                    ? BoxDecoration(
                                        color: kLightBlue,
                                        borderRadius: BorderRadius.circular(50),
                                      )
                                    : const BoxDecoration(),
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: Text(
                                  "Tuần",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: (selectedButton == 1)
                                          ? kBlueButton
                                          : Colors.black),
                                ))),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedButton = 2;
                              });
                            },
                            child: Container(
                                decoration: (selectedButton == 2)
                                    ? BoxDecoration(
                                        color: kLightBlue,
                                        borderRadius: BorderRadius.circular(50),
                                      )
                                    : const BoxDecoration(),
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: Text("Tháng",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: (selectedButton == 2)
                                                ? kBlueButton
                                                : Colors.black)))),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Center(child: Text(item.time!)),
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
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                    Text(
                      item.location!,
                      style: CustomTextStyle.secondTextStyle,
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
                        Text(item.type!, style: CustomTextStyle.secondTextStyle)
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
