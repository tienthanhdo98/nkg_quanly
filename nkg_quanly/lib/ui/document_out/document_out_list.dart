import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const.dart';
import '../../const/ultils.dart';
import '../../const/widget.dart';
import '../../model/document/document_model.dart';
import '../../model/document_out_model/document_out_model.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../document_nonapproved/document_nonapproved_detail.dart';
import '../document_nonapproved/document_nonapproved_list.dart';
import '../document_nonapproved/document_nonapproved_search.dart';
import 'doc_out_viewmodel.dart';
import 'document_out_search.dart';

class DocumentOutList extends GetView {
  final String? header;
  DateTime dateNow = DateTime.now();
  final MenuController menuController = Get.put(MenuController());
  final documentOutViewModel = Get.put(DocumentOutViewModel());
  int selectedButton = 0;
  DocumentOutList({this.header});

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidgetSeatch(header!,DocumenOutSearch(
                header: header,
              ),context),
              //date table
              Container(
                color: kgray,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "${dateNow.year} Tháng ${dateNow.month}",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    //date header
                    Obx(() =>  TableCalendar(
                        locale: 'vi_VN',
                        headerVisible: false,
                        calendarFormat:  documentOutViewModel.rxCalendarFormat.value,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: documentOutViewModel.rxSelectedDay.value,
                        selectedDayPredicate: (day) {
                          return isSameDay(
                              documentOutViewModel
                                  .rxSelectedDay.value,
                              day);
                        },
                        onDaySelected: (selectedDay, focusedDay) async {
                          if (!isSameDay(
                              documentOutViewModel
                                  .rxSelectedDay.value,
                              selectedDay)) {
                            documentOutViewModel.onSelectDay(selectedDay);
                          }
                        },
                        onFormatChanged: (format) {
                          if (documentOutViewModel.rxCalendarFormat.value != format) {
                            // Call `setState()` when updating calendar format
                            documentOutViewModel.rxCalendarFormat.value = format;
                          }
                        }
                    )),
                    Center(child: InkWell(
                      onTap: (){
                        if(documentOutViewModel.rxCalendarFormat.value != CalendarFormat.month)
                        {
                          documentOutViewModel.switchFormat(CalendarFormat.month);
                        }
                        else
                        {
                          documentOutViewModel.switchFormat(CalendarFormat.week);
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Image.asset("assets/icons/ic_showmore.png",height: 15,width: 80,)),
                    ))
                    //list work
                  ],
                ),
              ),
              //list
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Text(
                      'Tất cả VB',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Divider(
                    thickness: 1,
                  )),
              Expanded(
                  child:Obx(() => (documentOutViewModel.rxDocumentOutItems.isNotEmpty) ? ListView.builder(
                      itemCount: documentOutViewModel.rxDocumentOutItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Get.to(() => DocumentnonapprovedDetail(
                                  id:documentOutViewModel.rxDocumentOutItems[index].id!));
                            },
                            child:
                            DocOutListItem(index, documentOutViewModel.rxDocumentOutItems[index],false));
                      }) :   Expanded(child: Text("Hôm nay không có văn bản nào")))),
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
                          documentOutViewModel.rxSelectedDay.value = DateTime.now();
                          documentOutViewModel.onSelectDay(DateTime.now());
                          documentOutViewModel.swtichBottomButton(0);
                        },
                        child: Container(
                            decoration: (documentOutViewModel.selectedBottomButton.value == 0)
                                ? BoxDecoration(
                              color: kLightBlue,
                              borderRadius:
                              BorderRadius.circular(50),
                            )
                                : const BoxDecoration(),
                            height: 40,
                            width: 40,
                            child: Center(
                                child: Text("Ngày",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: (documentOutViewModel.selectedBottomButton.value  == 0)
                                            ? kBlueButton
                                            : Colors.black)))),
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
                          documentOutViewModel.getDocumentOutByWeek(strdateFrom,strdateTo);
                          documentOutViewModel.swtichBottomButton(1);
                        },
                        child: Container(
                            decoration: (documentOutViewModel.selectedBottomButton.value  == 1)
                                ? BoxDecoration(
                              color: kLightBlue,
                              borderRadius:
                              BorderRadius.circular(50),
                            )
                                : const BoxDecoration(),
                            height: 40,
                            width: 40,
                            child: Center(
                                child: Text(
                                  "Tuần",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: (documentOutViewModel.selectedBottomButton.value  == 1)
                                          ? kBlueButton
                                          : Colors.black),
                                ))),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          documentOutViewModel.getDocumentOutByMonth();
                          documentOutViewModel.swtichBottomButton(2);
                        },
                        child: Container(
                            decoration: (documentOutViewModel.selectedBottomButton.value  == 2)
                                ? BoxDecoration(
                              color: kLightBlue,
                              borderRadius:
                              BorderRadius.circular(50),
                            )
                                : const BoxDecoration(),
                            height: 40,
                            width: 40,
                            child: Center(
                                child: Text("Tháng",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: (documentOutViewModel.selectedBottomButton.value  == 2)
                                            ? kBlueButton
                                            : Colors.black)))),
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

class DocOutListItem extends StatelessWidget {
  DocOutListItem(this.index, this.docModel,this.isNonApprove);

  final int? index;
  final DocumentOutItems? docModel;
  final bool? isNonApprove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${index! + 1}.${docModel!.name}",
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
            height: 80,
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
                    const Text('Đơn vị ban hành',style: CustomTextStyle.secondTextStyle),
                    Text(docModel!.departmentPublic!)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến',style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.toDate!))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.endDate!))
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







Widget signWidget(DocumentOutItems docModel) {

    if (docModel.released == true) {
      return Row(
        children: [
          Image.asset(
            'assets/icons/ic_sign.png',
            height: 14,
            width: 14,
          ),
          const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
          const Text(
            'Đã phát hành',
            style: TextStyle(color: kGreenSign),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Image.asset(
            'assets/icons/ic_not_sign.png',
            height: 14,
            width: 14,
          ),
          const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
          const Text('Chưa phát hành', style: TextStyle(color: kOrangeSign))
        ],
      );
    }
}
