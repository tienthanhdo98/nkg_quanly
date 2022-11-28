import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import 'contact_organization_viewmodel.dart';



class AddNewContactScreen extends GetView {
  final contactOrganizationViewModel = Get.put(ContactOrganizationViewModel());

  AddNewContactScreen({Key? key}) : super(key: key);
  String? employeeName;
  String? organizationId;
  String? organizationName ;
  String? phoneNumber;
  String? email;
  String? address;
  String? position;

  @override
  Widget build(BuildContext context) {
    checkAllValueNull();

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          contactOrganizationViewModel.clearTextField();
          Get.back();
          return true;
        },
        child: SafeArea(
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
                        contactOrganizationViewModel.clearTextField();
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
                                    contactOrganizationViewModel.showErrorTextEmployeeName.value ? "Trường dữ liệu không được để trống" : null,
                                    contactOrganizationViewModel.showErrorTextEmployeeName.value ? kRedChart : kDarkGray,
                                    contactOrganizationViewModel.showErrorTextEmployeeName.value ? kRedChart : Colors.black,
                                    "Nhập tên cán bộ"
                                ),
                                style: Theme.of(context).textTheme.headline4,
                                onChanged: (value) {
                                  employeeName = value;
                                  checkAllValueNull();
                                  contactOrganizationViewModel.showErrorTextEmployeeName.value = value.isEmpty;
                                },
                                onTap: (){
                                  if(employeeName != null && employeeName!.isNotEmpty){
                                    contactOrganizationViewModel.showErrorTextEmployeeName.value = false;
                                  } else {
                                    contactOrganizationViewModel.showErrorTextEmployeeName.value = true;
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
                          Obx(() => TextField(
                              decoration: buildInputDecorationAdd(
                                  contactOrganizationViewModel.showErrorTextPosition.value ? "Trường dữ liệu không được để trống" : null,
                                  contactOrganizationViewModel.showErrorTextPosition.value ? kRedChart : kDarkGray,
                                  contactOrganizationViewModel.showErrorTextPosition.value ? kRedChart : Colors.black,
                                  "Nhập chức vụ"
                              ),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                position = value;
                                checkAllValueNull();
                                contactOrganizationViewModel.showErrorTextPosition.value = value.isEmpty;
                              },
                              onTap: (){
                                if(position != null && position!.isNotEmpty){
                                  contactOrganizationViewModel.showErrorTextPosition.value = false;
                                } else {
                                  contactOrganizationViewModel.showErrorTextPosition.value = true;
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
                                  color: kDarkGray,
                                  style: BorderStyle.solid, width: 1),
                            ),
                            child: Row(children: [
                              Expanded(
                                child: StatefulBuilder(
                                  builder: (context, groupWorkerStateChange) {
                                    return DropdownButton(
                                      iconSize: 0.0,
                                      value: organizationName,
                                      style: Theme.of(context).textTheme.headline4,
                                      underline: const SizedBox.shrink(),
                                      items: contactOrganizationViewModel.rxOrganList
                                          .map((value) => DropdownMenuItem(
                                                child: Text(value.name!),
                                                value: value.name,
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        groupWorkerStateChange(
                                            () => organizationName = value.toString());
                                        for (var element in contactOrganizationViewModel
                                            .rxOrganList) {
                                          if (element.name ==
                                              value.toString()) {
                                            organizationId = element.id;
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
                          Obx(() => TextField(
                              decoration: buildInputDecorationAdd(
                                  contactOrganizationViewModel.showErrorTextPhoneNumber.value ? "Trường dữ liệu không được để trống" : contactOrganizationViewModel.rxPhoneNumber.value.isNotEmpty ? contactOrganizationViewModel.rxPhoneNumber.value.isPhoneNumber ? null : "Số điện thoại không đúng định dạng" : null,
                                  contactOrganizationViewModel.showErrorTextPhoneNumber.value ? kRedChart : contactOrganizationViewModel.rxPhoneNumber.value.isNotEmpty ? contactOrganizationViewModel.rxPhoneNumber.value.isPhoneNumber ? kDarkGray : kRedChart : kDarkGray,
                                  contactOrganizationViewModel.showErrorTextPhoneNumber.value ? kRedChart : Colors.black,
                                  "Nhập số điện thoại"
                              ),
                              // keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                phoneNumber = value;
                                checkAllValueNull();
                                contactOrganizationViewModel.rxPhoneNumber.value = value;
                                contactOrganizationViewModel.showErrorTextPhoneNumber.value = value.isEmpty;
                              },
                              onTap: (){
                                if(phoneNumber != null && phoneNumber!.isNotEmpty){
                                  contactOrganizationViewModel.showErrorTextPhoneNumber.value = false;
                                } else {
                                  contactOrganizationViewModel.showErrorTextPhoneNumber.value = true;
                                }
                              },
                              onSubmitted: (value) {
                                phoneNumber = value;
                                contactOrganizationViewModel.rxPhoneNumber.value = value;
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
                          Obx(() => TextField(
                              decoration: buildInputDecorationAdd(
                                  contactOrganizationViewModel.showErrorTextEmail.value ? "Trường dữ liệu không được để trống" : contactOrganizationViewModel.rxEmail.value.isNotEmpty ? contactOrganizationViewModel.rxEmail.value.isEmail ? null : "Email không đúng định dạng" : null,
                                  contactOrganizationViewModel.showErrorTextEmail.value ? kRedChart : contactOrganizationViewModel.rxEmail.value.isNotEmpty ? contactOrganizationViewModel.rxEmail.value.isEmail ? kDarkGray : kRedChart : kDarkGray,
                                  contactOrganizationViewModel.showErrorTextEmail.value ? kRedChart : Colors.black,
                                  "Nhập email"
                              ),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                email = value;
                                checkAllValueNull();
                                contactOrganizationViewModel.rxEmail.value = value;
                                contactOrganizationViewModel.showErrorTextEmail.value = value.isEmpty;
                              },
                              onTap: (){
                                if(email != null && email!.isNotEmpty){
                                  contactOrganizationViewModel.showErrorTextEmail.value = false;
                                } else {
                                  contactOrganizationViewModel.showErrorTextEmail.value = true;
                                }
                              },
                              onSubmitted: (value) {
                                email = value;
                                contactOrganizationViewModel.rxEmail.value = value;
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
                          Obx(() => TextField(
                              decoration: buildInputDecorationAdd(
                                  contactOrganizationViewModel.showErrorTextAddress.value ? "Trường dữ liệu không được để trống" : null,
                                  contactOrganizationViewModel.showErrorTextAddress.value ? kRedChart : kDarkGray,
                                  contactOrganizationViewModel.showErrorTextAddress.value ? kRedChart : Colors.black,
                                  "Nhập địa chỉ"
                              ),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                address = value;
                                checkAllValueNull();
                                contactOrganizationViewModel.showErrorTextAddress.value = value.isEmpty;
                              },
                              onTap: (){
                                if(address != null && address!.isNotEmpty){
                                  contactOrganizationViewModel.showErrorTextAddress.value = false;
                                } else {
                                  contactOrganizationViewModel.showErrorTextAddress.value = true;
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 50),
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
                                Obx(() =>
                                (contactOrganizationViewModel.isValueNull.value == false) ?
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                            contactOrganizationViewModel.addContact(
                                                employeeName!,
                                                position!,
                                                organizationId!,
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
                                ) :  Expanded(
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
                                                  return kBlueLineChart2;
                                                } else {
                                                  return kBlueLineChart2;
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
                                ))
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

  void checkAllValueNull()
  {
    if((employeeName?.isNotEmpty == true &&
        organizationName?.isNotEmpty== true &&
        phoneNumber?.isNotEmpty == true&&
        email?.isNotEmpty == true&&address?.isNotEmpty== true &&  position?.isNotEmpty== true &&
        contactOrganizationViewModel.rxPhoneNumber.value.isPhoneNumber &&
        contactOrganizationViewModel.rxEmail.value.isEmail) ){
      contactOrganizationViewModel.changeValidateValue(false,contactOrganizationViewModel.isValueNull);
    }
    else
    {
      contactOrganizationViewModel.changeValidateValue(true,contactOrganizationViewModel.isValueNull);
    }
  }
}
