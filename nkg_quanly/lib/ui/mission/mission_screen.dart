import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../const/api.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../char3/line_char.dart';
import '../theme/theme_data.dart';
import 'e_office/mission__e_office_list.dart';
import 'mission_list.dart';
import 'mission_viewmodel.dart';

class MissionScreen extends GetView {
  String? header;
  String? icon;

  final missionViewModel = Get.put(MissionViewModel());

  MissionScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          Stack(
            children: [
              Image.asset("assets/bgtophome.png",
                  height: 220, width: double.infinity, fit: BoxFit.cover),
              headerWidget(header!, context),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                child: border(
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Obx(() =>  Column(children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text('Tổng văn bản',
                                    style: CustomTextStyle
                                        .robotow400s12TextStyle),
                                Text(checkingNullNumberAndConvertToString(missionViewModel
                                    .rxMissionStatistic.value.tong),
                                  style: const TextStyle(
                                      color: kBlueButton, fontSize: 40),
                                )
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  icon!,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 0,
                            crossAxisCount: 3,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('Chưa xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(checkingNullNumberAndConvertToString(missionViewModel.rxMissionStatistic.value.chuaXuLy),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('Đang thực hiện',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    checkingNullNumberAndConvertToString(missionViewModel.rxMissionStatistic.value.dangThucHien
                                    ),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã hủy',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    checkingNullNumberAndConvertToString(missionViewModel.rxMissionStatistic.value.daHuy),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã tạm dưng',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    checkingNullNumberAndConvertToString(missionViewModel.rxMissionStatistic.value.daTamDung),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('Quá hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    checkingNullNumberAndConvertToString(missionViewModel.rxMissionStatistic.value.quaHan),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('Trong hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    checkingNullNumberAndConvertToString(missionViewModel.rxMissionStatistic.value.trongHan),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ])),
                    ),
                    context),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listButtonMissionChart.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Obx(() => ElevatedButton(
                        style: missionViewModel
                            .selectedChartButton.value ==
                            index
                            ? activeButtonStyle
                            : unActiveButtonStyle,
                        onPressed: () async {
                          await missionViewModel.getFilterForChart(
                              "$apiGetMissionChart$index");
                          missionViewModel
                              .selectedChartButton(index);
                        },
                        child: Text(listButtonMissionChart[index]),
                      )),
                    );
                  }),
            ),
          ),
          Obx(() => (missionViewModel.rxDocumentFilterModel.value.items?.isNotEmpty == true) ? chartItemForMission(
              missionViewModel.selectedChartButton.value,
              missionViewModel) : SizedBox()),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => MissionEOfficeList(
                        header: header,
                      ));
                    },
                    child: buttonShowListScreen("Xem danh sách nhiệm vụ"),
                    style: bottomButtonStyle,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

Widget chartItemForMission(int index, MissionViewModel missionViewModel) {
  if (index == 0) {
    return Obx(() => LineCharWidget(
        key: UniqueKey(),
        documentFilterModel: missionViewModel.rxDocumentFilterModel.value));
  }
  if (index == 1) {
    return Obx(() => LineCharWidget(
        key: UniqueKey(),
        documentFilterModel: missionViewModel.rxDocumentFilterModel.value));
  }
  if (index == 2) {
    return Obx(() => LineCharWidget(
        key: UniqueKey(),
        documentFilterModel: missionViewModel.rxDocumentFilterModel.value));
  } else {
    return Obx(() => LineCharWidget(
        key: UniqueKey(),
        documentFilterModel: missionViewModel.rxDocumentFilterModel.value));
  }
}

List listButtonMissionChart = ["Đơn vị ban hành", "Mức độ", "Hạn xử lý", "Ngày đến"];
