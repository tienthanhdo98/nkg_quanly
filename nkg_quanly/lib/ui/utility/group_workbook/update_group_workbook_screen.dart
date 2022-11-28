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
  String? name;
  String? dess;

  @override
  Widget build(BuildContext context) {
    name = groupWorkBookItems.groupWorkName;
    dess = groupWorkBookItems.description;
    checkAllValueNull();
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
                headerWidgetClearTextField("Chỉnh sửa nhóm công việc", context, () {
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
                        //ten cb
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            "Tên nhóm công việc:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        Obx(() => TextField(
                          controller: TextEditingController()..text = checkingStringNull(name),
                          decoration: buildInputDecorationUpdate(
                              groupWorkBookViewModel.showErrorTextNameWB.value ? "Trường dữ liệu không được để trống" : null,
                              groupWorkBookViewModel.showErrorTextNameWB.value ? kRedChart : kDarkGray,
                              groupWorkBookViewModel.showErrorTextNameWB.value ? kRedChart : Colors.black,
                          ),
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            name = value;
                            checkAllValueNull();
                            groupWorkBookViewModel.showErrorTextNameWB.value = value.isEmpty;
                          },
                          onTap: (){
                            if(name != null && name!.isNotEmpty){
                              groupWorkBookViewModel.showErrorTextNameWB.value = false;
                            } else {
                              groupWorkBookViewModel.showErrorTextNameWB.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            name = value;
                          },
                        )),
                        //des
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            "Mô tả:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        Obx(() => TextField(
                          controller: TextEditingController()..text = checkingStringNull(dess),
                          decoration: buildInputDecorationUpdate(
                            groupWorkBookViewModel.showErrorTextDesNameWB.value ? "Trường dữ liệu không được để trống" : null,
                            groupWorkBookViewModel.showErrorTextDesNameWB.value ? kRedChart : kDarkGray,
                            groupWorkBookViewModel.showErrorTextDesNameWB.value ? kRedChart : Colors.black,
                          ),
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            dess = value;
                            checkAllValueNull();
                            groupWorkBookViewModel.showErrorTextDesNameWB.value = value.isEmpty;
                          },
                          onTap: (){
                            if(dess != null && dess!.isNotEmpty){
                              groupWorkBookViewModel.showErrorTextDesNameWB.value = false;
                            } else {
                              groupWorkBookViewModel.showErrorTextDesNameWB.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            dess = value;
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
                                      child: const Text('Lưu')),
                                ),
                              )
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
    if(name?.isNotEmpty == true &&
        dess?.isNotEmpty== true ){
      groupWorkBookViewModel.changeValidateValue(false,groupWorkBookViewModel.isValueNull);
    }
    else
    {
      groupWorkBookViewModel.changeValidateValue(true,groupWorkBookViewModel.isValueNull);
    }
  }
}
