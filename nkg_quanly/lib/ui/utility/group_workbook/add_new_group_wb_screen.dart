import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import 'group_workbook_viewmodel.dart';



class AddNewGroupWorkBookScreen extends GetView {
  final groupWorkBookViewModel = Get.put(GroupWorkBookViewModel());

  AddNewGroupWorkBookScreen({Key? key}) : super(key: key);
  String? nameWB ;
  String? desnameWB;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidget("Tạo mới nhóm công việc", context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //ten gwb
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Tên nhóm công việc:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkGray, width: 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: const TextStyle(color: Colors.black),
                            hintText: "Nhập tên nhóm công việc",
                            fillColor: kWhite),
                        style: Theme.of(context).textTheme.headline4,
                        onChanged: (value) {
                          nameWB = value;
                        },
                        onSubmitted: (value) {
                          nameWB = value;
                        },
                      ),
                      //des gwb
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Mô tả:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkGray, width: 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: const TextStyle(color: Colors.black),
                            hintText: "Nhập mô tả",
                            fillColor: kWhite),
                        style: Theme.of(context).textTheme.headline4,
                        onChanged: (value) {
                          desnameWB = value;
                        },
                        onSubmitted: (value) {
                          desnameWB = value;
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
                                      primary: kWhite,
                                      //change background color of button
                                      onPrimary: kBlueButton,
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
                                      print(nameWB);
                                      print(desnameWB);
                                      if (nameWB?.isNotEmpty == true ||
                                          desnameWB?.isNotEmpty == true) {
                                        groupWorkBookViewModel.addGroupWorkBookAll(
                                            nameWB!,
                                            desnameWB!);
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
                                    child: const Text('Lưu')),
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
