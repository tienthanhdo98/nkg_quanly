import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/profile/profile_list.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_proc_detail.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_list.dart';
import 'package:nkg_quanly/ui/report/report_list.dart';

import '../../const.dart';
import '../document_nonapproved/document_nonapproved_detail.dart';
import '../document_out/search_controller.dart';


class ProfileProcSearch extends GetView {
  final String? header;
  final searchController = Get.put(SearchController());

  ProfileProcSearch({Key? key, this.header}) : super(key: key);

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
                    const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kgray,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: Icon(Icons.search)),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Tìm kiếm...',
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black),
                                  onSubmitted: (value){
                                    searchController.searchDataProfileProc(value);
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
            // Expanded(
            //   child: Container(
            //
            //     height: double.infinity,
            //     child: Padding(
            //       padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            //       child: SizedBox(
            //         height: 200,
            //         child: Obx(() => ListView.builder(
            //             itemCount: searchController.listDataProfileProc.length,
            //             itemBuilder: (context, index) {
            //               return InkWell(
            //                   onTap: () {
            //                     Get.to(() => ProfileProcDetail(
            //                         id: 1));
            //                   },
            //                   child:
            //                   ProfileProcItem(index, searchController.listDataProfileProc[index]));
            //             })),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
