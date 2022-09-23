import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/ultils.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_proc_detail.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_proc_search.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';
import '../../const.dart';
import '../../const/widget.dart';
import '../../model/profile_procedure_model/profile_procedure_model.dart';
import '../book_car/book_car_list.dart';

class ProfilesProcedureList extends GetView {
  final String? header;
  final MenuController menuController = Get.put(MenuController());
  final profilesProcedureController = Get.put(ProfilesProcedureViewModel());
  int selectedButton = 0;

  ProfilesProcedureList({this.header});

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidgetSeatch(header!,ProfileProcSearch(
                header: header,
              ),context),
          headerTableDate(   Obx(() =>  TableCalendar(
              locale: 'vi_VN',
              headerVisible: false,
              calendarFormat:  profilesProcedureController.rxCalendarFormat.value,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: profilesProcedureController.rxSelectedDay.value,
              selectedDayPredicate: (day) {
                return isSameDay(
                    profilesProcedureController
                        .rxSelectedDay.value,
                    day);
              },
              onDaySelected: (selectedDay, focusedDay) async {
                if (!isSameDay(
                    profilesProcedureController
                        .rxSelectedDay.value,
                    selectedDay)) {
                  profilesProcedureController.onSelectDay(selectedDay);
                }
              },
              onFormatChanged: (format) {
                if (profilesProcedureController.rxCalendarFormat.value != format) {
                  // Call `setState()` when updating calendar format
                  profilesProcedureController.rxCalendarFormat.value = format;
                }
              }
          )),
              Center(child: InkWell(
                onTap: (){
                  if(profilesProcedureController.rxCalendarFormat.value != CalendarFormat.month)
                  {
                    profilesProcedureController.switchFormat(CalendarFormat.month);
                  }
                  else
                  {
                    profilesProcedureController.switchFormat(CalendarFormat.week);
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Image.asset("assets/icons/ic_showmore.png",height: 15,width: 80,)),
              )),context),
              //date table
              //list
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Text(
                      'Tất cả thủ tục hành chính',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return kVioletBg;
                                    } else {
                                      return kWhite;
                                    } // Use the component's default.
                                  },
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                        side: const BorderSide(
                                            color: kVioletButton)))),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return filterBottomSheet(menuController);
                                },
                              );
                            },
                            child: const Text(
                              'Bộ lọc',
                              style: TextStyle(color: kVioletButton),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Divider(
                    thickness: 1,
                  )),

              //bottom
              Obx(() =>  Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                        top: BorderSide(
                            color: Theme.of(context).dividerColor))),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          profilesProcedureController.rxSelectedDay.value = DateTime.now();
                          profilesProcedureController.onSelectDay(DateTime.now());
                          profilesProcedureController.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            profilesProcedureController.selectedBottomButton.value, 0)
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime datefrom =  DateTime.now();
                          DateTime dateTo =  datefrom.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(datefrom);
                          String strdateTo = formatDateToString(dateTo);
                          print(strdateFrom);
                          print(strdateTo);
                          profilesProcedureController.postProfileProcByWeek(strdateFrom,strdateTo);
                          profilesProcedureController.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            profilesProcedureController.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          profilesProcedureController.postProfileProcByMonth();
                          profilesProcedureController.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            profilesProcedureController.selectedBottomButton.value, 2),
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

// class ProfileProcItem extends StatelessWidget {
//     ProfileProcItem(this.index, this.docModel);
//
//   final int? index;
//   final ProfileProcedureListItems? docModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 "${index! + 1}.${docModel!.name!}",
//                 style: Theme.of(context).textTheme.headline5,
//               ),
//               Expanded(
//                   child: Align(
//                       alignment: Alignment.centerRight,
//                       child: priorityWidget(docModel!))),
//             ],
//           ),
//           signWidget(docModel!),
//           SizedBox(
//             height: 80,
//             child: GridView.count(
//               physics: const NeverScrollableScrollPhysics(),
//               primary: false,
//               padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 0,
//               crossAxisCount: 3,
//               children: <Widget>[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Người xử lý',
//                         style: CustomTextStyle.grayColorTextStyle),
//                     Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),child: Text(docModel!.handler!,style: Theme.of(context).textTheme.headline5))
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Thời hạn',
//                         style: CustomTextStyle.grayColorTextStyle),
//                     Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),child:Text(formatDate(docModel!.deadline!),style: Theme.of(context).textTheme.headline5))
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Ngày xử lý',
//                         style: CustomTextStyle.grayColorTextStyle),
//                     Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),child:Text(formatDate(docModel!.dateProcess!),style: Theme.of(context).textTheme.headline5))
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const Divider(
//             thickness: 1.5,
//           )
//         ],
//       ),
//     );
//   }
// }


Widget signWidget(ProfileProcedureListItems docModel) {
  if (docModel.status == "Hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          'Hoàn thành',
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
        const Text('Đang xử lý', style: TextStyle(color: kOrangeSign))
      ],
    );
  } else if (docModel.status == "Hoàn thành quá hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text('Hoàn thành quá hạn', style: TextStyle(color: Colors.black))
      ],
    );
  } else if (docModel.status == "Quá hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_outdate.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text('Quá hạn', style: TextStyle(color: Colors.black))
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text('Quá hạn xử lý', style: TextStyle(color: kRedPriority))
      ],
    );
  }
}
