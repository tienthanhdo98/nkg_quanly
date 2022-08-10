import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';
import 'package:nkg_quanly/ui/home/work_schedule_detail.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/ChartModel.dart';
import '../chart/collum_red_chart.dart';
import '../chart/column_chart.dart';
import '../chart/pie_chart.dart';
import '../chart/sline_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: kWhite,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 200,
                    height: 150,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/icons/ic_search.png",
                          width: 25,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const WorkSchedule(),
          ColumnRedChart(),
          PieChart(),
          ColumnChart(),
          SLineChart(),
          const WorkSchedule(),
          PieChart(),
        ],
      ),
    );
  }
}

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
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Lịch làm việc",
                            style: CustomTextStyle.header1TextStyle,
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                          Text("Thứ 5, 28/7/2022",
                              style: CustomTextStyle.header1TextStyle)
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                "assets/icons/ic_more.png",
                                width: 20,
                                height: 20,
                              )))
                    ],
                  ),
                ),
                const Divider(
                  color: kBackGround,
                  thickness: 2,
                ),
                //table
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kLightGray,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: double.infinity,
                    height: 40,
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              "Cả ngày",
                              style: CustomTextStyle.header2TextStyle,
                            ),
                          ),
                        ),
                        VerticalDivider(
                            width: 1, color: kBackGround, thickness: 1),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Lịch làm việc",
                                style: CustomTextStyle.header2TextStyle),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Divider(
                    color: kBackGround,
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
                                        const Text(
                                          "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh",
                                          style:
                                              CustomTextStyle.header2TextStyle,
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 5, 0, 0)),
                                        const Text(
                                          "Phòng họp  lớn 01",
                                          style:
                                              CustomTextStyle.secondTextStyle,
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 5, 0, 0)),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/ic_camera.png",
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
            ),
          ),
        )
      ],
    );
  }
}
