import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../model/contact_model/contact_model.dart';
import '../../theme/theme_data.dart';
import 'contact_individual_viewmodel.dart';

class UpdateIndividualContactScreen extends StatefulWidget {


  UpdateIndividualContactScreen(this.contactListItems);

  ContactListItems contactListItems;

  @override
  State<StatefulWidget> createState() => UpdateIndividualContactState();
}

class UpdateIndividualContactState
    extends State<UpdateIndividualContactScreen> {
  final contactIndividualViewModel = Get.put(ContactIndividualViewModel());


  String? employeeName;

  String? departmentId;

  String? departmentName;

  String? phoneNumber;
  String? email;
  String? address;
  String? position;

  @override
  void initState() {
    employeeName =  widget.contactListItems.employeeName;
    departmentId =  widget.contactListItems.departmentId;
    departmentName = findNameOfDepartById(
        contactIndividualViewModel.rxDepartmentList, departmentId!);
    phoneNumber =  widget.contactListItems.phoneNumber;
    email =  widget.contactListItems.email;
    address =  widget.contactListItems.address;
    position =  widget.contactListItems.position;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Text(
                      "Chỉnh sửa liên hệ",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),

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
                        controller: TextEditingController()
                          ..text = checkingStringNull(employeeName),
                        decoration: decoTextField,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,
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
                        controller: TextEditingController()..text = checkingStringNull(position),
                        decoration: decoTextField,
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
                              color: kDarkGray,
                              style: BorderStyle.solid,
                              width: 1),
                        ),
                        child: Row(children: [
                          Expanded(
                            child: StatefulBuilder(
                              builder: (context, groupWorkerStateChange) {
                                return DropdownButton(
                                  iconSize: 0.0,
                                  value: (departmentName?.isNotEmpty == true)
                                      ? departmentName
                                      : null,
                                  style: Theme.of(context).textTheme.headline4,
                                  underline: const SizedBox.shrink(),
                                  items: contactIndividualViewModel
                                      .rxDepartmentList
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value.name!),
                                            value: value.name,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    groupWorkerStateChange(() =>
                                        departmentName = value.toString());
                                    for (var element
                                        in contactIndividualViewModel
                                            .rxDepartmentList) {
                                      if (element.name == value.toString()) {
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
                        controller: TextEditingController()
                          ..text = checkingStringNull(phoneNumber),
                        decoration: decoTextField,
                        style: Theme.of(context).textTheme.headline4,
                        keyboardType: TextInputType.number,
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
                        controller: TextEditingController()..text = checkingStringNull(email),
                        decoration: decoTextField,
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
                        controller: TextEditingController()..text = checkingStringNull(address),
                        decoration: decoTextField,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline4,
                        onChanged: (value) {
                          address = value;
                        },
                        onSubmitted: (value) {
                          address = value;
                        },
                      ),
                      const SizedBox(
                        height: 50,
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: kBlueButton, backgroundColor: kWhite,
                                      //change text color of button
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: const BorderSide(
                                              color: kVioletButton)),
                                    ),
                                    child: const Text('Đóng')),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                          email!.isNotEmpty ||
                                          address!.isNotEmpty ||
                                          position!.isNotEmpty) {
                                        contactIndividualViewModel
                                            .updateContact(
                                            widget.contactListItems.id!,
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
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return kBlueButton;
                                            } else {
                                              return kBlueButton;
                                            } // Use the component's default.
                                          },
                                        ),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
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
