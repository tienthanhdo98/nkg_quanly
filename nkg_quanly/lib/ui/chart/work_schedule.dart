import 'package:flutter/material.dart';

import '../../const.dart';
import '../home/work_schedule_detail.dart';
import '../home/work_schedule_info.dart';
class WorkSchedule extends StatelessWidget {
  const WorkSchedule({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: borderItem(Column(
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
                        const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                        Text("Thứ 5, 28/7/2022",
                            style: Theme.of(context).textTheme.headline1)
                      ],
                    ),
                    Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WorkScheduleInfo()));
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
                    children:  [
                      SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            "Cả ngày",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                      const VerticalDivider(
                          width: 1, thickness: 1),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
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
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
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
                              return WorkScheduleDetail();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text("08:00 - 09:00"),
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh",
                                        style:
                                        Theme.of(context).textTheme.headline2,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 5, 0, 0)),
                                      const Text(
                                        "Phòng họp lớn 01",
                                        style:
                                        CustomTextStyle.secondTextStyle,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 5, 0, 0)),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/ic_camera_d.png",
                                            height: 20,
                                            width: 20,
                                            fit: BoxFit.fill,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0)),
                                          const Text("Họp online",
                                              style: CustomTextStyle
                                                  .secondTextStyle)
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
                    }),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15))
            ],
          ),context),
        )
      ],
    );
  }
}