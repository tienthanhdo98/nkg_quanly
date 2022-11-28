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
    employeeName = widget.contactListItems.employeeName;
    departmentId = widget.contactListItems.departmentId;
    departmentName = findNameOfDepartById(
        contactIndividualViewModel.rxDepartmentList, departmentId!);
    phoneNumber = widget.contactListItems.phoneNumber;
    email = widget.contactListItems.email;
    address = widget.contactListItems.address;
    position = widget.contactListItems.position;

    contactIndividualViewModel.rxPhoneNumber.value = phoneNumber!;
    contactIndividualViewModel.rxEmail.value = email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkAllValueNull();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          contactIndividualViewModel.clearTextField();
          return true;
        },
        child: SafeArea(
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
                        contactIndividualViewModel.clearTextField();
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
                      Obx(
                        () => TextField(
                          controller: TextEditingController()
                            ..text = checkingStringNull(employeeName),
                          decoration: buildInputDecorationUpdate(
                              contactIndividualViewModel
                                      .showErrorTextEmployeeName.value
                                  ? "Trường dữ liệu không được để trống"
                                  : null,
                              contactIndividualViewModel
                                      .showErrorTextEmployeeName.value
                                  ? kRedChart
                                  : kDarkGray),
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            employeeName = value;
                            contactIndividualViewModel.showErrorTextEmployeeName
                                .value = value.isEmpty;
                          },
                          onTap: () {
                            if (employeeName != null &&
                                employeeName!.isNotEmpty) {
                              contactIndividualViewModel
                                  .showErrorTextEmployeeName.value = false;
                            } else {
                              contactIndividualViewModel
                                  .showErrorTextEmployeeName.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            employeeName = value;
                          },
                        ),
                      ),
                      //Nhập tên tổ chức
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Chức vụ:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      Obx(
                        () => TextField(
                          controller: TextEditingController()
                            ..text = checkingStringNull(position),
                          decoration: buildInputDecorationUpdate(
                              contactIndividualViewModel
                                      .showErrorTextPosition.value
                                  ? "Trường dữ liệu không được để trống"
                                  : null,
                              contactIndividualViewModel
                                      .showErrorTextPosition.value
                                  ? kRedChart
                                  : kDarkGray),
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            position = value;
                            contactIndividualViewModel
                                .showErrorTextPosition.value = value.isEmpty;
                          },
                          onTap: () {
                            if (position != null && position!.isNotEmpty) {
                              contactIndividualViewModel
                                  .showErrorTextPosition.value = false;
                            } else {
                              contactIndividualViewModel
                                  .showErrorTextPosition.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            position = value;
                          },
                        ),
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
                      Obx(
                        () => TextField(
                          controller: TextEditingController()
                            ..text = checkingStringNull(phoneNumber),
                          decoration: buildInputDecorationUpdate(
                              contactIndividualViewModel
                                      .showErrorTextPhoneNumber.value
                                  ? "Trường dữ liệu không được để trống"
                                  : contactIndividualViewModel
                                          .rxPhoneNumber.value.isPhoneNumber
                                      ? null
                                      : "Số điện thoại không hợp lệ",
                              contactIndividualViewModel
                                      .showErrorTextPhoneNumber.value
                                  ? kRedChart
                                  : contactIndividualViewModel
                                          .rxPhoneNumber.value.isPhoneNumber
                                      ? kDarkGray
                                      : kRedChart),
                          // keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            phoneNumber = value;
                            checkAllValueNull();
                            contactIndividualViewModel
                                .rxPhoneNumber.value = value;
                            contactIndividualViewModel
                                .showErrorTextPhoneNumber.value = value.isEmpty;
                          },
                          onTap: () {
                            if (phoneNumber != null &&
                                phoneNumber!.isNotEmpty) {
                              contactIndividualViewModel
                                  .showErrorTextPhoneNumber.value = false;
                            } else {
                              contactIndividualViewModel
                                  .showErrorTextPhoneNumber.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            phoneNumber = value;
                            contactIndividualViewModel.rxPhoneNumber.value =
                                value;
                          },
                        ),
                      ),
                      //Nhập email
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Email:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      Obx(
                        () => TextField(
                          controller: TextEditingController()
                            ..text = checkingStringNull(email),
                          decoration: buildInputDecorationUpdate(
                              contactIndividualViewModel
                                      .showErrorTextEmail.value
                                  ? "Trường dữ liệu không được để trống"
                                  : contactIndividualViewModel
                                          .rxEmail.value.isEmail
                                      ? null
                                      : "Email không đúng định dạng",
                              contactIndividualViewModel
                                      .showErrorTextEmail.value
                                  ? kRedChart
                                  : contactIndividualViewModel
                                          .rxEmail.value.isEmail
                                      ? kDarkGray
                                      : kRedChart),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            email = value;
                            checkAllValueNull();
                            contactIndividualViewModel
                                .showErrorTextEmail.value = value.isEmpty;
                            contactIndividualViewModel
                                .rxEmail.value = value;
                          },
                          onTap: () {
                            if (email != null && email!.isNotEmpty) {
                              contactIndividualViewModel
                                  .showErrorTextEmail.value = false;
                            } else {
                              contactIndividualViewModel
                                  .showErrorTextEmail.value = true;
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
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Địa chỉ:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      Obx(
                        () => TextField(
                          controller: TextEditingController()
                            ..text = checkingStringNull(address),
                          decoration: buildInputDecorationUpdate(
                              contactIndividualViewModel
                                      .showErrorTextAddress.value
                                  ? "Trường dữ liệu không được để trống"
                                  : null,
                              contactIndividualViewModel
                                      .showErrorTextAddress.value
                                  ? kRedChart
                                  : kDarkGray),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            address = value;
                            contactIndividualViewModel
                                .showErrorTextAddress.value = value.isEmpty;
                          },
                          onTap: () {
                            if (address != null && address!.isNotEmpty) {
                              contactIndividualViewModel
                                  .showErrorTextAddress.value = false;
                            } else {
                              contactIndividualViewModel
                                  .showErrorTextAddress.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            address = value;
                          },
                        ),
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
                                      foregroundColor: kBlueButton,
                                      backgroundColor: kWhite,
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
                            Obx(() => (contactIndividualViewModel
                                    .isValueNull.value)
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            checkAllValueNull();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return kLightBlueButton;
                                                  } else {
                                                    return kLightBlueButton;
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
                                : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                                contactIndividualViewModel
                                                    .updateContact(
                                                        widget.contactListItems
                                                            .id!,
                                                        employeeName!,
                                                        position!,
                                                        departmentId!,
                                                        phoneNumber!,
                                                        address!,
                                                        email!);
                                                Get.back();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
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

  InputDecoration buildInputDecorationUpdate(
      String? errorText, Color colorBorderSide) {
    return InputDecoration(
        errorText: errorText,
        errorStyle: const TextStyle(color: kRedChart, fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBorderSide, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: kWhite);
  }

  void checkAllValueNull() {
    if (employeeName?.isNotEmpty == true &&
        departmentId?.isNotEmpty == true &&
        departmentName?.isNotEmpty == true &&
        phoneNumber?.isNotEmpty == true &&
        email?.isNotEmpty == true &&
        address?.isNotEmpty == true &&
        position?.isNotEmpty == true &&
        contactIndividualViewModel.rxPhoneNumber.value.isPhoneNumber &&
        contactIndividualViewModel.rxEmail.value.isEmail) {
      contactIndividualViewModel.changeValidateValue(
          false, contactIndividualViewModel.isValueNull);
    } else {
      contactIndividualViewModel.changeValidateValue(
          true, contactIndividualViewModel.isValueNull);
    }
  }
}
