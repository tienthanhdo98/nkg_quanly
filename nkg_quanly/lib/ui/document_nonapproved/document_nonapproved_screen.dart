import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/api.dart';
import '../../const/const.dart';
import '../../const/widget.dart';
import '../char3/collum_chart_doc_nonprocess.dart';
import '../char3/pie_chart.dart';
import '../document_unprocess/e_office/document_in_e_office_list.dart';
import '../theme/theme_data.dart';
import 'document_nonapproved_list.dart';
import 'document_nonapproved_viewmodel.dart';

class DocumentNonApprovedScreen extends GetView {
  final String? header;
  final String? icon;

  final documentNonApproveViewModel = Get.put(DocumentNonApproveViewModel());

  DocumentNonApprovedScreen({Key? key, this.header, this.icon})
      : super(key: key);
//CircularProgressIndicator
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(() => (documentNonApproveViewModel.rxDocumentInStatisticTotal.value.tong != null) ?
        Column(children: [
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
                      child: Obx(() => Column(children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text('Tổng văn bản'),
                                Text(
                                  checkingNullNumberAndConvertToString(documentNonApproveViewModel.rxDocumentInStatisticTotal.value.tong),
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
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text('Chưa bút phê'),
                                Text(
                                  checkingNullNumberAndConvertToString(documentNonApproveViewModel.rxDocumentInStatisticTotal.value.chuaButPhe),
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
                                const Text('Đã bút phê'),
                                Text(
                                  checkingNullNumberAndConvertToString(documentNonApproveViewModel.rxDocumentInStatisticTotal.value.daButPhe),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            )
                          ],
                        )
                      ])),
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
                        style: documentNonApproveViewModel
                            .selectedChartButton.value ==
                            0
                            ? activeButtonStyle
                            : unActiveButtonStyle,
                        onPressed: () async {
                          await documentNonApproveViewModel
                              .getFilterForChart(
                              "${apiGetDocumentApproveFilterChart}0");
                          documentNonApproveViewModel
                              .selectedChartButton(0);
                        },
                        child: const Text("Trạng thái"),
                      )),
                    )),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Obx(
                              () => ElevatedButton(
                            style: documentNonApproveViewModel
                                .selectedChartButton.value ==
                                1
                                ? activeButtonStyle
                                : unActiveButtonStyle,
                            onPressed: () async {
                              await documentNonApproveViewModel
                                  .getFilterForChart(
                                  "${apiGetDocumentApproveFilterChart}1");
                              documentNonApproveViewModel
                                  .selectedChartButton(1);
                            },
                            child: const Text("Ngày đến"),
                          ),
                        )))
              ],
            ),
          ),
          Obx(
                () => chartItemForDocApprove(
                documentNonApproveViewModel.selectedChartButton.value,
                documentNonApproveViewModel),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => DocumentInEOfficeList(
                        header: header,
                      ));
                    },
                    child: buttonShowListScreen(
                        "Xem danh sách VB đến chưa bút phê"),
                    style: bottomButtonStyle,
                  ),
                ),
              ),
            ),
          )
        ]) : const SizedBox()),
      ),
    );
  }
}

Widget chartItemForDocApprove(
    int index, DocumentNonApproveViewModel documentNonApproveViewModel) {
  if (index == 0) {
    return Obx(() => PieChartWidget(
        key: UniqueKey(),
        documentFilterModel:
            documentNonApproveViewModel.rxDocumentFilterModel.value));
  } else {
    return Obx(() => CollumChartWidget(
        key: UniqueKey(),
        documentFilterModel:
            documentNonApproveViewModel.rxDocumentFilterModel.value));
  }
}
