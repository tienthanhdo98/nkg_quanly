import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';
import 'package:nkg_quanly/ui/workbook/workbook_detail.dart';
import 'package:nkg_quanly/ui/workbook/workbook_list.dart';
import 'package:nkg_quanly/ui/workbook/workbook_viewmodel.dart';

import '../../../const/const.dart';
import '../../const/widget.dart';



class WorkbookSearch  extends GetView {

  final searchController = Get.put(SearchController());

  WorkbookSearch(this.workBookViewModel,{Key? key})
      : super(key: key);
    final WorkBookViewModel workBookViewModel;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        searchController.rxWorkBookListItems.clear();
        searchController.isHaveData.value = false;
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
                          searchController.isHaveData.value = false;
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
                                      hintText: 'Nhập tên công việc',
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    onSubmitted: (value) {
                                      searchController.searchWorkbook(value);
                                      searchController.changeLoadingState(true);
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
                      child: Obx(() => searchResultWorkBookWidget(searchController,searchController.rxWorkBookListItems,workBookViewModel)),
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

Widget searchResultWorkBookWidget(
    SearchController searchController, List list,WorkBookViewModel workBookViewModel) {
  if (searchController.isHaveData.value == true) {
    if (searchController.isLoading.value == false) {
      if (list.isNotEmpty) {
        return ListView.builder(
            controller: searchController.controller,
            itemCount: searchController.rxWorkBookListItems.length,
            itemBuilder: (context, index) {
              var item = searchController.rxWorkBookListItems[index];
              return InkWell(
                onTap: () {
                  Get.to(() => WorkBookDetail(
                    id: item.id!,
                  ));
                },
                child: WorkBookItem(
                    index,
                    item,
                    workBookViewModel),
              );
            });
      } else {
        return noData();
      }
    } else {
      return loadingIcon();
    }
  } else {
    return const SizedBox();
  }
}


