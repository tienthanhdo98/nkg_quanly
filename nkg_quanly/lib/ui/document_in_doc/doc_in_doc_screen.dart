import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/document_nonapproved/document_nonapproved_list.dart';
import 'package:nkg_quanly/viewmodel/home_viewmodel.dart';

import '../../const.dart';
import '../../model/document/document_statistic_model.dart';
import '../chart/column_chart2.dart';
import '../theme/theme_data.dart';

class DocInDocScreen extends GetView {
  String? header;
  String? icon;

  final homeController = Get.put(HomeViewModel());

  DocInDocScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: homeController.getDocumentStatistic(),
          builder: (context, AsyncSnapshot<DocumentStatisticModel> snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                Stack(
                  children: [
                    Image.asset("assets/bgtophome.png",
                        height: 220, width: double.infinity, fit: BoxFit.cover),
                    headerWidget(header!, context),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
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
                                        snapshot.data!.tong.toString(),
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
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              SizedBox(
                                height: 120,
                                child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 0,
                                  crossAxisCount: 4,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Tạo mới'),
                                        Text('300',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text('Đã thu hồi'),
                                        Text('300',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text('Đang xử lý'),
                                        Text('300',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text('Đã hoàn thành'),
                                        Text('300',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                    //
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text('Tạo mới'),
                                        Text('300',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text('Đã thu hồi'),
                                        Text('300',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text('Đang xử lý'),
                                        Text('300',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text('Đã hoàn thành'),
                                        Text('300',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          context),
                    )
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ColumnChart2()),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => DocumentNonapprovedList(
                                  header: header,
                                ));
                          },
                          child: Text('Xem danh sách $header'),
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
