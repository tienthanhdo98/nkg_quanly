import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/workbook/workbook_list.dart';
import 'package:nkg_quanly/ui/workbook/workbook_viewmodel.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../model/workbook/workbook_model.dart';
import '../theme/theme_data.dart';

class UpdateWorkBookScreen extends StatefulWidget {
  UpdateWorkBookScreen(this.workBookListItems);

  WorkBookListItems workBookListItems;

  @override
  State<StatefulWidget> createState() => UpdateWorkBookState();
}

class UpdateWorkBookState extends State<UpdateWorkBookScreen> {
  final workBookViewModel = Get.put(WorkBookViewModel());
  String? id;
  String? workName;
  String? groupWorkName;
  String? description;
  String? worker;
  String? workerId;
  String? status;
  bool? important;
  String? groupWorkId;


  @override
  Widget build(BuildContext context) {
    id = widget.workBookListItems.id;
    workName = widget.workBookListItems.workName?.trim();
    groupWorkName = widget.workBookListItems.groupWorkName?.trim();
    description = widget.workBookListItems.description?.trim();
    worker = widget.workBookListItems.worker?.trim();
    workerId = widget.workBookListItems.workBy?.trim();
    status = widget.workBookListItems.status?.trim();
    important = widget.workBookListItems.important;
    groupWorkId = widget.workBookListItems.groupWorkId?.trim();

    checkAllValueNull();

    return WillPopScope(
      onWillPop: () async {
        workBookViewModel.clearTextField();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //header
                  headerWidgetClearTextField("Chỉnh sửa công việc", context, (){
                    menuController.clearAllDateData();
                    workBookViewModel.clearTextField();
                    Get.back();
                  }),
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
                        Obx(() => TextField(
                          controller: TextEditingController()..text = checkingStringNull(workName),
                          decoration: buildInputDecorationUpdate(
                              workBookViewModel.showErrorTextWorkName.value ? "Trường dữ liệu không được để trống" : null,
                              workBookViewModel.showErrorTextWorkName.value ? kRedChart : kDarkGray,
                              workBookViewModel.showErrorTextWorkName.value ? kRedChart : Colors.black,
                          ),
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            workName = value;
                            checkAllValueNull();
                            workBookViewModel.showErrorTextWorkName.value = value.isEmpty;
                          },
                          onTap: (){
                            if(workName != null && workName!.isNotEmpty){
                              workBookViewModel.showErrorTextWorkName.value = false;
                            } else {
                              workBookViewModel.showErrorTextWorkName.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            workName = value;
                          },
                        )),
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
                                color: kDarkGray,
                                style: BorderStyle.solid,
                                width: 1),
                          ),
                          child: Row(children: [
                            Expanded(
                              child: StatefulBuilder(
                                builder: (context, setState) =>
                                    DropdownButton(
                                      iconSize: 0.0,
                                      value: (groupWorkName?.isNotEmpty == true)
                                          ? groupWorkName!
                                          : null,
                                      underline: const SizedBox.shrink(),
                                      items: workBookViewModel
                                          .rxGroupWorkBookListItems
                                          .map((value) =>
                                          DropdownMenuItem(
                                            child: Text(
                                                value.groupWorkName!.trim()),
                                            value: value.groupWorkName?.trim(),
                                          ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() =>
                                        groupWorkName = value.toString());
                                        for (var element in workBookViewModel
                                            .rxGroupWorkBookListItems) {
                                          if (element.groupWorkName ==
                                              value.toString()) {
                                            groupWorkId = element.id;
                                          }
                                        }
                                        checkAllValueNull();
                                      },
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline4,
                                      isExpanded: false,
                                      hint: const Text(
                                        "Chọn nhóm công việc",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
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
                        Obx(() => TextField(
                          controller: TextEditingController()..text = checkingStringNull(description),
                          decoration: buildInputDecorationUpdate(
                            workBookViewModel.showErrorTextDescription.value ? "Trường dữ liệu không được để trống" : null,
                            workBookViewModel.showErrorTextDescription.value ? kRedChart : kDarkGray,
                            workBookViewModel.showErrorTextDescription.value ? kRedChart : Colors.black,
                          ),
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            description = value;
                            checkAllValueNull();
                            workBookViewModel.showErrorTextDescription.value = value.isEmpty;
                          },
                          onTap: (){
                            if(description != null && description!.isNotEmpty){
                              workBookViewModel.showErrorTextDescription.value = false;
                            } else {
                              workBookViewModel.showErrorTextDescription.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            description = value;
                          },
                        )),
                        //nguoi thuc hien
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Người thực hiện:",
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
                                builder: (context, workerStateChange) {
                                  return DropdownButton(
                                    iconSize: 0.0,
                                    value: worker,
                                    style: Theme.of(context).textTheme.headline4,
                                    underline: const SizedBox.shrink(),
                                    items: workBookViewModel.rxListWorkerModel
                                        .map((value) => DropdownMenuItem(
                                      child: Text(value.userName!),
                                      value: value.userName,
                                    ))
                                        .toList(),
                                    onChanged: (value) {
                                      workerStateChange(
                                              () => worker = value.toString());
                                      for (var element in workBookViewModel
                                          .rxListWorkerModel) {
                                        if (element.userName ==
                                            value.toString()) {
                                          workerId = element.id;
                                        }
                                      }
                                      checkAllValueNull();
                                    },
                                    isExpanded: false,
                                    hint: const Text(
                                      "Chọn người thực hiện",
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
                        //nguoi thuc hien
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Trạng thái:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        //trangthai
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: kDarkGray,
                                style: BorderStyle.solid,
                                width: 1),
                          ),
                          child: Row(children: [
                            Expanded(
                              child: StatefulBuilder(
                                  builder: (BuildContext context, changeState) {
                                    return DropdownButton(
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline4,
                                      iconSize: 0.0,
                                      value: (status?.isNotEmpty == true &&
                                          dropdownStatus.contains(status))
                                          ? status
                                          : null,
                                      underline: const SizedBox.shrink(),
                                      items: dropdownStatus
                                          .map((value) =>
                                          DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                          .toList(),
                                      onChanged: (value) {
                                        changeState(() =>
                                        status = value.toString());
                                        checkAllValueNull();
                                      },
                                      isExpanded: false,
                                      hint: Text(
                                        "Chọn trạng thái",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    );
                                  }),
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
                        //quan trong
                        Row(
                          children: [
                            Text(
                              'Quan trọng',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                            ),
                            Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: StatefulBuilder(
                                      builder:
                                          (BuildContext context,
                                          StateSetter setState) {
                                        return Switch(
                                            value: important!,
                                            onChanged: (value) {
                                              setState(() => important = value);
                                              // important = value;
                                            });
                                      },
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        //
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
                              Obx(() => workBookViewModel.isValueNull.value
                                  ? Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          checkAllValueNull();
                                        },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                if (states.contains(MaterialState.pressed)) {
                                                  return kLightBlueButton;
                                                } else {
                                                  return kLightBlueButton;
                                                } // Use the component's default.
                                              },
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                ))),
                                        child: const Text('Lưu'))
                                ),
                              )
                                  : Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (id?.isNotEmpty == true &&
                                              workName?.isNotEmpty == true &&
                                              groupWorkName?.isNotEmpty == true &&
                                              description?.isNotEmpty== true &&
                                              worker?.isNotEmpty == true &&
                                              workerId?.isNotEmpty == true &&
                                              status?.isNotEmpty== true &&
                                              groupWorkId?.isNotEmpty== true ) {
                                            workBookViewModel.updateWorkBook(
                                                id!,
                                                workName!,
                                                description!,
                                                workerId!,
                                                status!,
                                                important!,
                                                groupWorkId!);
                                            Get.back();
                                          }
                                        },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
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
                                        child: const Text('Lưu'))
                                ),
                              )
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
      ),
    );
  }

  InputDecoration buildInputDecorationUpdate(String? errorText, Color colorBorder, Color colorHintText) {
    return InputDecoration(
        errorText: errorText,
        errorStyle: const TextStyle(color: kRedChart, fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBorder, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: kWhite
    );
  }

  void checkAllValueNull() {
    if(workName?.isNotEmpty == true &&
        groupWorkName?.isNotEmpty== true &&
        description?.isNotEmpty == true&&
        worker?.isNotEmpty == true &&
        workerId?.isNotEmpty== true &&
        status?.isNotEmpty== true &&
        groupWorkId?.isNotEmpty == true){
      workBookViewModel.changeValidateValue(false,workBookViewModel.isValueNull);
    }
    else
    {
      workBookViewModel.changeValidateValue(true,workBookViewModel.isValueNull);
    }
  }
}
