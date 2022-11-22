import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import 'contact_organization_viewmodel.dart';



class AddNewContactScreen extends GetView {
  final contactOrganizationViewModel = Get.put(ContactOrganizationViewModel());

  AddNewContactScreen({Key? key}) : super(key: key);
  String? employeeName ;
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
      body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidget("Tạo mới liên hệ", context),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
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
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: kDarkGray, width: 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                hintStyle: const TextStyle(color: Colors.black),
                                hintText: "Nhập tên cán bộ",
                                fillColor: kWhite),
                            style: Theme.of(context).textTheme.headline4,
                            onChanged: (value) {
                              employeeName = value;
                            checkAllValueNull();
                            },

                          ),
                          //Nhập tên chuc vu
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Chức vụ:",
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
                                hintText: "Nhập chức vụ",
                                fillColor: kWhite),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline4,
                            onChanged: (value) {
                              position = value;
                            checkAllValueNull();
                            },

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
                                hintText: "Nhập số điện thoại",
                                fillColor: kWhite),
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.headline4,
                            onChanged: (value) {
                              phoneNumber = value;
                            checkAllValueNull();
                            },

                          ),
                          //Nhập email
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Email:",
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
                                hintText: "Nhập email",
                                fillColor: kWhite),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline4,
                            onChanged: (value) {
                              email = value;
                            checkAllValueNull();
                            },

                          ),
                          //Nhập địa chỉ
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Địa chỉ:",
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
                                hintText: "Nhập địa chỉ",
                                fillColor: kWhite),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline4,
                            onChanged: (value) {
                              address = value;
                            checkAllValueNull();
                            },

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
                ),
              )
              //date table
            ],
          )),
    );
  }

  void checkAllValueNull()
  {
    if((employeeName?.isNotEmpty == true &&
        organizationName?.isNotEmpty== true &&
        phoneNumber?.isNotEmpty == true&&
        email?.isNotEmpty == true&&address?.isNotEmpty== true &&  position?.isNotEmpty== true) ){
      contactOrganizationViewModel.changeValidateValue(false,contactOrganizationViewModel.isValueNull);
    }
    else
    {
      contactOrganizationViewModel.changeValidateValue(true,contactOrganizationViewModel.isValueNull);
    }
  }
}
