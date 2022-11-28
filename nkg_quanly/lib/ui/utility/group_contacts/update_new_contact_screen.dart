import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../model/contact_model/contact_model.dart';
import '../../theme/theme_data.dart';
import 'contact_organization_viewmodel.dart';

class UpdateNewContactScreen extends StatefulWidget {

  UpdateNewContactScreen(this.contactListItems, {Key? key}) : super(key: key) ;

  ContactListItems contactListItems;

  @override
  State<StatefulWidget> createState() => UpdateOrganContactState();

}
class UpdateOrganContactState extends State<UpdateNewContactScreen>
{
  final contactOrganizationViewModel = Get.put(ContactOrganizationViewModel());
  String? employeeName;
  String? organizationId;
  String? organizationName;
  String? phoneNumber;
  String? email;
  String? address;
  String? position;

  @override
  void initState() {
    employeeName = widget.contactListItems.employeeName;
    organizationId =  widget.contactListItems.organizationId;
    organizationName = findNameOfOrganById(
        contactOrganizationViewModel.rxOrganList, organizationId!);
    phoneNumber =  widget.contactListItems.phoneNumber;
    contactOrganizationViewModel.rxPhoneNumber.value = phoneNumber!;
    email =  widget.contactListItems.email;
    contactOrganizationViewModel.rxEmail.value = email!;
    address =  widget.contactListItems.address;
    position =  widget.contactListItems.position;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkAllValueNull();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          contactOrganizationViewModel.clearTextField();
          return true;
        },
        child: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            contactOrganizationViewModel.clearTextField();
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
                          Obx(() => TextField(
                              controller: TextEditingController(text: checkingStringNull(employeeName)),
                                // ..text = checkingStringNull(employeeName),
                              decoration: buildInputDecorationUpdate(
                                  contactOrganizationViewModel.showErrorTextEmployeeName.value ? "Trường dữ liệu không được để trống" : null,
                                  contactOrganizationViewModel.showErrorTextEmployeeName.value ? kRedChart : kDarkGray),
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                employeeName = value;
                                contactOrganizationViewModel.showErrorTextEmployeeName.value = value.isEmpty;
                              },
                              onTap: (){
                                if(employeeName != null && employeeName!.isNotEmpty){
                                  contactOrganizationViewModel.showErrorTextEmployeeName.value = false;
                                } else {
                                  contactOrganizationViewModel.showErrorTextEmployeeName.value = true;
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
                          Obx(() => TextField(
                              controller: TextEditingController()..text = checkingStringNull(position),
                              decoration: buildInputDecorationUpdate(
                                  contactOrganizationViewModel.showErrorTextPosition.value ? "Trường dữ liệu không được để trống" : null,
                                  contactOrganizationViewModel.showErrorTextPosition.value ? kRedChart : kDarkGray
                              ),
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                position = value;
                                contactOrganizationViewModel.showErrorTextPosition.value = value.isEmpty;
                              },
                              onTap: (){
                                if(position != null && position!.isNotEmpty){
                                  contactOrganizationViewModel.showErrorTextPosition.value = false;
                                } else {
                                  contactOrganizationViewModel.showErrorTextPosition.value = true;
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
                                      value: (organizationName?.isNotEmpty == true)
                                          ? organizationName
                                          : null,
                                      style: Theme.of(context).textTheme.headline4,
                                      underline: const SizedBox.shrink(),
                                      items:
                                      contactOrganizationViewModel.rxOrganList
                                          .map((value) => DropdownMenuItem(
                                        child: Text(value.name!),
                                        value: value.name,
                                      ))
                                          .toList(),
                                      onChanged: (value) {
                                        groupWorkerStateChange(() =>
                                        organizationName = value.toString());
                                        for (var element
                                        in contactOrganizationViewModel
                                            .rxOrganList) {
                                          if (element.name == value.toString()) {
                                            organizationId = element.id;
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
                          Obx(() => TextField(
                              controller: TextEditingController()..text = checkingStringNull(phoneNumber),
                              decoration: buildInputDecorationUpdate(
                                  contactOrganizationViewModel.showErrorTextPhoneNumber.value ? "Trường dữ liệu không được để trống" : contactOrganizationViewModel.phoneNumberValidator() ? null : "Số điện thoại không đúng định dạng",
                                  contactOrganizationViewModel.showErrorTextPhoneNumber.value ? kRedChart : contactOrganizationViewModel.phoneNumberValidator() ? kDarkGray : kRedChart
                              ),
                              // keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                phoneNumber = value;
                                checkAllValueNull();
                                contactOrganizationViewModel.rxPhoneNumber.value = value;
                                // contactOrganizationViewModel.phoneNumberValidator();
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
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Email:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          Obx(() => TextField(
                              controller: TextEditingController()..text = checkingStringNull(email),
                              decoration: buildInputDecorationUpdate(
                                  contactOrganizationViewModel.showErrorTextEmail.value ? "Trường dữ liệu không được để trống" : contactOrganizationViewModel.rxEmail.value.isEmail ? null : "Email không đúng định dạng",
                                  contactOrganizationViewModel.showErrorTextEmail.value ? kRedChart : contactOrganizationViewModel.rxEmail.value.isEmail ? kDarkGray: kRedChart
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
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Địa chỉ:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          Obx(() => TextField(
                              controller: TextEditingController()..text = checkingStringNull(address),
                              decoration: buildInputDecorationUpdate(
                                  contactOrganizationViewModel.showErrorTextAddress.value ? "Trường dữ liệu không được để trống" : null,
                                  contactOrganizationViewModel.showErrorTextAddress.value ? kRedChart : kDarkGray
                              ),

                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4,
                              onChanged: (value) {
                                address = value;
                                contactOrganizationViewModel.showErrorTextAddress.value = value.isEmpty;
                              },
                              onTap: (){
                                if(address != null && address!.isNotEmpty){
                                  contactOrganizationViewModel.showErrorTextAddress.value = false;
                                } else {
                                  contactOrganizationViewModel.showErrorTextAddress.value = true;
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
                                Obx(() =>
                                (contactOrganizationViewModel.isValueNull.value == false) ?
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          contactOrganizationViewModel
                                              .updateContact(
                                              widget.contactListItems.id!,
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
              ],
            )),
      ),
    );
  }

  InputDecoration buildInputDecorationUpdate(String? errorText, Color colorBorderSide) {
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


  void checkAllValueNull()
  {
    if((employeeName?.isNotEmpty == true &&
        organizationName?.isNotEmpty== true &&
        phoneNumber?.isNotEmpty == true&&
        email?.isNotEmpty == true&&address?.isNotEmpty== true &&  position?.isNotEmpty== true &&
        contactOrganizationViewModel.phoneNumberValidator() &&
        contactOrganizationViewModel.rxEmail.value.isEmail) ){
      contactOrganizationViewModel.changeValidateValue(false,contactOrganizationViewModel.isValueNull);
    }
    else
    {
      contactOrganizationViewModel.changeValidateValue(true,contactOrganizationViewModel.isValueNull);
    }
  }

}



