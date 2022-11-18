import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_list.dart';

import '../../const/const.dart';
import '../../const/widget.dart';
import '../document_out/search_controller.dart';

class ProfileProcSearch extends GetView {
  final searchController = Get.put(SearchController());

  ProfileProcSearch({Key? key}) : super(key: key);

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
                                    hintText: 'Nhập mã hồ sơ, tên hồ sơ',
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  onSubmitted: (value) {
                                    searchController
                                        .searchDataProfileProc(value);
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
                    child:
                    Obx(() => (searchController.isLoading.value == false)
                        ? ListView.builder(
                        controller: searchController.controller,
                        itemCount: searchController.listDataProfileProc.length,
                        itemBuilder: (context, index) {
                          var item = searchController.listDataProfileProc[index];
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
                                    var item = searchController.listDataProfileProc[index];
                                    return SizedBox(
                                        height: 340,
                                        child: DetailProfileProcBottomSheet(
                                            index,
                                            item));
                                  },
                                );
                              },
                              child: ProfileProcItem(
                                  index,
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
    );
  }
}
