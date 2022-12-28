import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';
import 'package:nkg_quanly/ui/utility/group_workbook/workbook_detail.dart';

import '../../../const/const.dart';
import '../../../const/widget.dart';
import '../../../model/MenuByUserModel.dart';
import 'group_workbook_list.dart';
import 'group_workbook_viewmodel.dart';



class GroupWorkbookSearch  extends GetView {

  final searchController = Get.put(SearchController());
  List<MenuPermissions>? listMenuPermissions;
  GroupWorkbookSearch(this.groupWorkBookViewModel ,this.listMenuPermissions,{Key? key})
      : super(key: key);
    final GroupWorkBookViewModel groupWorkBookViewModel;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        searchController.rxListGroupWorkBookItems.clear();
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
                          searchController.rxListGroupWorkBookItems.clear();
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
                                      hintText: 'Nhập tên nhóm công việc',
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                    onSubmitted: (value) {
                                      searchController.searchGroupWorkbook(value);
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
                      child: Obx(() => searchResultGroupWorkBooktWidget(searchController,groupWorkBookViewModel,listMenuPermissions)),
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
Widget searchResultGroupWorkBooktWidget(
    SearchController searchController,GroupWorkBookViewModel groupWorkBookViewModel, List<MenuPermissions>? listMenuPermissions) {
  if (searchController.isHaveData.value == true) {
    if (searchController.isLoading.value == false) {
      if (searchController.rxListGroupWorkBookItems.isNotEmpty) {
        return ListView.builder(
            controller: searchController.controller,
            itemCount: searchController.rxListGroupWorkBookItems.length,
            itemBuilder: (context, index) {
              var item = searchController.rxListGroupWorkBookItems[index];
              return InkWell(
                onTap: (){
                  Get.to(() => GroupWorkBookDetail(
                    id: item.id!,
                    listMenuPermissions: listMenuPermissions,
                  ));
                },
                child: GroupWorkBookItem(
                    index,
                    item,
                    groupWorkBookViewModel,listMenuPermissions),
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


