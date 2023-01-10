import 'package:flutter/material.dart';
import 'package:nkg_quanly/viewmodel/home_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../model/MenuByUserModel.dart';
import '../../model/notification_model/notification_model.dart';
import '../workbook/workbook_detail.dart';
import 'notification_viewmodel.dart';

class NotificationScreen extends GetView {
  final notificationViewModel = Get.put(NotificationViewModel());

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  HomeViewModel homeController = Get.find();

  void _onRefresh() async {
    await notificationViewModel.getNotificationList();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    MenuByUserModel? childrenTienIch = homeController.rxListMenuByUserRole.firstWhereOrNull((element) => element.id == "84849e1f-e7fa-4654-540e-08da9b7bdabe");
    List<MenuPermissions>? listMenuPermissionWorkbook = childrenTienIch?.childrens?.firstWhereOrNull((element) => element.id == "b2a7b093-b233-458f-ac14-08da9bb8bee8")?.menuPermissions;

    notificationViewModel.initDataHomeScreen();
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            child: Row(
              children: [
                Text("Thông báo", style: Theme.of(context).textTheme.headline1),
                const Spacer(),
                Obx(() => (notificationViewModel.isShowNotificationAction.value)
                    ? Row(
                        children: [
                          InkWell(
                            onTap: () {
                              notificationViewModel
                                  .isShowNotificationAction.value = false;
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 5)),
                          InkWell(
                            onTap: () {
                              notificationViewModel
                                  .changeAllNotificationStatus();
                            },
                            child: const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 5)),
                           InkWell(
                            onTap: () {
                              String listId = "";
                              notificationViewModel.rxListNotificationItems
                                  .forEach((element) {
                                listId += "\"${element.id}\",";
                              });
                              if (listId.isNotEmpty) {
                                notificationViewModel.deleteNotification(
                                    listId.substring(0, listId.length - 1));
                              }
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      )
                    : InkWell(
                        onTap: () {
                          notificationViewModel.isShowNotificationAction.value =
                              !notificationViewModel
                                  .isShowNotificationAction.value;
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.grey,
                        ),
                      )),
                const Padding(padding: EdgeInsets.only(right: 15))
              ],
            ),
          ),
          const Divider(height: 0.5, thickness: 1),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: Obx(() => (notificationViewModel
                      .rxListNotificationItems.isNotEmpty)
                  ? ListView.builder(
                      itemCount:
                          notificationViewModel.rxListNotificationItems.length,
                      controller: notificationViewModel.controller,
                      itemBuilder: (context, index) {
                        var item = notificationViewModel
                            .rxListNotificationItems[index];
                        return InkWell(
                            onTap: () async {
                              await notificationViewModel
                                  .changeNotificationStatus(item.id!);

                              Get.to(() => WorkBookDetail(
                                    id: item.workbookId!,
                                listMenuPermissions: listMenuPermissionWorkbook,
                                  ));
                            },
                            child: Container(
                              color: item.status == false
                                  ? kLightBlueNotification
                                  : null,
                              child: Column(
                                children: [
                                  NotificationWidgetItem(
                                      item, notificationViewModel,listMenuPermissionWorkbook),
                                  const Divider(height: 0.5, thickness: 1)
                                ],
                              ),
                            ));
                      })
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Text(
                        "Hiện tại chưa có thông báo nào",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )),
            ),
          )
        ]),
      ),
    );
  }
}

class NotificationWidgetItem extends StatelessWidget {
  NotificationWidgetItem(this.docModel, this.notificationViewModel,this.listMenuPermissions,
      {Key? key})
      : super(key: key);
  List<MenuPermissions>? listMenuPermissions;
  final NotificationItems? docModel;
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
          const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${docModel!.workName}${docModel!.action}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto'),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                Text(
                  displayTimeAgoFromTimestamp(
                      checkingStringNull(docModel!.createdDate)),
                  style: const TextStyle(
                    fontSize: 13,
                    color: kLightBlueSign,
                  ),
                ),
              ],
            ),
          ),
           InkWell(
              onTap: () async {
                var id = "\"${docModel!.id!}\"";

                await notificationViewModel!.deleteNotification(id);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
