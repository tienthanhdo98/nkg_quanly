import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/utility/individual_contacts/update_individual_contact_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../model/contact_model/contact_model.dart';
import 'contact_individual_viewmodel.dart';


class ContactIndividualDetail extends GetView {
  final String? id;

  final contactIndividualViewModel = Get.put(ContactIndividualViewModel());

  ContactIndividualDetail({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: contactIndividualViewModel.getWorkbookModelDetail(id!),
          builder: (context, AsyncSnapshot<ContactListItems> snapshot) {
            if (snapshot.hasData) {
              var item = snapshot.data;
              return SizedBox(
                height: MediaQuery.of(context).size.height,
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
                              child: Text("Chi tiết liên hệ",
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //ten cv
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                "Tên cán bộ:",
                                style: CustomTextStyle.grayColorTextStyle,
                              ),
                            ),
                            borderText(item!.employeeName!, context),
                            //mota
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "Chức vụ:",
                                style: CustomTextStyle.grayColorTextStyle,
                              ),
                            ),
                            borderText(item.position, context),
                            //nguoi thuc hien
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "Tổ chức:",
                                style: CustomTextStyle.grayColorTextStyle,
                              ),
                            ),
                            borderText(findNameOfDepartById(contactIndividualViewModel.rxDepartmentList,item.departmentId!),
                                context),
                            //nguoi thuc hien
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "Số điện thoại:",
                                style: CustomTextStyle.grayColorTextStyle,
                              ),
                            ),
                            //trangthai
                            borderText(item.phoneNumber, context),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "Email:",
                                style: CustomTextStyle.grayColorTextStyle,
                              ),
                            ),
                            //trangthai
                            borderText(item.email, context),
                            //dia chi
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "Địa chỉ:",
                                style: CustomTextStyle.grayColorTextStyle,
                              ),
                            ),
                            //trangthai
                            borderText(item.address, context),
                            //
                            const Spacer(),
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
                                            primary: kWhite,
                                            //change background color of button
                                            onPrimary: kBlueButton,
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
                                            Get.back();
                                            Get.to(
                                                () => UpdateIndividualContactScreen(item));
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
                                          child: const Text('Chỉnh sửa')),
                                    ),
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
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
