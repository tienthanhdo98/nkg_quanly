import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../const/const.dart';
import 'guideline_viewmodel.dart';
import 'guildline_list.dart';



class GuidelineSearch  extends GetView {

  final searchController = Get.put(SearchController());

  GuidelineSearch(this.guildelineViewModel,{Key? key})
      : super(key: key);
    final GuildlineViewModel guildelineViewModel;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        searchController.rxListGuideline.clear();
        return true;
      },
      child: Scaffold(
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
                          searchController.rxWorkBookListItems.clear();
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
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child:  Image.asset(
                                      'assets/icons/ic_search.png',
                                      width: 20,
                                      height: 20,
                                    )),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập tiêu đề tài liệu',
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    onSubmitted: (value) {
                                      searchController.searchGuideLine(value);
                                    },
                                    // onChanged: (value) {
                                    //    searchController.searchData(value);
                                    // },
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
                          itemCount: searchController.rxListGuideline.length,
                          itemBuilder: (context, index) {
                            var item =  searchController.rxListGuideline[index];
                            return InkWell(
                              onTap: ()async {
                                var urlFile = "http://123.31.31.237:6002/api/guidelines/download-file/${item.id}";
                                print(urlFile);
                                if(await canLaunchUrl(Uri.parse(urlFile))) {
                                  launchUrl(
                                    Uri.parse(urlFile),
                                    webViewConfiguration: const WebViewConfiguration(
                                        enableJavaScript: true,
                                        enableDomStorage: true
                                    ),
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              child: GuideItem(
                                  index,
                                  item,
                                  guildelineViewModel),
                            );
                          })),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


