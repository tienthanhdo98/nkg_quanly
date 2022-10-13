import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/char3/collum_chart_doc_nonprocess.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_list.dart';
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
                                          const Text('Tổng hồ sơ',
                                              style: CustomTextStyle
                                                  .robotow400s12TextStyle),
                                         Obx(() => Text(
                                           checkingNullNumberAndConvertToString(profilesProcedureViewModel.rxProfileProcedureStatistic.value.tongSoHoSo),
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
                                                  'Hồ sơ tiếp nhận trực tuyến',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value
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
                                                  'Hồ sơ tiếp nhận trực tiếp',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
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
                                              child: Text('Hồ sơ đúng hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.hoSoDungHan
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
                                              child: Text('Hồ sơ sớm hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.hoSoSomHan
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
                                                  'Hồ sơ chưa đến hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.hoSoChuaDenHan
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
                                              child: Text('Hồ sơ quá hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value.hoSoQuaHan
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
                                                  'Hồ sơ chờ tiếp nhận',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.choTiepNhan
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
                                              child: Text('Hồ sơ chờ bổ sung',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.choBoSung
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
                                                  'Hồ sơ chờ trả kết quả',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString(profilesProcedureViewModel.rxProfileProcedureStatistic.value.choTraKetQua
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
                                              child: Text('Hồ sơ đã bổ sung',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.daBoSung
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
                                              child: Text('Hồ sơ đang xử lý',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value.dangXuLy
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
                                              child: Text('Hồ sơ đã xử lý',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value.daXuLy
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
                                                  'Hồ sơ chờ giải quyết',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.choGiaiQuyet
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
                                                  'Hồ sơ đang trình ký',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.dangTrinhKy
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
                                                  'Hồ sơ đang được phân công',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString( profilesProcedureViewModel.rxProfileProcedureStatistic.value.dangPhanCong
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
                                                  'Hồ sơ chờ phân công thụ lý',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value.choPhanCongThuLy),
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
                                "Xem danh sách thủ tục hành chính"),
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
  "Hồ sơ tiếp nhận trực tuyến",
  "Hồ sơ tiếp nhận trực tiếp",
  "Hồ sơ đúng hạn",
  "Hồ sơ sớm hạn",
  "Hồ sơ chưa đến hạn",
  "Hồ sơ quá hạn",
  "Hồ sơ chờ tiếp nhận",
  "Hồ sơ chờ bổ sung",
  "Hồ sơ chờ trả kết quả",
  "Hồ sơ đã bổ sung",
  "Hồ sơ đang xử lý",
  "Hồ sơ đã xử lý",
  "Hồ sơ chờ giải quyết",
  "Hồ sơ đang trình ký",
  "Hồ sơ đang được phân công",
  "Hồ sơ chờ phân công thụ lý",
];
