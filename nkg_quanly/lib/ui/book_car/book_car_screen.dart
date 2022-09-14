import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/viewmodel/home_viewmodel.dart';

import '../../const.dart';
import '../../model/document/document_statistic_model.dart';
import '../chart2/pie_chart.dart';
import '../theme/theme_data.dart';
import 'book_car_list.dart';


class BookCarScreen extends GetView {
  String? header;
  String? icon;

  final homeController = Get.put(HomeViewModel());

  BookCarScreen({Key? key, this.header, this.icon}) : super(key: key);

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
                                      const Text('Tổng số phòng họp'),
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
                                      const Text('Còn trống'),
                                      Text(
                                          snapshot.data!.chuaButPhe!.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))
                                    ],
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Đã đặt'),
                                      Text(
                                        snapshot.data!.daButPhe.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ]),
                          ),
                          context),
                    )
                  ],
                ),
                 Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: PieChart2()),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => BookCarList(
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
