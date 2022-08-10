import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';
import 'package:nkg_quanly/ui/home/work_schedule_detail.dart';

class WorkScheduleInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WorkScheduleInfoState();
}

class WorkScheduleInfoState extends State<WorkScheduleInfo> {
  DateTime dateNow = DateTime.now();
  List<String> listDay = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];
  List<int> listDate = [7, 8, 9, 10, 11, 12, 13];
  int selected = 0;
  int selectedButton = 0;

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
        child: Column(
          children: [
            //header
            Container(
              color: kWhite,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/icons/ic_back.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    const Text(
                      "Lịch làm việc",
                      style: CustomTextStyle.header1TextStyle,
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              "assets/icons/ic_search.png",
                              width: 24,
                              height: 24,
                            )))
                  ],
                ),
              ),
            ),
            //date table
            Container(
              width: double.infinity,
              height: 155,
              color: kBackGround,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${dateNow.year} Tháng ${dateNow.month}",
                      style: CustomTextStyle.header1TextStyle,
                    ),
                    //date header
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listDay.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 35, 0),
                              child: Column(children: [
                                Text(listDay[index],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: selected == index
                                            ? kBlueButton
                                            : kSecondText)),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                Container(
                                    decoration: (selected == index)
                                        ? BoxDecoration(
                                            color: kBlueButton,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          )
                                        : const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Text(
                                        "${listDate[index]}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: (selected == index)
                                                ? kWhite
                                                : Colors.black),
                                      ),
                                    )),
                              ]),
                            );
                          }),
                    ),
                    //list work
                  ],
                ),
              ),
            ),
            //list work
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                color: kWhite,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(6),
                      ),
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
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                      color: kBackGround,
                      thickness: 2,
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                        itemCount: 6,
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 10, 0)),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh",
                                            style: CustomTextStyle
                                                .header2TextStyle,
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
                ]),
              ),
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  color: kWhite,
                  border: Border(top: BorderSide(color: kLightGray))),
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
                              : BoxDecoration(),
                          height: 40,
                          width: 40,
                          child: Center(child: Text("Ngày" , style: TextStyle(color: (selectedButton == 0) ? kBlueButton : Colors.black)))),
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
                              : BoxDecoration(),
                          height: 40,
                          width: 40,
                          child: Center(
                              child: Text(
                            "Tuần",
                            style: TextStyle(color: (selectedButton == 1) ? kBlueButton : Colors.black),
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
                              : BoxDecoration(),
                          height: 40,
                          width: 40,
                          child: Center(child: Text("Tháng",  style: TextStyle(color: (selectedButton == 2) ? kBlueButton : Colors.black)))),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
