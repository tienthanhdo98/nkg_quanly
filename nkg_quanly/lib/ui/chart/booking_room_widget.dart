import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/book_room_meet/room_meeting_viewmodel.dart';


import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/meeting_room/meeting_room_model.dart';
import '../book_room_meet/book_room_list.dart';


class BookingRoomWidget extends GetView {


  final roomMeetingViewModel = Get.put(RoomMeetingViewModel());

  BookingRoomWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(15), child: borderItem(Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phòng họp",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                  Text(convertDateToWidget(dateNow),
                      style: Theme.of(context).textTheme.headline1)
                ],
              ),
              Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookRoomList()));
                    },
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.more_horiz)),
                  ))
            ],
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        Column(children: [
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5,
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Danh sách phòng họp",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5),
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
          SizedBox(
            height: 300,
              child: Obx(() =>
              (roomMeetingViewModel
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
      ],
    ), context));
  }
}


