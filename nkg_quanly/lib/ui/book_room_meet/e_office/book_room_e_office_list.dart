import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/book_room_meet/room_meeting_viewmodel.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../search_screen.dart';
import '../book_room_list.dart';


class BookRoomEOfficeList extends GetView {


  final roomMeetingViewModel = Get.put(RoomMeetingViewModel());

   BookRoomEOfficeList({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          headerWidgetSearch(
              "Bố trí phòng họp",
              SearchScreen(
                hintText: 'Nhập tên phòng họp, tên lịch họp',
                typeScreen: type_room_meeting,
              ),
              context),
          //date table
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tất cả phòng họp',
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(children: [
                      Obx(() => (roomMeetingViewModel
                                  .rxMeetingRoomStatistic.value.total !=
                              null)
                          ? Text(
                              roomMeetingViewModel
                                  .rxMeetingRoomStatistic.value.total
                                  .toString(),
                              style: textBlueCountTotalStyle)
                          : const Text("")),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: kBlueButton,
                          ))
                    ]),
                  ),
                ),
                Obx(() => (menuController.rxShowStatistic.value == true)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Còn trống'),
                                  Text(
                                      roomMeetingViewModel
                                          .rxMeetingRoomStatistic.value.vacancy
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã đặt'),
                                  Text(
                                    roomMeetingViewModel
                                        .rxMeetingRoomStatistic.value.booked
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink()),
                fromDateToDateWidget(roomMeetingViewModel,(){
                  String strDateFrom =
                      menuController.rxFromDateWithoutWeekDayToApi.value;
                  String strDateTo =
                      menuController.rxToDateWithoutWeekDayToApi.value;
                  if(strDateFrom != "" && strDateTo != "") {
                    roomMeetingViewModel.getMeetingRoomListByDiffDate(
                        strDateFrom, strDateTo);
                  }
                  else
                  {
                    roomMeetingViewModel.getMeetingRoomDefault();
                  }
                })
              ],
            ),
          ),
          //
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: kLightGray,
                border: Border(
                  top: BorderSide(
                    color: kgray,
                    width: 1,
                  ),
                )),
            child: Column(children: [
              Column(children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Cả ngày",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      const VerticalDivider(width: 1, thickness: 1),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Danh sách phòng họp",
                              style: Theme.of(context).textTheme.headline5),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
              ]),
              //list car
              Expanded(
                  child: Obx(() => (roomMeetingViewModel
                          .rxMeetingRoomItems.isNotEmpty)
                      ? ListView.builder(
                          itemCount:
                              roomMeetingViewModel.rxMeetingRoomItems.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  // Get.to(() => MeetingRoomDetail(
                                  //     id: roomMeetingViewModel
                                  //         .rxMeetingRoomItems[index]!));
                                },
                                child: MeetingRoomItem(
                                    index,
                                    roomMeetingViewModel
                                        .rxMeetingRoomItems[index]));
                          })
                      : noData())),

            ]),
          )),
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
                          String strDateFrom = formatDateToString(dateNow);
                          String strDateTo = formatDateToString(dateNow);
                          roomMeetingViewModel.getMeetingRoomListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          roomMeetingViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            roomMeetingViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String strDateFrom = formatDateToString(findFirstDateOfTheWeek(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheWeek(dateNow));

                          roomMeetingViewModel.getMeetingRoomListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          roomMeetingViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            roomMeetingViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String strDateFrom = formatDateToString(findFirstDateOfTheMonth(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheMonth(dateNow));

                          roomMeetingViewModel.getMeetingRoomListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          roomMeetingViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            roomMeetingViewModel.selectedBottomButton.value, 2),
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



class FilterRoomMeetingBottomSheet extends StatelessWidget {
  const FilterRoomMeetingBottomSheet(this.roomMeetingViewModel,
      {Key? key})
      : super(key: key);
  final RoomMeetingViewModel? roomMeetingViewModel;

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
                      'Tất cả lịch họp',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() => (roomMeetingViewModel!.mapAllFilter.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            roomMeetingViewModel!.checkboxFilterAll(false, 0);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            roomMeetingViewModel!.checkboxFilterAll(true, 0);
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
                  Obx(() => (roomMeetingViewModel!.mapAllFilter.containsKey(1))
                      ? InkWell(
                          onTap: () {
                            roomMeetingViewModel!.checkboxFilterAll(false, 1);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            roomMeetingViewModel!.checkboxFilterAll(true, 1);
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
                              Obx(() => (roomMeetingViewModel!.mapStatusFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        roomMeetingViewModel!.checkboxStatus(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        roomMeetingViewModel!.checkboxStatus(
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
                            if (roomMeetingViewModel!.mapAllFilter
                                .containsKey(0)) {
                              roomMeetingViewModel!
                                  .getMeetingRoomByFilter(status);
                            } else {
                              if (roomMeetingViewModel!.mapAllFilter
                                  .containsKey(1)) {
                                status = "";
                              } else {
                                roomMeetingViewModel!.mapStatusFilter
                                    .forEach((key, value) {
                                  status += value;
                                });
                              }
                            }
                            print(status);
                            roomMeetingViewModel!
                                .getMeetingRoomByFilter(status);
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


