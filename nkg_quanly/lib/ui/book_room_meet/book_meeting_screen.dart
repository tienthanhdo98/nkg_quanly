import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/book_room_meet/pie_chart_room_meeting.dart';
import 'package:nkg_quanly/ui/book_room_meet/room_meeting_viewmodel.dart';

import '../../const/const.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';
import 'book_room_list.dart';
import 'e_office/book_room_e_office_list.dart';

class BookMeetingScreen extends GetView {
  final String? header;
  final String? icon;

  final  roomMeetingViewModel =
      Get.put(RoomMeetingViewModel());

  BookMeetingScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          Stack(
            children: [
              Image.asset("assets/bgtophome.png",
                  height: 220, width: double.infinity, fit: BoxFit.cover),
              headerWidget(header!, context),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                child: border(
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tổng số phòng họp'),
                                Obx(() => Text((roomMeetingViewModel
                                    .rxMeetingRoomStatistic.value.total != null) ?
                                      roomMeetingViewModel
                                          .rxMeetingRoomStatistic.value.total
                                          .toString() : "0",
                                      style: const TextStyle(
                                          color: kBlueButton, fontSize: 40),
                                    ))
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  icon!,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Còn trống'),
                                Obx(() => Text((roomMeetingViewModel
                                    .rxMeetingRoomStatistic.value.vacancy != null) ?
                                    roomMeetingViewModel
                                        .rxMeetingRoomStatistic.value.vacancy
                                        .toString() : "0",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)))
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Đã đặt'),
                                Obx(() => Text((roomMeetingViewModel
                                    .rxMeetingRoomStatistic.value.booked != null) ?
                                  roomMeetingViewModel
                                      .rxMeetingRoomStatistic.value.booked
                                      .toString() : "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ))
                              ],
                            )
                          ],
                        )
                      ]),
                    ),
                    context),
              )
            ],
          ),
       Obx(() =>( roomMeetingViewModel.rxMeetingRoomStatistic.value.total != null) ? PieChartRoomMeetingWidget(
         key: UniqueKey(),
         documentFilterModel:
         roomMeetingViewModel.rxMeetingRoomStatistic.value,
       ) : const  SizedBox.shrink()),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => BookRoomEOfficeList());
                    },
                    child: buttonShowListScreen("Xem danh sách Phòng họp"),
                    style: bottomButtonStyle,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
