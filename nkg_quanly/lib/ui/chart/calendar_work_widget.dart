import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/calendarwork/calendar_work_screen.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../calendarwork/calendar_work_viewmodel.dart';

class CalendarWorkWidget extends StatelessWidget {
  CalendarWorkWidget({
    Key? key,
  }) : super(key: key);
  final calendarWorkController = Get.put(CalendarWorkViewModel());
  @override
  Widget build(BuildContext context) {
    calendarWorkController.onSelectDay(dateNow);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lịch làm việc",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                        Text(convertDateToWidget(dateNow),
                            style: Theme.of(context).textTheme.headline1)
                      ],
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CalendarWorkScreen()));
                      },
                      child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.more_horiz)),
                    ))
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              //table
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: double.infinity,
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            "Cả ngày",
                            style: Theme.of(context).textTheme.headline2,
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
                              style: Theme.of(context).textTheme.headline2),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 300,
                child: Obx(() => (calendarWorkController
                    .rxCalendarWorkListItems.isNotEmpty)
                    ? ListView.builder(
                    controller: calendarWorkController.controller,
                    itemCount:
                    calendarWorkController.rxCalendarWorkListItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CalendarWorkItem(
                          index,
                          calendarWorkController
                              .rxCalendarWorkListItems[index]);
                    })
                    : noData()),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15))
            ],
          ),
          context),
    );
  }
}
