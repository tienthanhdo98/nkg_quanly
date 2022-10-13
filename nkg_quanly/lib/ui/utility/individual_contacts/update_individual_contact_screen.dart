import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../model/contact_model/contact_model.dart';
import 'contact_individual_viewmodel.dart';



class UpdateIndividualContactScreen extends GetView {

  final ContactListItems contactListItems;
  final contactIndividualViewModel = Get.put(ContactIndividualViewModel());

  UpdateIndividualContactScreen(this.contactListItems,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? employeeName = contactListItems.employeeName;
    String? departmentId = contactListItems.departmentId;
    String? departmentName = findNameOfDepartById(contactIndividualViewModel.rxDepartmentList,departmentId!);
    String? phoneNumber= contactListItems.phoneNumber;
    String? email= contactListItems.email;
    String? address= contactListItems.address;
    String? position = contactListItems.position;

    return Scaffold(
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
                            controller: TextEditingController()..text = employeeName!,
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
                            },
                            onSubmitted: (value) {
                              employeeName = value;
                            },
                          ),
                          //Nhập tên tổ chức
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Chức vụ:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          TextField(
                              controller: TextEditingController()..text = position!,
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
                            style: Theme.of(context).textTheme.headline4,
                            onChanged: (value) {
                              print(value);
                              position = value;
                            },
                            onSubmitted: (value) {
                              position = value;
                            },
                          ),
                          //Chọn to chuc
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                                      value: (departmentName?.isNotEmpty == true) ?departmentName : null ,
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
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Số điện thoại:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          TextField(
                          controller: TextEditingController()..text = phoneNumber!,
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
                            style: Theme.of(context).textTheme.headline4,
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                            onSubmitted: (value) {
                              phoneNumber = value;
                            },
                          ),
                          //Nhập email
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Email:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          TextField(
    controller: TextEditingController()..text = email!,
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
                              email = value;
                            },
                            onSubmitted: (value) {
                              email = value;
                            },
                          ),
                          //Nhập địa chỉ
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Địa chỉ:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          TextField(
    controller: TextEditingController()..text = address!,
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
                            },
                            onSubmitted: (value) {
                              address = value;
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
                                          print(employeeName);
                                          print(departmentId);
                                          print(departmentName);
                                          print(phoneNumber);
                                          print(email);
                                          print(address);
                                          print(position);
                                          if (employeeName!.isNotEmpty ||
                                              departmentName!.isNotEmpty ||
                                              phoneNumber!.isNotEmpty ||
                                              email!.isNotEmpty ||address!.isNotEmpty ||  position!.isNotEmpty) {
                                            contactIndividualViewModel.updateContact(
                                                contactListItems.id!,
                                                employeeName!,
                                                position!,
                                                departmentId!,
                                                phoneNumber!,
                                                address!,
                                                email!);
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
                  ),
                ),
              )
              //date table
            ],
          )),
    );
  }
}