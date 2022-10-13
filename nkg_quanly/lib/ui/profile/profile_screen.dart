import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/profile/profile_list.dart';
import 'package:nkg_quanly/ui/profile/profile_viewmodel.dart';

import '../../const/const.dart';
import '../../const/api.dart';
import '../../const/widget.dart';
import '../../model/document_unprocess/document_filter.dart';
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
        child: FutureBuilder(
          future: profileViewModel
              .getQuantityDocumentBuUrl("${apiGetProfileFilter}1"),
          builder: (context, AsyncSnapshot<DocumentFilterModel> snapshot) {
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
                                        snapshot.data!.totalRecords.toString(),
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
                                height: 50,
                                child: GridView.count(
                                    crossAxisCount: 4,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("HT"),
                                          Text(
                                              snapshot.data!.items![0].quantity
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
                                          const Text("Chưa HT"),
                                          Text(
                                              snapshot.data!.items![1].quantity
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
                                          const Text("Quá hạn"),
                                          Text(
                                              snapshot.data!.items![2].quantity
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
                                              snapshot.data!.items![3].quantity
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20))
                                        ],
                                      )
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ProfileEOfficeList(
                                  header: header,
                                ));
                          },
                          child:
                              buttonShowListScreen("Xem danh sách hồ sơ trình"),
                          style: bottomButtonStyle,
                        ),
                      ),
                    ),
                  ),
                )
              ]);
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

Widget chartItemForProfile(int index, ProfileViewModel profileViewModel) {
  if (index == 0) {
    return Obx(() => CollumChartWidget(
        key: UniqueKey(),
        documentFilterModel: profileViewModel.rxDocumentFilterModel.value));
  } else {
    return Obx(() => CollumChartWidget(
        key: UniqueKey(),
        documentFilterModel: profileViewModel.rxDocumentFilterModel.value));
  }
}
