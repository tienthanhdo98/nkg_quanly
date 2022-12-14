import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/book_room_meet/room_meeting_viewmodel.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/meeting_room/meeting_room_model.dart';
import 'booking_meeting_search.dart';

class BookRoomList extends GetView {


  final roomMeetingViewModel = Get.put(RoomMeetingViewModel());

  BookRoomList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              "Lịch họp",
              BookingMeetingSearch(
                  roomMeetingViewModel
              ),
              context),
          //date table
          headerTableDatePicker(context, roomMeetingViewModel),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Text(
                  "Lịch họp",
                  style: Theme.of(context).textTheme.headline5,
                ),
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
                            "Tên phòng họp",
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
                                  //         .rxMeetingRoomItems[index].id!));
                                },
                                child: MeetingRoomItem(
                                    index,
                                    roomMeetingViewModel
                                        .rxMeetingRoomItems[index]));
                          })
                      : noData())),
              //bottom
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
                          menuController.rxSelectedDay.value = DateTime.now();
                          roomMeetingViewModel.onSelectDay(DateTime.now());
                          roomMeetingViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            roomMeetingViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          print(strdateFrom);
                          print(strdateTo);
                          roomMeetingViewModel.getMeetingRoomByWeek(
                              strdateFrom, strdateTo);
                          roomMeetingViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            roomMeetingViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          roomMeetingViewModel.getMeetingRoomByMonth();
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

class MeetingRoomItem extends StatelessWidget {
  MeetingRoomItem(this.index, this.docModel);

  int? index;
  MeetingRoomItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: SizedBox(
                  width: 100,
                  child: Text(docModel!.roomName!, style: Theme.of(context).textTheme.headline5),
                ),
              ),

              Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: docModel!.mettings!.length,
                      itemBuilder: (context, index) {
                        var itemMeeting = docModel!.mettings![index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(formatDateToStringHour(itemMeeting.fromTime!,itemMeeting.toTime!), style: Theme.of(context).textTheme.headline5),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Text(itemMeeting.name!))
                            ],
                          ),
                        );
                      })),

            ],
          ),
        ),
        const Divider(thickness: 3,),
      ],
    );
  }
}

class FilterRoomMeetingBottomSheet extends StatelessWidget {
  const FilterRoomMeetingBottomSheet(this.roomMeetingViewModel, {Key? key})
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

var lisStatus = ["Đã đặt lịch", "Còn trống"];

Widget signWidget(MeetingRoomItems docModel) {
  if (docModel.mettings!.isNotEmpty) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          'Đã đặt lịch',
          style: TextStyle(
              color: kGreenSign, fontSize: 12, fontWeight: FontWeight.w500),
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
        const Text('Còn trống',
            style: TextStyle(
                color: kOrangeSign, fontSize: 12, fontWeight: FontWeight.w500))
      ],
    );
  }
}
