import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/widget.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';

import '../../const/const.dart';
import 'e_office/mission__e_office_list.dart';

// class MissionSearch extends GetView {
//   String? header;
//   final searchController = Get.put(SearchController());
//
//   MissionSearch({Key? key, this.header}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   border: Border(
//                       bottom: BorderSide(
//                     width: 1,
//                     color: Theme.of(context).dividerColor,
//                   ))),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Image.asset(
//                         'assets/icons/ic_arrow_back.png',
//                         width: 18,
//                         height: 18,
//                       ),
//                     ),
//                     const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
//                     Expanded(
//                       child: Container(
//                           decoration: BoxDecoration(
//                               color: kgray,
//                               borderRadius: BorderRadius.circular(10)),
//                           height: 50,
//                           width: double.infinity,
//                           child: Row(
//                             children: [
//                               const Padding(
//                                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                   child: Icon(Icons.search)),
//                               SizedBox(
//                                 width: 200,
//                                 child: TextField(
//                                   maxLines: 1,
//                                   decoration: const InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'Nhập mã nhiệm vụ, tên nhiệm vụ',
//                                   ),
//                                   style: const TextStyle(color: Colors.black),
//                                   onSubmitted: (value) {
//                                     searchController.searchDataMission(value);
//                                     searchController.changeLoadingState(true);
//                                   },
//                                   onChanged: (value) {
//                                     //print(value);
//                                     // searchController.searchData(value);
//                                   },
//                                 ),
//                               )
//                             ],
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: double.infinity,
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                     child: SizedBox(
//                         height: 200,
//                         child: Obx(() => searchResultWidget(
//                             searchController,
//                             searchController.listDataMission,
//                             listSearchResultWidget(searchController, searchController.listDataMission))))),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

Widget listMissionSearchResultWidget(SearchController searchController, List list) {
  return ListView.builder(
      controller: searchController.controller,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var item = list[index];
        return InkWell(
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
                  return DetailMissionBottomSheet(item);
                },
              );
            },
            child: MissionListItem(item));
      });
}
