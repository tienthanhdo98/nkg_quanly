import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/book_room_meet/room_meeting_viewmodel.dart';
import 'package:nkg_quanly/ui/report/report_viewmodel.dart';

import '../../const.dart';
import '../../model/meeting_room/meeting_room_model.dart';
import '../../model/report_model/report_model.dart';

class MeetingRoomDetail extends GetView{
  final int? id;

  final RoomMeetingViewModel roomMeetingViewModel = Get.put(RoomMeetingViewModel());

  MeetingRoomDetail({Key? key,this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: FutureBuilder(
        future: roomMeetingViewModel.getRoomMeetingDetail(id!),
        builder: (context,AsyncSnapshot<MeetingRoomItems> snapshot)
        {
          if(snapshot.hasData)
            {
              var item = snapshot.data;
              return  Column(children: [
                headerWidget('Chi tiết ${item!.name!}',context),
                Text(item.name!)
              ]);
            }
          else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());

        },

      ),
    ),);
  }

}