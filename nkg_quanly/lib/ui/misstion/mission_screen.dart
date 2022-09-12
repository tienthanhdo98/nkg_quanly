import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/documentin/document_in_list.dart';
import 'package:nkg_quanly/viewmodel/home_viewmodel.dart';

import '../../const.dart';
import '../../model/document/document_statistic_model.dart';
import '../chart/sline_chart2.dart';
import '../chart2/collum_red_chart.dart';
import '../chart2/pie_chart.dart';
import '../chart2/sline_chart.dart';
import '../theme/theme_data.dart';


class MissionScreen extends GetView {
  String? header;
  String? icon;

  final homeController = Get.put(HomeViewModel());

  MissionScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: homeController.getDocumentStatistic(),
          builder: (context, AsyncSnapshot<DocumentStatisticModel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                  children: [
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
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Quá hạn'),
                                      Text(
                                          '300',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))
                                    ],
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 0, 0, 0)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('HT quá hạn'),
                                      Text(
                                        '204',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(5, 0, 0, 0)),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text('Hoàn thành'),
                                      Text(
                                        '400',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(5, 0, 0, 0)),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text('Chưa HT'),
                                      Text(
                                       '700',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),


                                ],
                              )
                            ]),
                          ),
                          context),
                    )
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SLineChartRed()),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => DocumentInList(
                                  header: header,
                                ));
                          },
                          child: const Text('Xem danh sách VB đến chưa bút phê'),
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
