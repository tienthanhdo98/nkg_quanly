import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/style.dart';

import '../../const/utils.dart';
import '../../model/notification_model/notification_model.dart';
import 'notification_viewmodel.dart';

class NotificationScreen extends GetView {
  final notificationViewModel = Get.put(NotificationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).dividerColor,
                    ))),
            width: double.infinity,
            height: 80,

            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/logo.png",
                  width: 200,
                  height: 150,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Text("Thông báo",style : Theme.of(context).textTheme.headline1),
          ),
          Expanded(
            child: Obx(() => (notificationViewModel.rxListNotificationItems.isNotEmpty) ? ListView.builder(
                itemCount: notificationViewModel.rxListNotificationItems.length,
                controller: notificationViewModel.controller,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        // Get.to(() => MissionDetail(
                        //     id: int.parse(missionViewModel
                        //         .rxMissionItem[index].id!)));
                      },
                      child: NotificationWidgetItem(notificationViewModel.rxListNotificationItems[index]));
                }) : Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Text("Hiện tại chưa có thông báo nào",style: Theme.of(context).textTheme.headline4,),
            )),
          )
        ]),
      ),
    );
  }
}
class NotificationWidgetItem extends StatelessWidget {
  const NotificationWidgetItem(this.docModel, {Key? key}) : super(key: key);

  final NotificationItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: SizedBox(
        height: 60,
        child: Row(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${docModel!.createdBy}",
                style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500,fontFamily: 'Roboto'),
              ),
              Text(
                "${docModel!.workName}",
                style: TextStyle(fontSize: 13, color: Colors.black,),
              ),
              Text(
                "10-11-2020 - 8:00 CH",
                style: CustomTextStyle.grayColorTextStyle,
              ),

            ],
          ),
        ),
      ),
    );
  }
}