import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../const/api.dart';
import '../../const/widget.dart';
import '../../model/misstion/misstion_statistic.dart';
import '../char3/line_char.dart';
import '../theme/theme_data.dart';
import 'mission_list.dart';
import 'mission_viewmodel.dart';

class MissionScreen extends GetView {
  String? header;
  String? icon;

  final missionController = Get.put(MissionViewModel());

  MissionScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: missionController.getMissionStatistic(),
          builder: (context, AsyncSnapshot<MissionStatisticModel> snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
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
                            child: Column(children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Tổng văn bản',
                                          style: CustomTextStyle
                                              .robotow400s12TextStyle),
                                      Text(
                                        snapshot.data!.tong!.toString(),
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
                                        Text(snapshot.data!.chuaXuLy.toString(),
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
                                          snapshot.data!.dangThucHien
                                              .toString(),
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
                                          snapshot.data!.daHuy.toString(),
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
                                          snapshot.data!.daTamDung.toString(),
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
                                          snapshot.data!.quaHan.toString(),
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
                                          snapshot.data!.trongHan.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ]),
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
                        itemCount: listButtonChart.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Obx(() => ElevatedButton(
                                  style: missionController
                                              .selectedChartButton.value ==
                                          index
                                      ? activeButtonStyle
                                      : unActiveButtonStyle,
                                  onPressed: () async {
                                    await missionController
                                        .getFilterForChart("$apiGetMissionChart$index");
                                    missionController
                                        .selectedChartButton(index);
                                  },
                                  child: Text(listButtonChart[index]),
                                )),
                          );
                        }),
                  ),
                ),
                Obx(() => chartItemForMission(
                    missionController.selectedChartButton.value,
                    missionController)),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => MissionList(
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
              ]);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
              //print(Text(snapshot.error.toString());
              // return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
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

List listButtonChart = [ "Đơn vị ban hành","Mức độ", "Hạn xử lý", "Ngày đến"];
