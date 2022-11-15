import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/profile/profile_viewmodel.dart';

import '../../const/api.dart';
import '../../const/const.dart';
import '../../const/widget.dart';
import '../char3/collum_chart_doc_nonprocess.dart';
import '../theme/theme_data.dart';
import 'e_office/profile_e_office_list.dart';

class ProfileScreen extends GetView {
  String? header;
  String? icon;

  final profileViewModel = Get.put(ProfileViewModel());

  ProfileScreen({Key? key, this.header, this.icon}) : super(key: key);

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
                                        const Text('Tổng văn bản'),
                                        Text(
                                        checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.hoSoTrinh),
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
                                            const Text("Tạo mới"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.taoMoi)
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
                                            const Text("Chờ duyệt"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.choDuyet)
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
                                            const Text("Ý kiến đơn vị"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.yKienDonVi)
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
                                            const Text("Đã thu hồi"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.daThuHoi)
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
                                            const Text("Đã duyệt"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.daDuyet)
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
                                            const Text("Chờ tiếp nhận"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.choTiepNhan)
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
                                            const Text("HT quá hạn"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.daTiepNhan)
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
                                            const Text("Đã tiếp nhận"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.daThuHoi)
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
                                            const Text("Hồ sơ trình chờ phát hành"),
                                            Text(
                                                checkingNullNumberAndConvertToString(profileViewModel.rxProfileStatisticTotal.value.hoSoTrinhChoPhatHanh)
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))
                                          ],
                                        ),

                                      ]),
                                )
                              ]),
                            ),
                            context),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Obx(() => ElevatedButton(
                                style:
                                profileViewModel.selectedChartButton.value ==
                                    0
                                    ? activeButtonStyle
                                    : unActiveButtonStyle,
                                onPressed: () async {
                                  await profileViewModel.getFilterForChart(
                                      "${apiGetProfileFilter}0");
                                  profileViewModel.selectedChartButton(0);
                                },
                                child: const Text("Mức độ"),
                              )),
                            )),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Obx(
                                      () => ElevatedButton(
                                    style: profileViewModel
                                        .selectedChartButton.value ==
                                        1
                                        ? activeButtonStyle
                                        : unActiveButtonStyle,
                                    onPressed: () async {
                                      await profileViewModel.getFilterForChart(
                                          "${apiGetProfileFilter}1");
                                      profileViewModel.selectedChartButton(1);
                                    },
                                    child: const Text("Trạng thái"),
                                  ),
                                )))
                      ],
                    ),
                  ),
                  Obx(
                        () => chartItemForProfile(
                        profileViewModel.selectedChartButton.value,
                        profileViewModel),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ProfileEOfficeList(
                            ));
                          },
                          child:
                          buttonShowListScreen("Xem danh sách hồ sơ trình"),
                          style: bottomButtonStyle,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ],
        )
      ),
    );
  }
}

Widget chartItemForProfile(int index, ProfileViewModel profileViewModel) {
  if (profileViewModel.rxDocumentFilterModel.value.items?.isNotEmpty == true) {
    return Obx(() => CollumChartWidget(
        key: UniqueKey(),
        documentFilterModel: profileViewModel.rxDocumentFilterModel.value));
  }else{
    return const SizedBox.shrink();
  }
}
