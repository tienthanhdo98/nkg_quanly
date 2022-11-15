import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/utility/individual_contacts/update_individual_contact_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../../model/contact_model/contact_model.dart';
import '../../theme/theme_data.dart';
import 'add_new_contact_screen.dart';
import 'contact_individual_detail.dart';
import 'contact_individual_viewmodel.dart';
import 'individual_contact_search.dart';

class IndividualContactsList extends GetView {

  final contactIndividualViewModel = Get.put(ContactIndividualViewModel());

  IndividualContactsList({Key? key}) : super(key: key);
//Center(child: const CircularProgressIndicator())
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidgetSearch(
                  "Danh bạ điện tử cá nhân",
                  IndividualContactsSearch(
                      contactIndividualViewModel
                  ),
                  context),
              //list
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Row(
                  children: [
                    Align(
                      alignment: FractionalOffset.centerLeft,
                      child: Text(
                        'Tất cả danh bạ',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Expanded(
                      child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        ElevatedButton(
                          style: elevetedButtonWhite,
                          onPressed: () {
                            contactIndividualViewModel.getDepartmentList();
                            showModalBottomSheet<void>(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              isScrollControlled: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: 500,
                                    child: FilterContactIndividualBottomSheet(
                                        contactIndividualViewModel));
                              },
                            );
                          },
                          child: const Text(
                            'Bộ lọc',
                            style: TextStyle(color: kVioletButton),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => AddNewContactScreen());
                          },
                          style: elevetedButtonBlue,
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.add,
                                color: kWhite,
                                size: 24.0,
                              ),
                              Text("Thêm mới", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Divider(
                    thickness: 1,
                  )),
          Expanded(
                  child: Obx(() =>(contactIndividualViewModel.rxContactListItems.isNotEmpty) ? ListView.builder(
                      controller: contactIndividualViewModel.controller,
                      itemCount:
                      contactIndividualViewModel.rxContactListItems.length,
                      itemBuilder: (context, index) {
                        return IndividualContactsItem(
                            index,
                            contactIndividualViewModel
                                .rxContactListItems[index],
                            contactIndividualViewModel);
                      }) : loadingIcon() )),
            ],
          ) ),
    );
  }
}

class IndividualContactsItem extends StatelessWidget {
  IndividualContactsItem(this.index, this.docModel, this.contactIndividualViewModel);

  final int? index;
  final ContactListItems? docModel;
  final ContactIndividualViewModel? contactIndividualViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.employeeName!}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: 300,
                          child: ContactsActionBottomSheet(
                              docModel: docModel,
                              contactIndividualViewModel:
                                  contactIndividualViewModel));
                    },
                  );
                },
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.more_vert)),
              ),
            ],
          ),
          SizedBox(
            height: 80,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Phòng ban',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                          findNameOfDepartById(
                              contactIndividualViewModel!.rxDepartmentList,
                              checkingStringNull(docModel!.departmentId)),
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline4),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chức vụ',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.position!,
                            style: Theme.of(context).textTheme.headline4))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Số điện thoại',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.phoneNumber!,
                            style: Theme.of(context).textTheme.headline4))
                  ],
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

class ContactsActionBottomSheet extends StatelessWidget {
  const ContactsActionBottomSheet(
      {Key? key, this.docModel, this.contactIndividualViewModel})
      : super(key: key);
  final ContactListItems? docModel;
  final ContactIndividualViewModel? contactIndividualViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  Get.to(() => ContactIndividualDetail(
                        id: docModel!.id!,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_info.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text(
                        "Xem chi tiết liên hệ",
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.to(() => UpdateIndividualContactScreen(docModel!));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_modify.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text("Chỉnh sửa liên hệ",
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  showModalBottomSheet<void>(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    isScrollControlled: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: 300,
                          child: DeleteContactSheetBottomSheet(
                            docModel: docModel,
                            contactIndividualViewModel:
                                contactIndividualViewModel,
                          ));
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_trash_del.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text("Xóa liên hệ",
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class DeleteContactSheetBottomSheet extends StatelessWidget {
  final ContactListItems? docModel;
  final ContactIndividualViewModel? contactIndividualViewModel;

  const DeleteContactSheetBottomSheet(
      {Key? key, this.docModel, this.contactIndividualViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Thông báo",
            style: Theme.of(context).textTheme.headline1,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Text(
                'Bạn chắc chắn muốn xóa bản ghi?',
                style: CustomTextStyle.roboto400s16TextStyle,
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Image.asset(
                'assets/ic_trash.png',
                width: 110,
                height: 100,
              )),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            height: 50,
            child: Align(
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
                            foregroundColor: kBlueButton,
                            backgroundColor: kWhite,
                            //change text color of button
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(color: kVioletButton)),
                          ),
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            contactIndividualViewModel!
                                .deleteWorkBookItem(docModel!.id!);
                            Get.back();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
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
                          child: const Text('Xác nhận')),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class FilterContactIndividualBottomSheet extends StatelessWidget {
  const FilterContactIndividualBottomSheet(this.contactIndividualViewModel,
      {Key? key})
      : super(key: key);
  final ContactIndividualViewModel? contactIndividualViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(children: [
            buttonLineInBottonSheet(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container(
                  decoration: BoxDecoration(
                      color: kgray, borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Icon(Icons.search)),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: kDarkGray, fontSize: 14),
                            hintText: 'Tìm kiếm đơn vị...',
                          ),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          onSubmitted: (value) {
                            // contactIndividualViewModel!.rxOrganList.where((item) => item.name!.contains(value));
                            contactIndividualViewModel!
                                .searchInDepartList(value);
                          },
                        ),
                      )
                    ],
                  )),
            ),
            // Tất cả van de trinh
            FilterAllItem( "Tất cả phòng ban", 1,contactIndividualViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //list van de trinh
            SizedBox(
              child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      contactIndividualViewModel!.rxDepartmentList.length,
                  itemBuilder: (context, index) {
                    var item =
                        contactIndividualViewModel!.rxDepartmentList[index];
                    return
                      FilterItem(item.name!,item.id!,index,
                          contactIndividualViewModel!.rxMapDepartmentFilter);
                  })),
            ),
            //bottom butto
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: buttonFilterWhite,
                        child: const Text('Đóng')),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          var departmentId = "";

                          if (contactIndividualViewModel!.mapAllFilter
                              .containsKey(1)) {
                            departmentId = "";
                          } else {
                            contactIndividualViewModel!.rxMapDepartmentFilter
                                .forEach((key, value) {
                              departmentId += value;
                            });
                          }

                          print(departmentId);
                          contactIndividualViewModel!.getContactListByFilter(
                            departmentId,
                          );
                        },
                        style: buttonFilterBlue,
                        child: const Text('Áp dụng')),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}

