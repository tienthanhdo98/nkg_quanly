import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/char3/collum_chart_doc_nonprocess.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';

class ProfilesProcedureScreen extends GetView {
  String? header;
  String? icon;

  final profilesProcedureViewModel = Get.put(ProfilesProcedureViewModel());

  ProfilesProcedureScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            headerWidget(header!, context),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Stack(
                      children: [
                        Image.asset("assets/bgtophome.png",
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                          child: border(
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text('T???ng h??? s??',
                                              style: CustomTextStyle
                                                  .robotow400s12TextStyle),
                                         Obx(() => Text(
                                           checkingNullNumberAndConvertToString(profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.tongSoHoSo),
                                           style: const TextStyle(
                                               color: kBlueButton,
                                               fontSize: 40,
                                               fontFamily: 'Roboto'),
                                         ))
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
                                      padding:
                                      EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                 Obx(() => SizedBox(
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
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ti???p nh???n tr???c tuy???n',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value
                                                    .hoSoTiepNhanTrucTuyen
                                            ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ti???p nh???n tr???c ti???p',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value
                                                    .hoSoTiepNhanTrucTiep
                                            ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text('H??? s?? ????ng h???n',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.hoSoDungHan
                                              ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text('H??? s?? s???m h???n',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.hoSoSomHan
                                              ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ch??a ?????n h???n',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.hoSoChuaDenHan
                                              ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text('H??? s?? qu?? h???n',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.hoSoQuaHan
                                              ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ch??? ti???p nh???n',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.choTiepNhan
                                              ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text('H??? s?? ch??? b??? sung',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.choBoSung
                                              ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ch??? tr??? k???t qu???',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString(profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.choTraKetQua
                                              ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text('H??? s?? ???? b??? sung',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.daBoSung
                                              ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text('H??? s?? ??ang x??? l??',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.dangXuLy
                                                  ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text('H??? s?? ???? x??? l??',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.daXuLy
                                                    ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ch??? gi???i quy???t',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.choGiaiQuyet
                                                   ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ??ang tr??nh k??',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.dangTrinhKy
                                                   ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ??ang ???????c ph??n c??ng',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.dangPhanCong
                                                   ),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'H??? s?? ch??? ph??n c??ng th??? l??',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatisticTotal.value.choPhanCongThuLy),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                                ]),
                              ),
                              context),
                        )
                      ],
                    ),
                    //button switch chart
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Row(
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
                                  child: const Text("M???c ?????"),
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
                                      child: const Text("Tr???ng th??i"),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                    Obx(() =>ProfileProcChart(profilesProcedureViewModel.selectedBottomButton.value,profilesProcedureViewModel)),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => ProfilesProcedureListWithStatistic(
                              ));
                            },
                            child: buttonShowListScreen(
                                "Xem danh s??ch th??? t???c h??nh ch??nh"),
                            style: bottomButtonStyle,
                          ),
                        ),
                      ),
                    )
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
Widget ProfileProcChart(int selectedButtonIndex,ProfilesProcedureViewModel profilesProcedureViewModel)
{
  var res;
  if(profilesProcedureViewModel
      .rxDocumentFilterModel.value.totalRecords != null) {
    if (selectedButtonIndex ==
        0) {
      res =  CollumChartWidget(
          key: UniqueKey(),
          documentFilterModel: profilesProcedureViewModel
              .rxDocumentFilterModel.value);
    }
    else if (selectedButtonIndex == 1) {
      res = CollumChartWidget(
        key: UniqueKey(),
        documentFilterModel: profilesProcedureViewModel
            .rxDocumentFilterModel.value,
      );
    }
    return res;
  }
  else {
    return SizedBox(height: 200,);
  }
}

List<String> listTitle = [
  "H??? s?? ti???p nh???n tr???c tuy???n",
  "H??? s?? ti???p nh???n tr???c ti???p",
  "H??? s?? ????ng h???n",
  "H??? s?? s???m h???n",
  "H??? s?? ch??a ?????n h???n",
  "H??? s?? qu?? h???n",
  "H??? s?? ch??? ti???p nh???n",
  "H??? s?? ch??? b??? sung",
  "H??? s?? ch??? tr??? k???t qu???",
  "H??? s?? ???? b??? sung",
  "H??? s?? ??ang x??? l??",
  "H??? s?? ???? x??? l??",
  "H??? s?? ch??? gi???i quy???t",
  "H??? s?? ??ang tr??nh k??",
  "H??? s?? ??ang ???????c ph??n c??ng",
  "H??? s?? ch??? ph??n c??ng th??? l??",
];
