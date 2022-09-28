
import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';

import '../../../const.dart';
import '../../../const/style.dart';
import '../../../const/ultils.dart';
import '../../../const/widget.dart';
import '../../../model/document_out_model/document_out_model.dart';
import '../../document_nonapproved/document_nonapproved_detail.dart';
import '../../profile/profile_search.dart';
import '../../theme/theme_data.dart';
import '../doc_out_viewmodel.dart';


class DocumentOutEOfficeList extends GetView {
  final String? header;

  final MenuController menuController = Get.put(MenuController());
  final documentOutViewModel = Get.put(DocumentOutViewModel());
  int selectedButton = 0;
  DocumentOutEOfficeList({this.header});

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
          headerTableDate( Obx(() =>  TableCalendar(
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
              )),context),
              //list
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tất cả văn bản đi chờ phát hành',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            InkWell(
                              onTap: (){
                                if( menuController.rxShowStatistic.value == true)
                                {
                                  menuController.changeStateShowStatistic(false);
                                }
                                else
                                {
                                  menuController.changeStateShowStatistic(true);
                                }

                              },
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text("5.987",style: textBlueCountTotalStyle),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Align(
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
                                        height: 400,
                                        child: FilterDocumentOutBottomSheet(
                                            menuController, documentOutViewModel));
                                  },
                                );
                              },
                              child: const Text(
                                'Bộ lọc',
                                style: TextStyle(color: kVioletButton),
                              ),
                            ))
                      ],
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
                                      child: DetaiDocOutBottomSheet(index,
                                          documentOutViewModel.rxDocumentOutItems[index]));
                                },
                              );
                            },
                            child:
                            DocOutEOfficeListItem(index, documentOutViewModel.rxDocumentOutItems[index],false));
                      }) :   const Text("Hôm nay không có văn bản nào"))),
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
                        child: bottomDateButton("Ngày",
                            documentOutViewModel.selectedBottomButton.value, 0),
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
                        child: bottomDateButton("Tuần",
                            documentOutViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          documentOutViewModel.getDocumentOutByMonth();
                          documentOutViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                          documentOutViewModel.selectedBottomButton.value, 2),
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

class DocOutEOfficeListItem extends StatelessWidget {
  DocOutEOfficeListItem(this.index, this.docModel,this.isNonApprove);

  final int? index;
  final DocumentOutItems? docModel;
  final bool? isNonApprove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${index! + 1}. ${docModel!.name}",
            style: Theme.of(context).textTheme.headline3,
          ),
          textCodeStyle(docModel!.code!),
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
                    const Text('Đơn vị ban hành',style: CustomTextStyle.grayColorTextStyle),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(docModel!.departmentPublic!,style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến',style: CustomTextStyle.grayColorTextStyle),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(formatDate(docModel!.toDate!),style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',style: CustomTextStyle.grayColorTextStyle),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(formatDate(docModel!.endDate!),style: Theme.of(context).textTheme.headline5))
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
class DetaiDocOutBottomSheet extends StatelessWidget {
  const DetaiDocOutBottomSheet( this.index,this.docModel,
      {Key? key})
      : super(key: key);
  final int? index;
  final DocumentOutItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20  , 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin văn bản đi chờ phát hành',
            style: TextStyle(
                color: kBlueButton,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 16),
          ),
          const Divider(
            thickness: 1,
            color: kBlueButton,
          ),
         const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Text(
            "${index! + 1}. ${docModel!.name}",
            style: Theme.of(context).textTheme.headline3,
          ),
          textCodeStyle(docModel!.code!),
          SizedBox(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              childAspectRatio: 3/2,
              crossAxisSpacing: 35,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đơn vị ban hành',style: CustomTextStyle.grayColorTextStyle),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(docModel!.departmentPublic!,style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến',style: CustomTextStyle.grayColorTextStyle),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(formatDate(docModel!.toDate!),style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',style: CustomTextStyle.grayColorTextStyle),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(formatDate(docModel!.endDate!),style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('File đính kèm',style: CustomTextStyle.grayColorTextStyle),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(docModel!.detail!,style: const TextStyle(color: kBlueButton),maxLines: 2,overflow: TextOverflow.ellipsis))
                  ],
                ),

              ],
            ),
          ),
          const Spacer(),
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
                          // Get.to(() => MissionDetail(
                          //     id: int.parse(docModel!.id!)));
                        },
                        style: buttonFilterBlue,
                        child: const Text('Xem chi tiết')),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterDocumentOutBottomSheet extends StatelessWidget {
  const FilterDocumentOutBottomSheet(this.menuController, this.documentOutViewModel,
      {Key? key})
      : super(key: key);
  final MenuController? menuController;
  final DocumentOutViewModel? documentOutViewModel;

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
                      'Tất cả văn bản đi chờ phát hành',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() => (documentOutViewModel!.mapAllFilter.containsKey(0))
                      ? InkWell(
                      onTap: () {
                        documentOutViewModel!.checkboxFilterAll(false, 0);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        documentOutViewModel!.checkboxFilterAll(true, 0);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: kBlueButton,
            ),
            // Tất cả trang thai
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
                  Obx(() => (documentOutViewModel!.mapAllFilter.containsKey(3))
                      ? InkWell(
                      onTap: () {
                        documentOutViewModel!.checkboxFilterAll(false, 3);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        documentOutViewModel!.checkboxFilterAll(true, 3);
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
                  physics: const BouncingScrollPhysics(),
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
                              Obx(() => (documentOutViewModel!.mapStatusFilter
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    documentOutViewModel!
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
                                    documentOutViewModel!
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
                            var status = "";
                            if (documentOutViewModel!.mapAllFilter.containsKey(0)) {
                              documentOutViewModel!.postDocOutByFilter(
                                status,
                              );
                            } else {
                              if (documentOutViewModel!.mapAllFilter
                                  .containsKey(3)) {
                                status = "";
                              }
                              else
                              {
                                documentOutViewModel!.mapStatusFilter.forEach((key, value) {
                                  status += value;
                                });
                              }
                            }
                            print(status);
                            documentOutViewModel!.postDocOutByFilter(
                                status,);
                            Get.back();
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
var lisStatus= ["Chưa xử lý","Đã xử lý"];




Widget signWidget(DocumentOutItems docModel) {

    if (docModel.status == "Đã xử lý") {
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
            style: const TextStyle(color: kGreenSign),
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
           Text(docModel.status!, style: const TextStyle(color: kOrangeSign))
        ],
      );
    }
}
