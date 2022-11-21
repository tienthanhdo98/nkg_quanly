import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/report/report_detail.dart';
import 'package:nkg_quanly/ui/report/report_in_menuhome/report_in_menuhome_list.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/report_model/report_model.dart';
import '../document_out/search_controller.dart';
import '../theme/theme_data.dart';

class ReportSearch extends GetView {
  final String? header;
  final searchController = Get.put(SearchController());

  ReportSearch({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                      bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).dividerColor,
                  ))),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/icons/ic_arrow_back.png',
                        width: 18,
                        height: 18,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kgray,
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Icon(Icons.search)),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập mã báo cáo, tên báo cáo',
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  onSubmitted: (value) {
                                    searchController.searchDataReport(value);
                                  },
                                  onChanged: (value) {
                                    //print(value);
                                    // searchController.searchData(value);
                                  },
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: SizedBox(
                    height: 200,
                    child: Obx(() => ListView.builder(
                        controller: searchController.controller,
                        itemCount: searchController.listDataReport.length,
                        itemBuilder: (context, index) {
                          var item = searchController.listDataReport[index];
                          return InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse(
                                    "http://123.31.31.237:6002/api/reportapiclient/download-report?id=1"));
                              },
                              child: ReportItemInMenu(index, item));
                        })),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
Widget listReportResultWidget(SearchController searchController, List list) {
  return ListView.builder(
      controller: searchController.controller,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var item = list[index];
        return InkWell(
            onTap: () async {
              await launchUrl(Uri.parse(
                  "http://123.31.31.237:6002/api/reportapiclient/download-report?id=1"));
            },
            child: ReportItemInMenu(index, item));
      });
}
