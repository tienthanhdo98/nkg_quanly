import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/api.dart';
import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../document_unprocess/document_unprocess _screen.dart';
import '../document_unprocess/document_unprocess_viewmodel.dart';
import '../document_unprocess/e_office/document_in_e_office_list.dart';
import '../theme/theme_data.dart';

class DocumentUnProcessWidget extends GetView {
  final documentUnprocessViewModel = Get.put(DocumentUnprocessViewModel());

  DocumentUnProcessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(
          Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Văn bản đến chưa xử lý",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DocumentInEOfficeList(header: "Văn bản đến chưa xử lý",)));
                              },
                              child: const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.more_horiz)),
                            )
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tổng văn bản',
                                style: CustomTextStyle.robotow400s12TextStyle),
                            Text(
                              checkingNullNumberAndConvertToString(
                                  documentUnprocessViewModel
                                      .rxDocumentInStatisticTotal.value.tong),
                              style: const TextStyle(
                                  color: kBlueButton, fontSize: 40),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ])),
            ),
            SizedBox(
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
            Obx(() => (documentUnprocessViewModel
                        .rxDocumentFilterModel.value.totalRecords !=
                    null)
                ? chartItemForDocUnprocess(
                    documentUnprocessViewModel.selectedChartButton.value,
                    documentUnprocessViewModel.rxDocumentFilterModel.value)
                : const SizedBox.shrink()),
          ]),
          context),
    );
  }
}
