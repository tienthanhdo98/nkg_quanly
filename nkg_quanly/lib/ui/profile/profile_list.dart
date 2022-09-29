import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/model/proflie_model/profile_model.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:nkg_quanly/ui/profile/profile_viewmodel.dart';

import '../../const.dart';
import '../../const/style.dart';
import '../../const/ultils.dart';
import '../../const/widget.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../document_nonapproved/document_nonapproved_detail.dart';
import '../document_nonapproved/document_nonapproved_list.dart';
import '../document_out/document_out_search.dart';
import '../report/report_list.dart';
import '../theme/theme_data.dart';

class ProfileList extends GetView {
  final String? header;

  final MenuController menuController = Get.put(MenuController());
  final profileViewModel = Get.put(ProfileViewModel());

  ProfileList({this.header});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSeatch(
              header!,
              DocumenOutSearch(
                header: header,
              ),
              context),
          //date table
          headerTableDate(
              Obx(() => TableCalendar(
                  locale: 'vi_VN',
                  headerVisible: false,
                  calendarFormat: profileViewModel.rxCalendarFormat.value,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: profileViewModel.rxSelectedDay.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(profileViewModel.rxSelectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    if (!isSameDay(
                        profileViewModel.rxSelectedDay.value, selectedDay)) {
                      profileViewModel.onSelectDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (profileViewModel.rxCalendarFormat.value != format) {
                      // Call `setState()` when updating calendar format
                      profileViewModel.rxCalendarFormat.value = format;
                    }
                  })),
              Center(
                  child: InkWell(
                onTap: () {
                  if (profileViewModel.rxCalendarFormat.value !=
                      CalendarFormat.month) {
                    profileViewModel.switchFormat(CalendarFormat.month);
                  } else {
                    profileViewModel.switchFormat(CalendarFormat.week);
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Image.asset(
                      "assets/icons/ic_showmore.png",
                      height: 15,
                      width: 80,
                    )),
              )),
              context),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Text(
                  'Tất cả hồ sơ trình',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: elevetedButtonWhite,
                        onPressed: () {
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
                                  height: 600,
                                  child: FilterProfileBottomSheet(
                                      menuController, profileViewModel));
                            },
                          );
                        },
                        child: const Text(
                          'Bộ lọc',
                          style: TextStyle(color: kVioletButton),
                        ),
                      )),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => (profileViewModel.rxProfileItems.isNotEmpty)
                  ? ListView.builder(
                      itemCount: profileViewModel.rxProfileItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Get.to(() => DocumentnonapprovedDetail(
                                  id: profileViewModel
                                      .rxProfileItems[index].id!));
                            },
                            child: ProfileListItem(
                                index, profileViewModel.rxProfileItems[index]));
                      })
                  : const Text("Hôm nay không có hồ sơ trình nào"))),
          //bottom
          Obx(() => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                        top:
                            BorderSide(color: Theme.of(context).dividerColor))),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          profileViewModel.rxSelectedDay.value = DateTime.now();
                          profileViewModel.onSelectDay(DateTime.now());
                          profileViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            profileViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          profileViewModel.postProfileByWeek(
                              strdateFrom, strdateTo);
                          profileViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            profileViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          profileViewModel.postProfileByMonth();
                          profileViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            profileViewModel.selectedBottomButton.value, 2),
                      ),
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  ProfileListItem(this.index, this.docModel);

  final int? index;
  final ProfileItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${index! + 1}. ${docModel!.name}",
                style: Theme.of(context).textTheme.headline2,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: priorityWidget(docModel!))),
            ],
          ),
          signWidget(docModel!),
          SizedBox(
            height: 70,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Người xử lý',
                        style: CustomTextStyle.secondTextStyle),
                    Text(docModel!.handler!)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.deadline!))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày xử lý',
                        style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.dateProcess!))
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

// class FilterProfileBottomSheet extends StatelessWidget {
//   const FilterProfileBottomSheet(this.menuController, this.profileViewModel,
//       {Key? key})
//       : super(key: key);
//   final MenuController? menuController;
//   final ProfileViewModel? profileViewModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
//           child: Column(children: [
//             //tatca
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: Row(
//                 children: [
//                   const Expanded(
//                     child: Text(
//                       'Tất cả văn hồ sơ trình',
//                       style: TextStyle(
//                           color: kBlueButton,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Roboto',
//                           fontSize: 16),
//                     ),
//                   ),
//                   Obx(() => (profileViewModel!.mapAllFilter.containsKey(0))
//                       ? InkWell(
//                           onTap: () {
//                             profileViewModel!.checkboxFilterAll(false, 0);
//                           },
//                           child: Image.asset(
//                             'assets/icons/ic_checkbox_active.png',
//                             width: 30,
//                             height: 30,
//                           ))
//                       : InkWell(
//                           onTap: () {
//                             profileViewModel!.checkboxFilterAll(true, 0);
//                           },
//                           child: Image.asset(
//                             'assets/icons/ic_checkbox_unactive.png',
//                             width: 30,
//                             height: 30,
//                           )))
//                 ],
//               ),
//             ),
//             // tat ca muc do
//             const Divider(
//               thickness: 1,
//               color: kBlueButton,
//             ),
//             //tat ca don vi
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: Row(
//                 children: [
//                   const Expanded(
//                     child: Text(
//                       'Tất cả đơn vị soạn thảo',
//                       style: CustomTextStyle.roboto700TextStyle,
//                     ),
//                   ),
//                   Obx(() => (profileViewModel!.mapAllFilter.containsKey(1))
//                       ? InkWell(
//                           onTap: () {
//                             profileViewModel!.checkboxFilterAll(false, 1);
//                           },
//                           child: Image.asset(
//                             'assets/icons/ic_checkbox_active.png',
//                             width: 30,
//                             height: 30,
//                           ))
//                       : InkWell(
//                           onTap: () {
//                             profileViewModel!.checkboxFilterAll(true, 1);
//                           },
//                           child: Image.asset(
//                             'assets/icons/ic_checkbox_unactive.png',
//                             width: 30,
//                             height: 30,
//                           )))
//                 ],
//               ),
//             ),
//             const Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 child: Divider(
//                   thickness: 1,
//                   color: kgray,
//                 )),
//             SizedBox(
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: BouncingScrollPhysics(),
//                   itemCount: profileViewModel!.rxListUnitEditor.length,
//                   itemBuilder: (context, index) {
//                     var item = profileViewModel!.rxListUnitEditor[index];
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   item,
//                                   style: CustomTextStyle.roboto400s16TextStyle,
//                                 ),
//                               ),
//                               Obx(() => (profileViewModel!.mapUnitEditorFilter
//                                       .containsKey(index))
//                                   ? InkWell(
//                                       onTap: () {
//                                         profileViewModel!.checkboxUnitEditor(
//                                             false, index, "$item;");
//                                       },
//                                       child: Image.asset(
//                                         'assets/icons/ic_checkbox_active.png',
//                                         width: 30,
//                                         height: 30,
//                                       ))
//                                   : InkWell(
//                                       onTap: () {
//                                         profileViewModel!.checkboxUnitEditor(
//                                             true, index, "$item;");
//                                       },
//                                       child: Image.asset(
//                                         'assets/icons/ic_checkbox_unactive.png',
//                                         width: 30,
//                                         height: 30,
//                                       )))
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                             child: Divider(
//                               thickness: 1,
//                               color: kgray,
//                             )),
//                       ],
//                     );
//                   }),
//             ),
//             // Tất cả van de trinh
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: Row(
//                 children: [
//                   const Expanded(
//                     child: Text(
//                       'Tất cả vấn đề trình',
//                       style: CustomTextStyle.roboto700TextStyle,
//                     ),
//                   ),
//                   Obx(() => (profileViewModel!.mapAllFilter.containsKey(2))
//                       ? InkWell(
//                           onTap: () {
//                             profileViewModel!.checkboxFilterAll(false, 2);
//                           },
//                           child: Image.asset(
//                             'assets/icons/ic_checkbox_active.png',
//                             width: 30,
//                             height: 30,
//                           ))
//                       : InkWell(
//                           onTap: () {
//                             profileViewModel!.checkboxFilterAll(true, 2);
//                           },
//                           child: Image.asset(
//                             'assets/icons/ic_checkbox_unactive.png',
//                             width: 30,
//                             height: 30,
//                           )))
//                 ],
//               ),
//             ),
//             const Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 child: Divider(
//                   thickness: 1,
//                   color: kgray,
//                 )),
//             //list van de trinh
//             SizedBox(
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: BouncingScrollPhysics(),
//                   itemCount: profileViewModel!.rxListSubmissProblem.length,
//                   itemBuilder: (context, index) {
//                     var item = profileViewModel!.rxListSubmissProblem[index];
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   item,
//                                   style: CustomTextStyle.roboto400s16TextStyle,
//                                 ),
//                               ),
//                               Obx(() => (profileViewModel!.mapSubmissProblem
//                                       .containsKey(index))
//                                   ? InkWell(
//                                       onTap: () {
//                                         profileViewModel!
//                                             .checkboxSubmissProblemr(
//                                                 false, index, "$item;");
//                                       },
//                                       child: Image.asset(
//                                         'assets/icons/ic_checkbox_active.png',
//                                         width: 30,
//                                         height: 30,
//                                       ))
//                                   : InkWell(
//                                       onTap: () {
//                                         profileViewModel!
//                                             .checkboxSubmissProblemr(
//                                                 true, index, "$item;");
//                                       },
//                                       child: Image.asset(
//                                         'assets/icons/ic_checkbox_unactive.png',
//                                         width: 30,
//                                         height: 30,
//                                       )))
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                             child: Divider(
//                               thickness: 1,
//                               color: kgray,
//                             )),
//                       ],
//                     );
//                   }),
//             ),
//             // Tất cả loai phieu trinh
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: Row(
//                 children: [
//                   const Expanded(
//                     child: Text(
//                       'Tất cả loại phiếu trình',
//                       style: CustomTextStyle.roboto700TextStyle,
//                     ),
//                   ),
//                   Obx(() => (profileViewModel!.mapAllFilter.containsKey(3))
//                       ? InkWell(
//                           onTap: () {
//                             profileViewModel!.checkboxFilterAll(false, 3);
//                           },
//                           child: Image.asset(
//                             'assets/icons/ic_checkbox_active.png',
//                             width: 30,
//                             height: 30,
//                           ))
//                       : InkWell(
//                           onTap: () {
//                             profileViewModel!.checkboxFilterAll(true, 3);
//                           },
//                           child: Image.asset(
//                             'assets/icons/ic_checkbox_unactive.png',
//                             width: 30,
//                             height: 30,
//                           )))
//                 ],
//               ),
//             ),
//             const Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 child: Divider(
//                   thickness: 1,
//                   color: kgray,
//                 )),
//             SizedBox(
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: BouncingScrollPhysics(),
//                   itemCount: profileViewModel!.rxListTypeSubmission.length,
//                   itemBuilder: (context, index) {
//                     var item = profileViewModel!.rxListTypeSubmission[index];
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   item,
//                                   style: CustomTextStyle.roboto400s16TextStyle,
//                                 ),
//                               ),
//                               Obx(() => (profileViewModel!.mapTypeSubmission
//                                       .containsKey(index))
//                                   ? InkWell(
//                                       onTap: () {
//                                         profileViewModel!
//                                             .checkboxTypeSubmission(
//                                                 false, index, "$item;");
//                                       },
//                                       child: Image.asset(
//                                         'assets/icons/ic_checkbox_active.png',
//                                         width: 30,
//                                         height: 30,
//                                       ))
//                                   : InkWell(
//                                       onTap: () {
//                                         profileViewModel!
//                                             .checkboxTypeSubmission(
//                                                 true, index, "$item;");
//                                       },
//                                       child: Image.asset(
//                                         'assets/icons/ic_checkbox_unactive.png',
//                                         width: 30,
//                                         height: 30,
//                                       )))
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                             child: Divider(
//                               thickness: 1,
//                               color: kgray,
//                             )),
//                       ],
//                     );
//                   }),
//             ),
//
//             //bottom button
//             Align(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: ElevatedButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           style: buttonFilterWhite,
//                           child: const Text('Đóng')),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: ElevatedButton(
//                           onPressed: () {
//                             Get.back();
//                             var status = "";
//                             var level = "";
//                             var department = "";
//                             var submissionProblem = "";
//                             var typeSubmission = "";
//                             var unitEditor = "";
//                             if (profileViewModel!.mapAllFilter.containsKey(0)) {
//                               profileViewModel!.postProfileByFilter(
//                                   status,
//                                   level,
//                                   department,
//                                   submissionProblem,
//                                   typeSubmission,
//                                   unitEditor);
//                             } else {
//                               if (profileViewModel!.mapAllFilter
//                                   .containsKey(1)) {
//                                 unitEditor = "";
//                               }
//                               else
//                                 {
//                                   profileViewModel!.mapUnitEditorFilter.forEach((key, value) {
//                                     unitEditor += value;
//                                   });
//                                 }
//                               if (profileViewModel!.mapAllFilter
//                                   .containsKey(2)) {
//                                 submissionProblem = "";
//                               }
//                               else
//                                 {
//                                   profileViewModel!.mapSubmissProblem.forEach((key, value) {
//                                     submissionProblem += value;
//                                   });
//                                 }
//                               if (profileViewModel!.mapAllFilter
//                                   .containsKey(3)) {
//                                 typeSubmission = "";
//                               }
//                               else
//                               {
//                                 profileViewModel!.mapTypeSubmission.forEach((key, value) {
//                                   typeSubmission += value;
//                                 });
//                               }
//                             }
//                             print(unitEditor);
//                             print(submissionProblem);
//                             print(typeSubmission);
//                             profileViewModel!.postProfileByFilter(
//                                 status,
//                                 level,
//                                 department,
//                                 submissionProblem,
//                                 typeSubmission,
//                                 unitEditor);
//                           },
//                           style: buttonFilterBlue,
//                           child: const Text('Áp dụng')),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }

//filter by ui
class FilterProfileBottomSheet extends StatelessWidget {
  const FilterProfileBottomSheet(this.menuController, this.profileViewModel,
      {Key? key})
      : super(key: key);
  final MenuController? menuController;
  final ProfileViewModel? profileViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tatca
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả hồ sơ trình',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() => (profileViewModel!.mapAllFilter.containsKey(0))
                      ? InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(false, 0);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(true, 0);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            // tat ca muc do
            const Divider(
              thickness: 1,
              color: kBlueButton,
            ),
            // Tất cả muc do
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả mức độ',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (profileViewModel!.mapAllFilter.containsKey(1))
                      ? InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(false, 1);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(true, 1);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: lisLevel.length,
                  itemBuilder: (context, index) {
                    var item = lisLevel[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (profileViewModel!.mapLevelFilter
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxLevel(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxLevel(
                                        true, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_unactive.png',
                                    width: 30,
                                    height: 30,
                                  )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
                  }),
            ),
            // Tất cả trang thai state
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả trạng thái',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (profileViewModel!.mapAllFilter.containsKey(2))
                      ? InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(false, 2);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(true, 2);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: lisStatus.length,
                  itemBuilder: (context, index) {
                    var item = lisStatus[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (profileViewModel!.mapStatusFilter
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxStatus(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxStatus(
                                        true, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_unactive.png',
                                    width: 30,
                                    height: 30,
                                  )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
                  }),
            ),

            //bottom button
            Align(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: buttonFilterWhite,
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            // var status = "";
                            // var level = "";
                            // if (profileViewModel!.mapAllFilter.containsKey(0)) {
                            //   profileViewModel!.postProfileByFilterUi(
                            //     status,
                            //     level,);
                            // } else {
                            //   if (profileViewModel!.mapAllFilter
                            //       .containsKey(1)) {
                            //     level = "";
                            //   }
                            //   else
                            //   {
                            //     profileViewModel!.mapLevelFilter.forEach((key, value) {
                            //       level += value;
                            //     });
                            //   }
                            //   if (profileViewModel!.mapAllFilter
                            //       .containsKey(2)) {
                            //     status = "";
                            //   }
                            //   else
                            //   {
                            //     profileViewModel!.mapStatusFilter.forEach((key, value) {
                            //       status += value;
                            //     });
                            //   }
                            // }
                            // print(level);
                            // print(status);
                            // profileViewModel!.postProfileByFilterUi(
                            //   status,
                            //   level,
                            // );
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
var lisLevel = ["Thấp","Trung bình","Cao"];
var lisStatus= ["Tạo mới","Hoàn thành","Hoàn thành quá hạn","Quá hạn"];
Widget signWidget(ProfileItems docModel) {
  if (docModel.status == "Hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          docModel.status!,
          style: TextStyle(color: kGreenSign),
        )
      ],
    );
  } else if (docModel.status == "Chưa hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.status!, style: TextStyle(color: kOrangeSign))
      ],
    );
  } else if (docModel.status == "Quá hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.status!, style: TextStyle(color: kRedPriority))
      ],
    );
  } else if(docModel.status == "Hoàn thành quá hạn"){
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_done_black.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.status!, style: TextStyle(color: Colors.black))
      ],
    );
  }
  else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_done_black.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.status!, style: TextStyle(color: Colors.black))
      ],
    );
  }
}
