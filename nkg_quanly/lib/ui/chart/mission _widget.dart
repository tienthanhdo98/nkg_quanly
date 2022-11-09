import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/api.dart';
import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../document_unprocess/document_unprocess _screen.dart';
import '../document_unprocess/document_unprocess_list.dart';
import '../document_unprocess/document_unprocess_viewmodel.dart';
import '../mission/mission_list.dart';
import '../mission/mission_screen.dart';
import '../mission/mission_viewmodel.dart';
import '../theme/theme_data.dart';

class MissionWidget extends GetView {
  final missionViewModel = Get.put(MissionViewModel());
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(
          Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nhiệm vụ",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MissionList()));
                              },
                              child: const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.more_horiz)),
                            )
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tổng văn bản',
                                style: CustomTextStyle.robotow400s12TextStyle),
                            Text(
                              checkingNullNumberAndConvertToString(
                                  missionViewModel
                                      .rxMissionStatistic.value.tong),
                              style: const TextStyle(
                                  color: kBlueButton, fontSize: 40),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ])),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listButtonChart.length,
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
                        child: Text(listButtonChart[index]),
                      )),
                    );
                  }),
            ),
            Obx(() => (missionViewModel.rxDocumentFilterModel.value.items?.isNotEmpty == true) ? chartItemForMission(
                missionViewModel.selectedChartButton.value,
                missionViewModel) : SizedBox()),
          ]),
          context),
    );
  }
}
