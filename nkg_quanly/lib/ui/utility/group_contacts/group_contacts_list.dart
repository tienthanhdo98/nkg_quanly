import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/utility/group_contacts/update_new_contact_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../../model/MenuByUserModel.dart';
import '../../../model/contact_model/contact_model.dart';
import '../../theme/theme_data.dart';
import 'add_new_contact_screen.dart';
import 'contact_organization_viewmodel.dart';
import 'organ_contact_search.dart';

class GroupContactsList extends GetView {
  final contactOrganizationViewModel = Get.put(ContactOrganizationViewModel());
  GroupContactsList({Key? key, this.listMenuPermissions}) : super(key: key);

  List<MenuPermissions>? listMenuPermissions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              "Danh bạ điện tử tổ chức",
              OrganContactsSearch(
                  contactOrganizationViewModel,
                  listMenuPermissions
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
                        contactOrganizationViewModel.getOrganList();
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
                                child: FilterContactOrganBottomSheet(
                                    contactOrganizationViewModel));
                          },
                        );
                      },
                      child: const Text(
                        'Bộ lọc',
                        style: TextStyle(color: kVioletButton),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    if(checkPermission(listMenuPermissions!, "Add"))ElevatedButton(
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
              child: Obx(() => (contactOrganizationViewModel.rxContactListItems.isNotEmpty) ?ListView.builder(
                  controller: contactOrganizationViewModel.controller,
                  itemCount:
                      contactOrganizationViewModel.rxContactListItems.length,
                  itemBuilder: (context, index) {
                    var item = contactOrganizationViewModel
                        .rxContactListItems[index];
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                                height: 400,
                                child: DetailOrganContactBottomSheet(
                                    item, contactOrganizationViewModel,listMenuPermissions,));
                          },
                        );
                      },
                      child: GroupContactsItem(
                          index,
                          item,
                          contactOrganizationViewModel, listMenuPermissions),
                    );
                  }): loadingIcon())),
        ],
      )),
    );
  }
}

class GroupContactsItem extends StatelessWidget {
  GroupContactsItem(this.index, this.docModel, this.contactOrganizationViewModel, this.listMenuPermissions);

  final int? index;
  final ContactListItems? docModel;
  final ContactOrganizationViewModel? contactOrganizationViewModel;
  List<MenuPermissions>? listMenuPermissions;

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
                            docModel, contactOrganizationViewModel,
                              listMenuPermissions
                          ));
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
                    const Text('Tổ chức',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                          findNameOfOrganById(
                              contactOrganizationViewModel!.rxOrganList,
                              checkingStringNull(docModel!.organizationId)),
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
  ContactsActionBottomSheet(this.docModel, this.contactOrganizationViewModel, this.listMenuPermissions);

  final ContactListItems? docModel;
  final ContactOrganizationViewModel? contactOrganizationViewModel;
  final List<MenuPermissions>? listMenuPermissions;

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
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: 400,
                          child: DetailOrganContactBottomSheet(
                              docModel, contactOrganizationViewModel,listMenuPermissions ));
                    },
                  );
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
              if(checkPermission(listMenuPermissions!, "Edit"))InkWell(
                onTap: () {
                  Get.back();
                  Get.to(() => UpdateNewContactScreen(docModel!));
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
           if(checkPermission(listMenuPermissions!, "Delete"))InkWell(
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
                            contactOrganizationViewModel:
                                contactOrganizationViewModel,
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
  final ContactOrganizationViewModel? contactOrganizationViewModel;

  const DeleteContactSheetBottomSheet(
      {Key? key, this.docModel, this.contactOrganizationViewModel})
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
          const Padding(
              padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
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
                            contactOrganizationViewModel!
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

class FilterContactOrganBottomSheet extends StatelessWidget {
  const FilterContactOrganBottomSheet(this.contactOrganizationViewModel,
      {Key? key})
      : super(key: key);
  final ContactOrganizationViewModel? contactOrganizationViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                          contactOrganizationViewModel!
                              .searchInOrganList(value);
                        },
                      ),
                    )
                  ],
                )),
          ),
          // Tất cả to chuc
          FilterAllItem(
            "Tất cả tổ chức",
            1,
            contactOrganizationViewModel!.mapAllFilter,
            contactOrganizationViewModel!.rxMapOrganFilter,
            contactOrganizationViewModel!.rxOrganList,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          //list van de trinh
          SizedBox(
            height: 250,
            child: Obx(() => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: contactOrganizationViewModel!.rxOrganList.length,
                itemBuilder: (context, index) {
                  var item = contactOrganizationViewModel!.rxOrganList[index];
                  return  FilterItem(item.name!,item.id!,index,
                      contactOrganizationViewModel!.rxMapOrganFilter);
                })),
          ),
          //bottom butto
          const Spacer(),
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
                        var organizationId = "";

                        if (contactOrganizationViewModel!.mapAllFilter
                            .containsKey(1)) {
                          organizationId = "";
                        } else {
                          contactOrganizationViewModel!.rxMapOrganFilter
                              .forEach((key, value) {
                            organizationId += value;
                          });
                        }

                        print(organizationId);
                        contactOrganizationViewModel!.getContactListByFilter(
                          organizationId,
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
    );
  }
}

class DetailOrganContactBottomSheet extends StatelessWidget {
  const DetailOrganContactBottomSheet(
      this.docModel, this.contactOrganizationViewModel,this.listMenuPermissions,
      {Key? key})
      : super(key: key);
  final ContactListItems? docModel;
  final ContactOrganizationViewModel? contactOrganizationViewModel;
  final List<MenuPermissions>? listMenuPermissions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin cán bộ',
            style: TextStyle(
                color: kBlueButton,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 16),
          ),
          const Divider(
            thickness: 1,
            color: kBlueButton,
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Text(
              "1. ${docModel!.employeeName!}",
              style: Theme.of(context).textTheme.headline3,
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
                    const Text('Tổ chức',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                          findNameOfOrganById(
                              contactOrganizationViewModel!.rxOrganList,
                              checkingStringNull(docModel!.organizationId)),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email', style: CustomTextStyle.grayColorTextStyle),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(docModel!.email!,
                      style: Theme.of(context).textTheme.headline4))
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Địa chỉ', style: CustomTextStyle.grayColorTextStyle),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(docModel!.address!,
                      style: Theme.of(context).textTheme.headline4))
            ],
          ),
          const Spacer(),
          Align(
            child: Row(
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
                if(checkPermission(listMenuPermissions!, "Edit"))
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => UpdateNewContactScreen(docModel!));
                        },
                        style: buttonFilterBlue,
                        child: const Text('Chỉnh sửa')),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
