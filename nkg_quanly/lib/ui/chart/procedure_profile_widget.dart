import 'package:flutter/material.dart';


import '../../const/api.dart';
import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../profile/e_office/profile_e_office_list.dart';
import '../profile/profile_screen.dart';
import '../profile/profile_viewmodel.dart';
import '../profile_procedure_/profiles_procedure_list.dart';
import '../profile_procedure_/profiles_procedure_screen.dart';
import '../profile_procedure_/profiles_procedure_viewmodel.dart';
import '../theme/theme_data.dart';

class ProcedureProfileWidget extends GetView {
  final profilesProcedureViewModel = Get.put(ProfilesProcedureViewModel());

  ProcedureProfileWidget();

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
                                  "Hồ sơ thủ tục hành chính",
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
                                            ProfilesProcedureList()));
                              },
                              child: const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.more_horiz)),
                            )
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 0)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tổng văn bản',
                                style: CustomTextStyle.robotow400s12TextStyle),
                            Text(
                              checkingNullNumberAndConvertToString(
                                  profilesProcedureViewModel
                                      .rxProfileProcedureStatisticTotal.value.tongSoHoSo),
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
            Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Obx(() => ElevatedButton(
                        style: profilesProcedureViewModel
                            .selectedChartButton.value ==
                            0
                            ? activeButtonStyle
                            : unActiveButtonStyle,
                        onPressed: () async {
                          await profilesProcedureViewModel
                              .getFilterForChart(
                              apiGetProfileProcedureChart0);
                          profilesProcedureViewModel
                              .selectedChartButton(0);
                        },
                        child: const Text("Mức độ"),
                      )),
                    )),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10, 0, 10, 10),
                        child: Obx(
                              () => ElevatedButton(
                            style: profilesProcedureViewModel
                                .selectedChartButton
                                .value ==
                                1
                                ? activeButtonStyle
                                : unActiveButtonStyle,
                            onPressed: () async {
                              await profilesProcedureViewModel
                                  .getFilterForChart(
                                  apiGetProfileProcedureChart1);
                              profilesProcedureViewModel
                                  .swtichChartButton(1);
                            },
                            child: const Text("Trạng thái"),
                          ),
                        )))
              ],
            ),
            Obx(() =>ProfileProcChart(profilesProcedureViewModel.selectedBottomButton.value,profilesProcedureViewModel)),
          ]),
          context),
    );
  }
}
