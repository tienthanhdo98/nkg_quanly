import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import 'contact_individual_viewmodel.dart';



class AddNewContactScreen extends GetView {
  final contactIndividualViewModel = Get.put(ContactIndividualViewModel());
  String? employeeName ;
  String? departmentId;
  String? departmentName ;
  String? phoneNumber;
  String? email;
  String? address;
  String? position;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        contactIndividualViewModel.clearTextField();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                //header
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ))),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        menuController.clearAllDateData();
                        contactIndividualViewModel.clearTextField();
                        Get.back();
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_arrow_back.png',
                            width: 18,
                            height: 18,
                          ),
                          const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                          Flexible(
                            child: Text(
                              "Tạo mới liên hệ",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
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
                          Obx(() => TextField(
                              decoration: buildInputDecorationAdd(
                                  contactIndividualViewModel.showErrorTextEmployeeName.value ? "Trường dữ liệu không được để trống" : null,
                                  contactIndividualViewModel.showErrorTextEmployeeName.value ? kRedChart : kDarkGray,
                                  contactIndividualViewModel.showErrorTextEmployeeName.value ? kRedChart : Colors.black,
                                  "Nhập tên cán bộ"
                              ),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                              onSubmitted: (value) {
                                employeeName = value;
                              },
                              onChanged: (value) {
                                employeeName = value;
                                checkAllValueNull();
                                contactIndividualViewModel.showErrorTextEmployeeName.value = value.isEmpty;
                              },
                              onTap: (){
                                if(employeeName != null && employeeName!.isNotEmpty){
                                  contactIndividualViewModel.showErrorTextEmployeeName.value = false;
                                } else {
                                  contactIndividualViewModel.showErrorTextEmployeeName.value = true;
                                }
                              },
                            ),
                          ),
                          //Nhập tên chuc vu
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Chức vụ:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          Obx(()=> TextField(
                            decoration: buildInputDecorationAdd(
                                contactIndividualViewModel.showErrorTextPosition.value ? "Trường dữ liệu không được để trống" : null,
                                contactIndividualViewModel.showErrorTextPosition.value ? kRedChart : kDarkGray,
                                contactIndividualViewModel.showErrorTextPosition.value ? kRedChart : Colors.black,
                                "Nhập chức vụ"
                            ),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                position = value;
                                checkAllValueNull();
                                contactIndividualViewModel.showErrorTextPosition.value = value.isEmpty;
                              },
                              onTap: (){
                                if(position != null && position!.isNotEmpty){
                                  contactIndividualViewModel.showErrorTextPosition.value = false;
                                } else {
                                  contactIndividualViewModel.showErrorTextPosition.value = true;
                                }
                              },
                            ),
                          ),
                          //Chọn to chuc
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Tổ chức:",
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
                                      value: departmentName,
                                      style: Theme.of(context).textTheme.headline4,
                                      underline: const SizedBox.shrink(),
                                      items: contactIndividualViewModel.rxDepartmentList
                                          .map((value) => DropdownMenuItem(
                                                child: Text(value.name!),
                                                value: value.name,
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        groupWorkerStateChange(
                                            () => departmentName = value.toString());
                                        for (var element in contactIndividualViewModel
                                            .rxDepartmentList) {
                                          if (element.name ==
                                              value.toString()) {
                                            departmentId = element.id;
                                          }
                                        }
                                        checkAllValueNull();
                                      },
                                      isExpanded: false,
                                      hint: const Text(
                                        "Chọn tổ chức",
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

                          //      "Số điện thoại:"
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Số điện thoại:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          Obx(()=> TextField(
                              decoration: buildInputDecorationAdd(
                                  contactIndividualViewModel.showErrorTextPhoneNumber.value ? "Trường dữ liệu không được để trống" : contactIndividualViewModel.rxPhoneNumber.value.isNotEmpty ? contactIndividualViewModel.phoneNumberValidator() ? null : "Số điện thoại không đúng định dạng" : null,
                                  contactIndividualViewModel.showErrorTextPhoneNumber.value ? kRedChart : contactIndividualViewModel.rxPhoneNumber.value.isNotEmpty ? contactIndividualViewModel.phoneNumberValidator() ? kDarkGray : kRedChart : kDarkGray,
                                  contactIndividualViewModel.showErrorTextPhoneNumber.value ? kRedChart : Colors.black,
                                  "Nhập số điện thoại"
                              ),
                              // keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                phoneNumber = value;
                                checkAllValueNull();
                                contactIndividualViewModel.showErrorTextPhoneNumber.value = value.isEmpty;
                                contactIndividualViewModel.rxPhoneNumber.value = value;
                              },
                              onTap: (){
                                if(phoneNumber != null && phoneNumber!.isNotEmpty){
                                  contactIndividualViewModel.showErrorTextPhoneNumber.value = false;
                                } else {
                                  contactIndividualViewModel.showErrorTextPhoneNumber.value = true;
                                }
                              },
                            ),
                          ),
                          //Nhập email
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Email:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          Obx(()=> TextField(
                            decoration: buildInputDecorationAdd(
                                contactIndividualViewModel.showErrorTextEmail.value ? "Trường dữ liệu không được để trống" : contactIndividualViewModel.rxEmail.value.isNotEmpty ? contactIndividualViewModel.rxEmail.value.isEmail ? null : "Email không đúng định dạng" : null,
                                contactIndividualViewModel.showErrorTextEmail.value ? kRedChart : contactIndividualViewModel.rxEmail.value.isNotEmpty ? contactIndividualViewModel.rxEmail.value.isEmail ? kDarkGray : kRedChart : kDarkGray,
                                contactIndividualViewModel.showErrorTextEmail.value ? kRedChart : Colors.black,
                                "Nhập email"
                            ),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                email = value;
                                checkAllValueNull();
                                contactIndividualViewModel.showErrorTextEmail.value = value.isEmpty;
                                contactIndividualViewModel.rxEmail.value = value;
                              },
                              onTap: (){
                                if(email != null && email!.isNotEmpty){
                                  contactIndividualViewModel.showErrorTextEmail.value = false;
                                } else {
                                  contactIndividualViewModel.showErrorTextEmail.value = true;
                                }
                              },
                              onSubmitted: (value) {
                                email = value;
                                contactIndividualViewModel.rxEmail.value = value;
                              },
                            ),
                          ),
                          //Nhập địa chỉ
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Địa chỉ:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          Obx(()=> TextField(
                              decoration: buildInputDecorationAdd(
                                  contactIndividualViewModel.showErrorTextAddress.value ? "Trường dữ liệu không được để trống" : null,
                                  contactIndividualViewModel.showErrorTextAddress.value ? kRedChart : kDarkGray,
                                  contactIndividualViewModel.showErrorTextAddress.value ? kRedChart : Colors.black,
                                  "Nhập địa chỉ"
                              ),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                address = value;
                                checkAllValueNull();
                                contactIndividualViewModel.showErrorTextAddress.value = value.isEmpty;
                              },
                              onTap: (){
                                if(address != null && address!.isNotEmpty){
                                  contactIndividualViewModel.showErrorTextAddress.value = false;
                                } else {
                                  contactIndividualViewModel.showErrorTextAddress.value = true;
                                }
                              },
                              onSubmitted: (value) {
                                address = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 50,),
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
                                Obx(() =>
                                (contactIndividualViewModel.isValueNull.value) ?
                                Expanded(
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
                                ) :  Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                            contactIndividualViewModel.addContact(
                                                employeeName!,
                                                position!,
                                                departmentId!,
                                                phoneNumber!,
                                                address!,
                                                email!);
                                            Get.back();
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
    if(employeeName?.isNotEmpty == true &&
        departmentId?.isNotEmpty== true &&
        departmentName?.isNotEmpty == true &&
        phoneNumber?.isNotEmpty== true &&
        email?.isNotEmpty == true &&
        address?.isNotEmpty== true &&
        position?.isNotEmpty == true &&
        contactIndividualViewModel.rxEmail.value.isEmail &&
        contactIndividualViewModel.phoneNumberValidator()){
      contactIndividualViewModel.changeValidateValue(false,contactIndividualViewModel.isValueNull);
    }
    else
    {
      contactIndividualViewModel.changeValidateValue(true,contactIndividualViewModel.isValueNull);
    }
  }
}
