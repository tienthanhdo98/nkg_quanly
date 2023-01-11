import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/api.dart';
import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../document_nonapproved/document_nonapproved_list.dart';
import '../document_nonapproved/document_nonapproved_screen.dart';
import '../document_nonapproved/document_nonapproved_viewmodel.dart';
import '../document_unprocess/e_office/document_in_e_office_list.dart';
import '../theme/theme_data.dart';

class DocumentNonapprovedWidget extends GetView {
  final documentNonApproveViewModel = Get.put(DocumentNonApproveViewModel());

  DocumentNonapprovedWidget();

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
                                  "Văn bản đến chưa bút phê",
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
                                            DocumentInEOfficeList()));
                              },
                              child: const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.more_horiz)),
                            )
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 0)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tổng văn bản',
                                style: CustomTextStyle.robotow400s12TextStyle),
                            Text(
                              checkingNullNumberAndConvertToString(
                                  documentNonApproveViewModel
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
            Row(
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
            Obx(
                  () => chartItemForDocApprove(
                  documentNonApproveViewModel.selectedChartButton.value,
                  documentNonApproveViewModel),
            ),
          ]),
          context),
    );
  }
}
