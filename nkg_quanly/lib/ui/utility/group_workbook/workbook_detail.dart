import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/utility/group_workbook/update_group_workbook_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../model/MenuByUserModel.dart';
import '../../../model/group_workbook/group_workbook_model.dart';
import 'group_workbook_viewmodel.dart';

class GroupWorkBookDetail extends GetView {
  final String? id;

  final groupWorkBookViewModel = Get.put(GroupWorkBookViewModel());
  List<MenuPermissions>? listMenuPermissions = [];
  GroupWorkBookDetail({Key? key, this.id,this.listMenuPermissions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("sss $id");
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: groupWorkBookViewModel.getGroupWorkbookModelDetail(id!),
          builder: (context, AsyncSnapshot<GroupWorkBookItems> snapshot) {
            if (snapshot.hasData) {
              var item = snapshot.data;
              return Column(
                children: [
                  //header
                  headerWidget(
                      "Chi tiết nhóm công việc",context),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //ten cv
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Tên công việc:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          borderText(item!.groupWorkName!, context),
                          //nhom cong viec
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Tên nhóm công việc:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          borderText(item.groupWorkName!, context),
                          //mota
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Mô tả:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          borderText(item.description!, context),
                          //nguoi thuc hien
                          //
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                            ),
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: kWhite,
                                          //change background color of button
                                          onPrimary: kBlueButton,
                                          //change text color of button
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              side: const BorderSide(
                                                  color: kVioletButton)),
                                        ),
                                        child: const Text('Đóng')),
                                  ),
                                ),
                                if(checkPermission(listMenuPermissions, "Edit"))  Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(
                                              () => UpdateGroupWorkBookScreen(item));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed)) {
                                                  return kBlueButton;
                                                } else {
                                                  return kBlueButton;
                                                } // Use the component's default.
                                              },
                                            ),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                        child: const Text('Chỉnh sửa')),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  //date table
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
