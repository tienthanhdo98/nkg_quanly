import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/widget.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';

import '../../../const/const.dart';
import 'booking_car_viewmodel.dart';
import 'e_office/booking_car_e_office_list.dart';



// class BookingCarSearch  extends GetView {
//
//   final searchController = Get.put(SearchController());
//
//   BookingCarSearch(this.bookingCarViewModel ,{Key? key})
//       : super(key: key);
//     final BookingCarViewModel bookingCarViewModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         searchController.rxBookingCarItems.clear();
//         return true;
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                     border: Border(
//                         bottom: BorderSide(
//                       width: 1,
//                       color: Theme.of(context).dividerColor,
//                     ))),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           searchController.rxBookingCarItems.clear();
//                           Get.back();
//                         },
//                         child: Image.asset(
//                           'assets/icons/ic_arrow_back.png',
//                           width: 18,
//                           height: 18,
//                         ),
//                       ),
//                       const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
//                       Expanded(
//                         child: Container(
//                             decoration: BoxDecoration(
//                                 color: kgray,
//                                 borderRadius: BorderRadius.circular(10)),
//                             height: 50,
//                             width: double.infinity,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                     child:  Image.asset(
//                                       'assets/icons/ic_search.png',
//                                       width: 20,
//                                       height: 20,
//                                     )),
//                                 SizedBox(
//                                   width: 200,
//                                   child: TextField(
//                                     maxLines: 1,
//                                     decoration: const InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: 'Nhập số xe',
//                                     ),
//                                     style: const TextStyle(color: Colors.black),
//                                     onSubmitted: (value) {
//                                       searchController.searchBookingCar(value);
//                                       searchController.changeLoadingState(true);
//                                     },
//                                     // onChanged: (value) {
//                                     //    searchController.searchData(value);
//                                     // },
//                                   ),
//                                 )
//                               ],
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: SizedBox(
//                   height: double.infinity,
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                     child: SizedBox(
//                       height: 200,
//                       child: Obx(() => (searchController.isLoading.value == false) ? : loadingIcon()),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
Widget listCarsSearchResultWidget(SearchController searchController, List list) {
  return ListView.builder(
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
                return SizedBox(
                    height: 320,
                    child: DetailBookingCarsBottomSheet(
                        index,
                        item));
              },
            );
          },
          child: BookCarEOfficeItem(
              index, item),
        );
      });
}


