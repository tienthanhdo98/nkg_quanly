import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/widget.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';

import '../../../const/const.dart';
import 'help_desk_list.dart';
import 'helpdesk_viewmodel.dart';


class HelpdeskSearch  extends GetView {

  final searchController = Get.put(SearchController());

  HelpdeskSearch(this.helpdeskViewModel ,{Key? key})
      : super(key: key);
    final HelpdeskViewModel helpdeskViewModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        searchController.rxHelpdeskListItems.clear();
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
                          searchController.rxHelpdeskListItems.clear();
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
                                      hintText: 'Nhập tiêu đề câu hỏi',
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    onSubmitted: (value) {
                                      searchController.searchHelpdesk(value);
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
                      child: Obx(() => searchResultHelpDeskWidget(searchController,helpdeskViewModel)),
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

Widget searchResultHelpDeskWidget(
    SearchController searchController,HelpdeskViewModel helpdeskViewModel) {
  if (searchController.isHaveData.value == true) {
    if (searchController.isLoading.value == false) {
      if (searchController.rxHelpdeskListItems.isNotEmpty) {
        return ListView.builder(
            controller: searchController.controller,
            itemCount: searchController.rxHelpdeskListItems.length,
            itemBuilder: (context, index) {
              var item = searchController.rxHelpdeskListItems[index];
              return  InkWell(
                  onTap: () {
                    // Get.to(() => DocumentnonapprovedDetail(
                    //     id: helpdeskViewModel
                    //         .rxHelpdeskListItems[index].id!));
                  },
                  child: HelpDeskListItem(
                      index,item, helpdeskViewModel));
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



