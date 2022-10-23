import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../model/group_workbook/group_workbook_model.dart';
import '../../theme/theme_data.dart';
import 'group_workbook_viewmodel.dart';



class UpdateGroupWorkBookScreen extends GetView {

  final GroupWorkBookItems groupWorkBookItems;
  final groupWorkBookViewModel = Get.put(GroupWorkBookViewModel());

  UpdateGroupWorkBookScreen(this.groupWorkBookItems,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name = groupWorkBookItems.groupWorkName;
    String? dess = groupWorkBookItems.description;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
            children: [
              //header
              Container(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios_outlined),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Expanded(
                        child: Text("Chỉnh sửa liên hệ",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              'assets/icons/ic_trash_del.png',
                              width: 20,
                              height: 20,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //ten cb
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Tên cán bộ:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      TextField(
                        controller: TextEditingController()..text = checkingStringNull(name),
                        decoration: decoTextField,
                        style: Theme.of(context).textTheme.headline4,
                        onChanged: (value) {
                          name = value;
                        },
                        onSubmitted: (value) {
                          name = value;
                        },
                      ),
                      //des
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Mô tả:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      TextField(
                        controller: TextEditingController()..text = checkingStringNull(dess),
                        decoration: decoTextField,
                        style: Theme.of(context).textTheme.headline4,
                        onChanged: (value) {
                          dess = value;
                        },
                        onSubmitted: (value) {
                          dess = value;
                        },
                      ),

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
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: kBlueButton, backgroundColor: kWhite,
                                      //change text color of button
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          side: const BorderSide(
                                              color: kVioletButton)),
                                    ),
                                    child: const Text('Đóng')),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      print(name);
                                      print(dess);
                                      if (name!.isNotEmpty ||
                                          dess!.isNotEmpty ) {
                                        groupWorkBookViewModel.updateGroupWorkBook(
                                          groupWorkBookItems.id!,
                                          name!,
                                          dess!
                                        );
                                        Get.back();
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states
                                                .contains(MaterialState.pressed)) {
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
                                    child: Text('Lưu')),
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
          )),
    );
  }
}
