import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:nkg_quanly/ui/profile_wait_publish/profile_non_publish_filter_screen.dart';
import 'package:nkg_quanly/ui/profile_wait_publish/profile_non_publish_viewmodel.dart';

import '../../../const.dart';
import '../../../const/style.dart';
import '../../../const/ultils.dart';
import '../../../const/widget.dart';
import '../../../model/document_out_model/document_out_model.dart';
import '../document_out/doc_out_viewmodel.dart';
import '../document_out/document_out_search.dart';
import '../theme/theme_data.dart';

class ProfileNonPublishEOfficeList extends GetView {
  final String? header;

  final MenuController menuController = Get.put(MenuController());
  final profileNonPublishViewModel = Get.put(ProfileNonPublishViewModel());

  ProfileNonPublishEOfficeList({Key? key, this.header}) : super(key: key);

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
                  calendarFormat: profileNonPublishViewModel.rxCalendarFormat.value,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: profileNonPublishViewModel.rxSelectedDay.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(
                        profileNonPublishViewModel.rxSelectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    if (!isSameDay(profileNonPublishViewModel.rxSelectedDay.value,
                        selectedDay)) {
                      profileNonPublishViewModel.onSelectDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (profileNonPublishViewModel.rxCalendarFormat.value != format) {
                      // Call `setState()` when updating calendar format
                      profileNonPublishViewModel.rxCalendarFormat.value = format;
                    }
                  })),
              Center(
                  child: InkWell(
                onTap: () {
                  if (profileNonPublishViewModel.rxCalendarFormat.value !=
                      CalendarFormat.month) {
                    profileNonPublishViewModel.switchFormat(CalendarFormat.month);
                  } else {
                    profileNonPublishViewModel.switchFormat(CalendarFormat.week);
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
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hồ sơ đi chờ phát hành',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        InkWell(
                          onTap: () {
                            if (menuController.rxShowStatistic.value == true) {
                              menuController.changeStateShowStatistic(false);
                            } else {
                              menuController.changeStateShowStatistic(true);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child:
                                Text("5.987", style: textBlueCountTotalStyle),
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
                            Get.to(() => ProfileNonPubFilterScreen(profileNonPublishViewModel));                          },
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
              child: Obx(() => (profileNonPublishViewModel
                      .rxDocumentOutItems.isNotEmpty)
                  ? ListView.builder(
                      itemCount: profileNonPublishViewModel.rxDocumentOutItems.length,
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
                                      child: DetaiDocOutBottomSheet(
                                          index,
                                          profileNonPublishViewModel
                                              .rxDocumentOutItems[index]));
                                },
                              );
                            },
                            child: DocOutEOfficeListItem(
                                index,
                                profileNonPublishViewModel.rxDocumentOutItems[index],
                                false));
                      })
                  : const Text("Hôm nay không có văn bản nào"))),
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
                          profileNonPublishViewModel.rxSelectedDay.value =
                              DateTime.now();
                          profileNonPublishViewModel.onSelectDay(DateTime.now());
                          profileNonPublishViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            profileNonPublishViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime datefrom = DateTime.now();
                          DateTime dateTo =
                              datefrom.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(datefrom);
                          String strdateTo = formatDateToString(dateTo);
                          print(strdateFrom);
                          print(strdateTo);
                          profileNonPublishViewModel.getDocumentOutByWeek(
                              strdateFrom, strdateTo);
                          profileNonPublishViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            profileNonPublishViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          profileNonPublishViewModel.getDocumentOutByMonth();
                          profileNonPublishViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            profileNonPublishViewModel.selectedBottomButton.value, 2),
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
  DocOutEOfficeListItem(this.index, this.docModel, this.isNonApprove);

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
                    const Text('Đơn vị ban hành',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.departmentPublic!,
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.toDate!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.endDate!),
                            style: Theme.of(context).textTheme.headline5))
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
  const DetaiDocOutBottomSheet(this.index, this.docModel, {Key? key})
      : super(key: key);
  final int? index;
  final DocumentOutItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
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
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 35,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đơn vị ban hành',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.departmentPublic!,
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.toDate!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.endDate!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('File đính kèm',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.detail!,
                            style: const TextStyle(color: kBlueButton),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis))
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




