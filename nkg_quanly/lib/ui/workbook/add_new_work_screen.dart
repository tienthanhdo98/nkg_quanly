import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/workbook/workbook_list.dart';
import 'package:nkg_quanly/ui/workbook/workbook_viewmodel.dart';

import '../../const/const.dart';
import '../../const/style.dart';

class AddNewWorkScreen extends GetView {
  final workBookViewModel = Get.put(WorkBookViewModel());
  String? workName;
  String? groupWorkName;
  String? description;
  String? worker;
  String? status;
  bool important = false;
  String? groupWorkId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            //header
            headerWidget("Tạo mới công việc", context),
            Padding(
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
                        hintText: "Nhập tên công việc",
                        fillColor: kWhite),
                    style: Theme.of(context).textTheme.headline4,
                    onChanged: (value) {
                      workName = value;
                    },
                    onSubmitted: (value) {
                      workName = value;
                    },
                  ),
                  //nhom cong viec
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(
                      "Tên nhóm công việc:",
                      style: CustomTextStyle.grayColorTextStyle,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: kDarkGray, style: BorderStyle.solid, width: 1),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, groupWorkerStateChange) {
                            return DropdownButton(
                              iconSize: 0.0,
                              value: groupWorkName,
                              style: Theme.of(context).textTheme.headline4,
                              underline: const SizedBox.shrink(),
                              items: workBookViewModel.rxGroupWorkBookListItems
                                  .map((value) => DropdownMenuItem(
                                        child: Text(value.groupWorkName!),
                                        value: value.groupWorkName,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                groupWorkerStateChange(
                                    () => groupWorkName = value.toString());
                                for (var element in workBookViewModel
                                    .rxGroupWorkBookListItems) {
                                  if (element.groupWorkName ==
                                      value.toString()) {
                                    groupWorkId = element.id;
                                  }
                                }
                              },
                              isExpanded: false,
                              hint: const Text(
                                "Chọn nhóm công việc",
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icons/ic_arrow_down.png',
                              width: 14,
                              height: 14,
                            ),
                          ))
                    ]),
                  ),
                  //mota
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                      print(value);
                      description = value;
                    },
                    onSubmitted: (value) {
                      description = value;
                    },
                  ),
                  //nguoi thuc hien
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(
                      "Người thực hiện:",
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
                        hintText: "Nhập người thực hiện",
                        fillColor: kWhite),
                    style: Theme.of(context).textTheme.headline4,
                    onChanged: (value) {
                      worker = value;
                    },
                    onSubmitted: (value) {
                      worker = value;
                    },
                  ),
                  //nguoi thuc hien
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(
                      "Trạng thái:",
                      style: CustomTextStyle.grayColorTextStyle,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: kDarkGray, style: BorderStyle.solid, width: 1),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, statusStateChange) {
                            return DropdownButton(
                              iconSize: 0.0,
                              style: Theme.of(context).textTheme.headline4,
                              underline: const SizedBox.shrink(),
                              value: status,
                              items: dropdownStatus
                                  .map((value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                statusStateChange(
                                    () => status = value.toString());
                              },
                              isExpanded: false,
                              hint: const Text(
                                "Chọn trạng thái",
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icons/ic_arrow_down.png',
                              width: 14,
                              height: 14,
                            ),
                          ))
                    ]),
                  ),
                  Row(
                    children: [
                      Text(
                        'Quan trọng',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, switchImportantState) {
                              return Switch(
                                  value: important,
                                  onChanged: (value) {
                                    switchImportantState(
                                        () => important = value);
                                  });
                            },
                          ),
                        ),
                      ))
                    ],
                  ),
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
                                  print(workName);
                                  print(groupWorkName);
                                  print(description);
                                  print(worker);
                                  print(status);
                                  print(important);
                                  print(groupWorkId);
                                  if (workName?.isNotEmpty == true ||
                                      groupWorkName?.isNotEmpty == true ||
                                      worker?.isNotEmpty== true ) {
                                    workBookViewModel.addWorkBookAll(
                                        workName!,
                                        groupWorkName!,
                                        description!,
                                        worker!,
                                        status!,
                                        important,
                                        groupWorkId!);
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
            )
            //date table
          ],
        ),
      )),
    );
  }
}
