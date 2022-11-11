import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Text("Thông báo",style : Theme.of(context).textTheme.headline1),
          ),
          Expanded(
            child: Obx(() => (notificationViewModel.rxListNotificationItems.isNotEmpty) ? ListView.builder(
                itemCount: notificationViewModel.rxListNotificationItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        // Get.to(() => MissionDetail(
                        //     id: int.parse(missionViewModel
                        //         .rxMissionItem[index].id!)));
                      },
                      child: NotificationWidget(
                          index, notificationViewModel.rxListNotificationItems[index]));
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
class NotificationWidget extends StatelessWidget {
  const NotificationWidget(this.index, this.docModel, {Key? key}) : super(key: key);

  final int? index;
  final NotificationItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${docModel!.workName}",
            style: Theme.of(context).textTheme.headline3,
          ),
          // const Divider(
          //   thickness: 1,
          // )
        ],
      ),
    );
  }
}