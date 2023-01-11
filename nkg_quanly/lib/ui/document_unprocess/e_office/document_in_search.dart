import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/widget.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';

import '../../../const/const.dart';
import '../../../const/utils.dart';
import 'document_in_e_office_list.dart';



class DocumentInSearch extends GetView {

  final searchController = Get.put(SearchController());

  DocumentInSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        searchController.listData.clear();
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
                          searchController.listData.clear();
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
                                      hintText: 'Nhập mã văn bản, tên văn bản',
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    onSubmitted: (value) {
                                      searchController.searchData(value);
                                      searchController.changeLoadingState(true);
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
                      child:
                          Obx(() => (searchController.isLoading.value == false)
                              ? ListView.builder(
                            controller: searchController.controller,
                                  itemCount: searchController.listData.length,
                                  itemBuilder: (context, index) {
                              var item = searchController.listData[index];
                                    return  InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return DetailDocInBottomSheet(
                                                  index,
                                                  item);
                                            },
                                          );
                                        },
                                        child: DocumentNonProcessListItem(index,
                                            item));
                                  })
                              : loadingIcon()),
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

Widget listDocInSearchResultWidget(SearchController searchController, List list) {
  return  ListView.builder(
      controller: searchController.controller,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var item = list[index];
        return  InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                context: context,
                builder: (BuildContext context) {
                  return DetailDocInBottomSheet(
                      index,
                      item);
                },
              );
            },
            child: DocumentNonProcessListItem(index,
                item));
      });
}
