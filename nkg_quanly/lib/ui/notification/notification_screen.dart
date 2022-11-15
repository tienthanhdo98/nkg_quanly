import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../model/notification_model/notification_model.dart';
import '../workbook/workbook_detail.dart';
import 'notification_model_db.dart';
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
          const Divider(height:0.5,thickness: 1),
          Expanded(
            child: Obx(() => (notificationViewModel.rxListNotificationItemsDB.isNotEmpty) ? ListView.builder(
                itemCount: notificationViewModel.rxListNotificationItemsDB.length,
                controller: notificationViewModel.controller,
                itemBuilder: (context, index) {
                  var item = notificationViewModel.rxListNotificationItemsDB[index];
                  return InkWell(
                      onTap: () async {

                       //  var updateItem = NotificationModelDB(id: item.id ,status: item.status,action:item.action ,createdBy: item.createdBy,createdDate: item.createdDate ,isClick: "true" ,isDeleted: item.isDeleted,lastModifiedBy: item.lastModifiedBy,lastModifiedDate:item.lastModifiedDate ,workbookId: item.workbookId,workName: item.workName);
                       // await notificationViewModel.dbHelper.updateDB(updateItem);
                       //  // Get a reference to the database.
                       //  final db = await notificationViewModel.dbHelper.database;
                       //  notificationViewModel.dbHelper.getDataDB().then((value)
                       //  {
                       //    value.forEach((element) {
                       //      print("${element.workName}-${element.isClick}");
                       //    });
                       //  }

                        // );

                        Get.to(() => WorkBookDetail(
                          id: item.workbookId!,
                        ));
                      },
                      child: Container(
                        // color: item.isClick == "false" ? kLightBlueNotification : kGrayButton,
                        child: Column(
                          children: [
                            NotificationWidgetItem(item,notificationViewModel),
                            const Divider(height:0.5,thickness: 1)
                          ],
                        ),
                      ));
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
  const NotificationWidgetItem(this.docModel, this.notificationViewModel, {Key? key}) : super(key: key);

  final NotificationModelDB? docModel;
  final NotificationViewModel? notificationViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Row(
        children: [
          Container(
              child: Image.asset("assets/ic_person.png"),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: kViolet,
                borderRadius: BorderRadius.circular(30),
              )),
          const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${docModel!.action}",maxLines: 2,overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500,fontFamily: 'Roboto'),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                Text(
                  displayTimeAgoFromTimestamp(checkingStringNull(docModel!.createdDate)),
                  style: TextStyle(fontSize: 13, color: kLightBlueSign,),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: () async {
                //await notificationViewModel!.dbHelper.deleteDB(docModel!.id!);
              },
              child: const Icon(Icons.delete,color: Colors.red,))

        ],
      ),
    );
  }
}