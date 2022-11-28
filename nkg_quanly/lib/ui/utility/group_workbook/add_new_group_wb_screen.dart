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
    return WillPopScope(
      onWillPop: () async {
        groupWorkBookViewModel.clearTextField();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
              children: [
                //header
                headerWidgetClearTextField("Tạo mới nhóm công việc", context, () {
                  menuController.clearAllDateData();
                  groupWorkBookViewModel.clearTextField();
                  Get.back();
                }),
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
                        Obx(() => TextField(
                          decoration: buildInputDecorationAdd(
                              groupWorkBookViewModel.showErrorTextNameWB.value ? "Trường dữ liệu không được để trống" : null,
                              groupWorkBookViewModel.showErrorTextNameWB.value ? kRedChart : kDarkGray,
                              groupWorkBookViewModel.showErrorTextNameWB.value ? kRedChart : Colors.black,
                              "Nhập tên nhóm công việc"
                          ),
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            nameWB = value;
                            checkAllValueNull();
                            groupWorkBookViewModel.showErrorTextNameWB.value = value.isEmpty;
                          },
                          onTap: (){
                            if(nameWB != null && nameWB!.isNotEmpty){
                              groupWorkBookViewModel.showErrorTextNameWB.value = false;
                            } else {
                              groupWorkBookViewModel.showErrorTextNameWB.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            nameWB = value;
                          },
                        )),
                        //des gwb
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Mô tả:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        Obx(() => TextField(
                          decoration: buildInputDecorationAdd(
                              groupWorkBookViewModel.showErrorTextDesNameWB.value ? "Trường dữ liệu không được để trống" : null,
                              groupWorkBookViewModel.showErrorTextDesNameWB.value ? kRedChart : kDarkGray,
                              groupWorkBookViewModel.showErrorTextDesNameWB.value ? kRedChart : Colors.black,
                              "Nhập mô tả"
                          ),
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            desnameWB = value;
                            checkAllValueNull();
                            groupWorkBookViewModel.showErrorTextDesNameWB.value = value.isEmpty;
                          },
                          onTap: (){
                            if(desnameWB != null && desnameWB!.isNotEmpty){
                              groupWorkBookViewModel.showErrorTextDesNameWB.value = false;
                            } else {
                              groupWorkBookViewModel.showErrorTextDesNameWB.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            desnameWB = value;
                          },
                        )),
                        const Padding(padding: EdgeInsets.only(top:15)),
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
                              Obx(() => groupWorkBookViewModel.isValueNull.value
                                  ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        checkAllValueNull();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                              if (states
                                                  .contains(MaterialState.pressed)) {
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
                                      child: const Text('Lưu')),
                                ),
                              )
                                  : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ElevatedButton(
                                      onPressed: () {
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
                              ),
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
      ),
    );
  }
  InputDecoration buildInputDecorationAdd(String? errorText, Color colorBorder, Color colorHintText, String hintText) {
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
        hintStyle: TextStyle(color: colorHintText),
        hintText: hintText,
        fillColor: kWhite
    );
  }

  void checkAllValueNull() {
    if(nameWB?.isNotEmpty == true &&
        desnameWB?.isNotEmpty== true ){
      groupWorkBookViewModel.changeValidateValue(false,groupWorkBookViewModel.isValueNull);
    }
    else
    {
      groupWorkBookViewModel.changeValidateValue(true,groupWorkBookViewModel.isValueNull);
    }
  }
}
