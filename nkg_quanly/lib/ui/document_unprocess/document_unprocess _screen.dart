import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/chart2/collum_red_chart.dart';
import 'package:nkg_quanly/viewmodel/home_viewmodel.dart';

import '../../const.dart';
import '../../const/api.dart';
import '../../model/document/document_statistic_model.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../chart2/pie_chart.dart';
import '../document_nonapproved/document_nonapproved_list.dart';
import '../theme/theme_data.dart';
import 'document_unprocess_chart.dart';

class DocumentUnProcessScreen extends GetView {
  final String? header;
  final String? icon;

  final homeController = Get.put(HomeViewModel());

  DocumentUnProcessScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: homeController.getQuantityDocumentBuUrl(apitGetUnProcess0),
          builder:
              (context, AsyncSnapshot<List<DocumentFilterModel>> snapshot) {
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
                                      const Text('Tổng văn bản chưa xử lý'),
                                      Text(
                                        snapshot.data![0].quantity.toString(),
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
                            ]),
                          ),
                          context),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: DocumentUnChart(
                      homeViewModel: homeController,
                      listBaseChart: snapshot.data,
                    )),
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
                                header: header, isNonapproved: false));
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
