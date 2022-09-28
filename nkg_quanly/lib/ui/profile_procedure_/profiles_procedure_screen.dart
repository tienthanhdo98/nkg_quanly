import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/ui/char3/collum_chart_doc_nonprocess.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_list.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';

import '../../const.dart';
import '../../const/widget.dart';
import '../../model/profile_procedure_model/ProfileProcStatisticModel.dart';
import '../theme/theme_data.dart';

class ProfilesProcedureScreen extends GetView {
  String? header;
  String? icon;

  final profilesProcedureController = Get.put(ProfilesProcedureViewModel());

  ProfilesProcedureScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: profilesProcedureController.geProfileProcStatistic(),
          builder: (context,
              AsyncSnapshot<ProfileProcedureStatisticModel> snapshot) {
            if (snapshot.hasData) {
              var itemStatistic = snapshot.data;
              return Column(children: [
                headerWidget(header!, context),
                Expanded(child:  SingleChildScrollView(
                  child: Column(children: [
                    Stack(
                      children: [
                        Image.asset("assets/bgtophome.png",
                            height: 220, width: double.infinity, fit: BoxFit.cover),

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
                                          Text(
                                            itemStatistic!.tongSoHoSo.toString(),
                                            style: const TextStyle(
                                                color: kBlueButton,
                                                fontSize: 40,
                                                fontFamily: 'Roboto'),
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
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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
                                            const SizedBox(
                                              height: 30,
                                              child: Text(
                                                  'Hồ sơ tiếp nhận trực tuyến',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                snapshot.data!.hoSoTiepNhanTrucTuyen
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                snapshot.data!.hoSoTiepNhanTrucTiep
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                  'Hồ sơ đúng hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                snapshot.data!.hoSoDungHan
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                  'Hồ sơ sớm hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                snapshot.data!.hoSoSomHan
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                snapshot.data!.hoSoChuaDenHan
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                  'Hồ sơ quá hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                snapshot.data!.hoSoQuaHan
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                snapshot.data!.choTiepNhan
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                  'Hồ sơ chờ bổ sung',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                snapshot.data!.choBoSung
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                snapshot.data!.choTraKetQua
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                  'Hồ sơ đã bổ sung',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                snapshot.data!.daBoSung
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                  'Hồ sơ đang xử lý',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                snapshot.data!.dangXuLy
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                  'Hồ sơ đã xử lý',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                            ),
                                            Text(
                                                snapshot.data!.daXuLy
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                snapshot.data!.choGiaiQuyet
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                snapshot.data!.dangTrinhKy
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                snapshot.data!.dangPhanCong
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                snapshot.data!.choPhanCongThuLy
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
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
                                  style: profilesProcedureController
                                      .selectedChartButton.value ==
                                      0
                                      ? activeButtonStyle
                                      : unActiveButtonStyle,
                                  onPressed: () async {
                                    await profilesProcedureController
                                        .getFilterForChart(
                                        apiGetProfileProcedureChart0);
                                    profilesProcedureController
                                        .selectedChartButton(0);
                                  },
                                  child: const Text("Mức độ"),
                                )),
                              )),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: Obx(
                                        () => ElevatedButton(
                                      style: profilesProcedureController
                                          .selectedChartButton.value ==
                                          1
                                          ? activeButtonStyle
                                          : unActiveButtonStyle,
                                      onPressed: () async {
                                        await profilesProcedureController
                                            .getFilterForChart(
                                            apiGetProfileProcedureChart1);
                                        profilesProcedureController
                                            .swtichChartButton(1);
                                      },
                                      child: const Text("Trạng thái"),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                    Obx(() =>
                    (profilesProcedureController.selectedChartButton.value == 0)
                        ? Obx(() => CollumChartWidget(
                        key: UniqueKey(),
                        documentFilterModel: profilesProcedureController
                            .rxDocumentFilterModel.value))
                        : Obx(() => CollumChartWidget(
                      key: UniqueKey(),
                      documentFilterModel: profilesProcedureController
                          .rxDocumentFilterModel.value,
                    ))),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => ProfilesProcedureList(
                                header: header,
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
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
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
