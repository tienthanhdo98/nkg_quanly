import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../../const/api.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../char3/collum_chart_doc_nonprocess.dart';
import '../theme/theme_data.dart';
import 'document_unprocess_viewmodel.dart';
import 'e_office/document_in_e_office_list.dart';

class DocumentUnProcessScreen extends GetView {
  final String? header;
  final String? icon;

  final documentUnprocessViewModel = Get.put(DocumentUnprocessViewModel());

  DocumentUnProcessScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          Stack(
            children: [
              Image.asset("assets/bgtophome.png",
                  height: 220, width: double.infinity, fit: BoxFit.cover),
              headerWidget(header!, context),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                child: border(
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Obx(() =>  Column(children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text('Tổng văn bản',
                                    style: CustomTextStyle
                                        .robotow400s12TextStyle),
                                Text(checkingNullNumberAndConvertToString(documentUnprocessViewModel
                                    .rxDocumentInStatisticTotal.value.tong),
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
                                  const Text('VB chưa xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(checkingNullNumberAndConvertToString(documentUnprocessViewModel.rxDocumentInStatisticTotal.value.chuaXuLy),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('VB đang xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    checkingNullNumberAndConvertToString(documentUnprocessViewModel.rxDocumentInStatisticTotal.value.dangXuLy
                                    ),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text('VB đã xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    checkingNullNumberAndConvertToString(documentUnprocessViewModel.rxDocumentInStatisticTotal.value.dangXuLy),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ])),
                    ),
                    context),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listButtonChart.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Obx(() => ElevatedButton(
                            style: documentUnprocessViewModel
                                        .selectedChartButton.value ==
                                    index
                                ? activeButtonStyle
                                : unActiveButtonStyle,
                            onPressed: () async {
                              await documentUnprocessViewModel.getFilterForChart(
                                  "$apiGetDocumentUnprocessFilterChart$index");
                              documentUnprocessViewModel
                                  .selectedChartButton(index);
                            },
                            child: Text(listButtonChart[index]),
                          )),
                    );
                  }),
            ),
          ),
          Obx(() => (documentUnprocessViewModel
                      .rxDocumentFilterModel.value.totalRecords !=
                  null)
              ? chartItemForDocUnprocess(
                  documentUnprocessViewModel.selectedChartButton.value,
                  documentUnprocessViewModel.rxDocumentFilterModel.value)
              : const SizedBox.shrink()),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => DocumentInEOfficeList(header: header));
                    },
                    child: buttonShowListScreen(
                        "Danh sách văn bản đến chưa xử lý"),
                    style: bottomButtonStyle,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

Widget chartItemForDocUnprocess(int index, DocumentFilterModel value) {
  if (index == 0) {
    return CollumChartWidget(key: UniqueKey(), documentFilterModel: value);
  }
  if (index == 1) {
    return CollumChartWidget(key: UniqueKey(), documentFilterModel: value);
  }
  if (index == 2) {
    return CollumChartWidget(key: UniqueKey(), documentFilterModel: value);
  } else {
    return CollumChartWidget(key: UniqueKey(), documentFilterModel: value);
  }
}

List listButtonChart = ["ĐV phát hành", "Mức độ", "Ngày đến", "Hạn xử lý"];
