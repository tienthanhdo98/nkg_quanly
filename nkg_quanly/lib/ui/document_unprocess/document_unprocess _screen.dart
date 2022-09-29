import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../const/api.dart';
import '../../const/widget.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../char3/collum_chart_doc_nonprocess.dart';
import '../document_nonapproved/document_nonapproved_viewmodel.dart';
import '../theme/theme_data.dart';
import 'document_unprocess_list.dart';
import 'document_unprocess_viewmodel.dart';

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
          headerWidget(header!, context),
          Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/bgtophome.png",
                    height: 150, width: double.infinity, fit: BoxFit.cover),
              Obx(() =>Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                  documentUnprocessViewModel.rxDocumentInStatistic.value.tong.toString(),
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
              ) )
              ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:listButtonChart.length ,
                  itemBuilder: (context,index){
                    return  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Obx(() => ElevatedButton(
                        style: documentUnprocessViewModel.selectedChartButton.value == index
                            ? activeButtonStyle
                            : unActiveButtonStyle,
                        onPressed: () async {
                          await documentUnprocessViewModel
                              .getFilterForChart("$apiGetDocumentUnprocessFilterChart$index");
                          documentUnprocessViewModel.selectedChartButton(index);

                        },
                        child:  Text(listButtonChart[index]),
                      )),
                    );

                  }),
            ),
          ),
          Obx(() => (documentUnprocessViewModel.rxDocumentFilterModel.value.totalRecords != null) ? chartItemForDocUnprocess(documentUnprocessViewModel.selectedChartButton.value,documentUnprocessViewModel.rxDocumentFilterModel.value) : const SizedBox.shrink()),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => DocumentUnprocessList(
                          header: header));
                    },
                    child: buttonShowListScreen("Danh sách văn bản đến chưa xử lý"),
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
Widget chartItemForDocUnprocess(int index,DocumentFilterModel value){
  if(index == 0)
    {
      return CollumChartWidget(
        key: UniqueKey(),
          documentFilterModel:
         value);
    }
  if(index == 1)
    {
      return   CollumChartWidget(
        key: UniqueKey(),
          documentFilterModel:
          value);
    }
  if(index == 2)
  {
    return  CollumChartWidget(
        key: UniqueKey(),
        documentFilterModel:
        value);
  }
else
  {
    return  CollumChartWidget(
        key: UniqueKey(),
        documentFilterModel:
        value);
  }


}
List listButtonChart = ["ĐV phát hành","Mức độ","Ngày đến","Hạn xử lý"];
