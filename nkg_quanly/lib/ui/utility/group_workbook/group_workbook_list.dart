import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/widget.dart';
import 'package:nkg_quanly/ui/utility/group_workbook/update_group_workbook_screen.dart';
import 'package:nkg_quanly/ui/utility/group_workbook/workbook_detail.dart';
import 'package:nkg_quanly/ui/workbook/workbook_detail.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../model/group_workbook/group_workbook_model.dart';
import '../../../model/workbook/workbook_model.dart';
import '../../document_nonapproved/document_nonapproved_search.dart';
import '../../theme/theme_data.dart';
import 'add_new_group_wb_screen.dart';
import 'group_workbook_viewmodel.dart';

class GroupWorkBookList extends GetView {
  String? header;
  final groupWorkBookViewModel = Get.put(GroupWorkBookViewModel());

  GroupWorkBookList({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSeatch(
              'Danh sách nhóm công việc',
              DocumentnonapprovedSearch(
                header: "Danh sách nhóm công việc",
              ),
              context),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Row(
              children: [
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    'Tất cả nhóm công việc',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Expanded(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => AddNewGroupWorkBookScreen());
                      },
                      style: elevetedButtonBlue,
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.add,
                            color: kWhite,
                            size: 24.0,
                          ),
                          Text("Thêm mới", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() =>(  groupWorkBookViewModel.rxListGroupWorkBookItems.isNotEmpty)? ListView.builder(
                  itemCount:
                      groupWorkBookViewModel.rxListGroupWorkBookItems.length,
                  itemBuilder: (context, index) {
                    return GroupWorkBookItem(
                        index,
                        groupWorkBookViewModel
                            .rxListGroupWorkBookItems[index],
                        groupWorkBookViewModel);
                  }) : loadingIcon())),
        ],
      )),
    );
  }
}

class GroupWorkBookItem extends StatelessWidget {
  const GroupWorkBookItem(this.index, this.docModel, this.groupWorkBookViewModel);

  final int? index;
  final GroupWorkBookItems? docModel;
  final GroupWorkBookViewModel? groupWorkBookViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.groupWorkName!}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: 300,
                          child: MenuItemWorkBookSheetBottomSheet(
                            docModel: docModel,
                            groupWorkBookViewModel: groupWorkBookViewModel,
                          ));
                    },
                  );
                },
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.more_vert)),
              ),
            ],
          ),
          const Text('Nhóm công việc',
              style: CustomTextStyle.grayColorTextStyle),
          Text(docModel!.description!,
              style: Theme.of(context).textTheme.headline4),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

Widget signWidget(WorkBookListItems docModel) {
  if (docModel.status == "Đã xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          docModel.status!,
          style: const TextStyle(color: kGreenSign),
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
        Text(docModel.status!, style: const TextStyle(color: kOrangeSign))
      ],
    );
  }
}

class MenuItemWorkBookSheetBottomSheet extends StatelessWidget {
  const MenuItemWorkBookSheetBottomSheet(
      {Key? key, this.docModel, this.groupWorkBookViewModel})
      : super(key: key);
  final GroupWorkBookItems? docModel;
  final GroupWorkBookViewModel? groupWorkBookViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => GroupWorkBookDetail(
                        id: docModel!.id!,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_info.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text(
                        "Xem chi tiết nhóm công việc",
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => UpdateGroupWorkBookScreen(docModel!));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_modify.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text("Chỉnh sửa nhóm công việc",
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  showModalBottomSheet<void>(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: 300,
                          child: DeleteItemWorkBookSheetBottomSheet(
                            docModel: docModel,
                            groupWorkBookViewModel: groupWorkBookViewModel,
                          ));
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_trash_del.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text("Xóa nhóm công việc",
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class DeleteItemWorkBookSheetBottomSheet extends StatelessWidget {
  final GroupWorkBookItems? docModel;
  final GroupWorkBookViewModel? groupWorkBookViewModel;

  const DeleteItemWorkBookSheetBottomSheet(
      {Key? key, this.docModel, this.groupWorkBookViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Thông báo",
            style: Theme.of(context).textTheme.headline1,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Text(
                'Bạn chắc chắn muốn xóa bản ghi?',
                style: CustomTextStyle.roboto400s16TextStyle,
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Image.asset(
                'assets/ic_trash.png',
                width: 110,
                height: 100,
              )),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            height: 50,
            child: Align(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kBlueButton,
                            backgroundColor: kWhite,
                            //change text color of button
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(color: kVioletButton)),
                          ),
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            groupWorkBookViewModel!
                                .deleteGroupWorkBookItem(docModel!.id!);
                            Get.back();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return kBlueButton;
                                  } else {
                                    return kBlueButton;
                                  } // Use the component's default.
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: const Text('Xác nhận')),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
