import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/viewmodel/date_picker_controller.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_proc_detail.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_proc_search.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../../model/profile_procedure_model/profile_procedure_model.dart';

class ProfilesProcedureList extends GetView {
  final String? header;

  final profilesProcedureController = Get.put(ProfilesProcedureViewModel());

  ProfilesProcedureList({this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSeatch(
              header!,
              ProfileProcSearch(
              ),
              context),
          headerTableDatePicker(context, profilesProcedureController),
          //date table
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Text(
                  'Tất cả thủ tục hành chính',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return kVioletBg;
                                } else {
                                  return kWhite;
                                } // Use the component's default.
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: const BorderSide(
                                        color: kVioletButton)))),
                        onPressed: () {
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
                                  height: 600,
                                  child: FilterProfileProcBottomSheet(
                                      profilesProcedureController));
                            },
                          );
                        },
                        child: const Text(
                          'Bộ lọc',
                          style: TextStyle(color: kVioletButton),
                        ),
                      )),
                ),
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => (profilesProcedureController
                      .rxProfileProcedureListItems.isNotEmpty)
                  ? ListView.builder(
                       shrinkWrap: true,
                      controller: profilesProcedureController.controller,
                      itemCount: profilesProcedureController
                          .rxProfileProcedureListItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Get.to(() => ProfileProcDetail(
                                  id: profilesProcedureController
                                      .rxProfileProcedureListItems[index]
                                      .maSoBienNhan!));
                            },
                            child: ProfileProcItem(
                                index,
                                profilesProcedureController
                                    .rxProfileProcedureListItems[index]));
                      })
                  : const SizedBox.shrink())),
          //bottom
          Obx(() => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                        top:
                            BorderSide(color: Theme.of(context).dividerColor))),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            menuController.rxSelectedDay.value = DateTime.now();
                            profilesProcedureController
                                .onSelectDay(DateTime.now());
                            profilesProcedureController.swtichBottomButton(0);
                          },
                          child: bottomDateButton(
                              "Ngày",
                              profilesProcedureController
                                  .selectedBottomButton.value,
                              0)),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          profilesProcedureController.postProfileProcByWeek(
                              strdateFrom, strdateTo);
                          profilesProcedureController.swtichBottomButton(1);
                        },
                        child: bottomDateButton(
                            "Tuần",
                            profilesProcedureController
                                .selectedBottomButton.value,
                            1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          profilesProcedureController.postProfileProcByMonth();
                          profilesProcedureController.swtichBottomButton(2);
                        },
                        child: bottomDateButton(
                            "Tháng",
                            profilesProcedureController
                                .selectedBottomButton.value,
                            2),
                      ),
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}

class ProfileProcItem extends StatelessWidget {
  ProfileProcItem(this.index, this.docModel);

  final int? index;
  final ProfileProcedureListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.tenThuTucHanhChinh!}",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityProfileProcWidget(docModel!)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0 , 5),
              child: textCodeStyle(docModel!.maSoBienNhan!)),
          signProfileProcWidget(docModel!),
          SizedBox(
            height: 70,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Người xử lý',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.chuHoSo!,
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.ngayHenTraKetQua!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày xử lý',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.ngayNhanHoSo!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

Widget priorityProfileProcWidget(ProfileProcedureListItems docModel) {
  switch (docModel.level) {
    case "Cao":
      {
        return Container(
            decoration: BoxDecoration(
              color: kRedPriority,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text('Cao',
                    style: TextStyle(color: kWhite, fontSize: 14))));
      }
    case "Thấp":
      {
        return Container(
            decoration: BoxDecoration(
              color: kGrayPriority,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text('Thấp',
                    style: TextStyle(color: kWhite, fontSize: 14))));
      }
    default:
      {
        return Container(
            decoration: BoxDecoration(
              color: kBluePriority,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Trung bình',
                  style: TextStyle(color: kWhite, fontSize: 14),
                )));
      }
  }
}

class FilterProfileProcBottomSheet extends StatelessWidget {
  const FilterProfileProcBottomSheet(this.profilesProcedureController,
      {Key? key})
      : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tatca
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả thủ tục hành chính',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() =>
                      (profilesProcedureController!.mapAllFilter.containsKey(0))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(false, 0);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(true, 0);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_unactive.png',
                                width: 30,
                                height: 30,
                              )))
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: kBlueButton,
            ),
            // Tất cơ quan
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả cơ quan',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                      (profilesProcedureController!.mapAllFilter.containsKey(1))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(false, 1);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(true, 1);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_unactive.png',
                                width: 30,
                                height: 30,
                              )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      profilesProcedureController!.rxListAgenciesList.length,
                  itemBuilder: (context, index) {
                    var item =
                        profilesProcedureController!.rxListAgenciesList[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.ten!,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (profilesProcedureController!
                                      .mapAgenciesFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxAgencies(
                                                false, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxAgencies(
                                                true, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_unactive.png',
                                        width: 30,
                                        height: 30,
                                      )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
                  }),
            ),
            // Tất cả lĩnh vực
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả lĩnh vực',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                      (profilesProcedureController!.mapAllFilter.containsKey(2))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(false, 2);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(true, 2);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_unactive.png',
                                width: 30,
                                height: 30,
                              )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: profilesProcedureController!.rxListBranch.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureController!.rxListBranch[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.tenLinhVuc!,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (profilesProcedureController!
                                      .mapBranchFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxBranch(
                                                false, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxBranch(
                                                true, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_unactive.png',
                                        width: 30,
                                        height: 30,
                                      )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
                  }),
            ),
            // Tất cả trang thai
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả trạng thái',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                      (profilesProcedureController!.mapAllFilter.containsKey(3))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(false, 3);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(true, 3);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_unactive.png',
                                width: 30,
                                height: 30,
                              )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: profilesProcedureController!.rxListStatus.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureController!.rxListStatus[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.trangThai!,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (profilesProcedureController!
                                      .mapStatusFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxStatus(
                                                false, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxStatus(
                                                true, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_unactive.png',
                                        width: 30,
                                        height: 30,
                                      )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
                  }),
            ),
            // Tất cả thủ tục
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả thủ tục',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                      (profilesProcedureController!.mapAllFilter.containsKey(4))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(false, 4);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(true, 4);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_unactive.png',
                                width: 30,
                                height: 30,
                              )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      profilesProcedureController!.rxListProcedure.length,
                  itemBuilder: (context, index) {
                    var item =
                        profilesProcedureController!.rxListProcedure[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.ten!,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (profilesProcedureController!
                                      .mapProcedureFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxProcedure(
                                                false, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxProcedure(
                                                true, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_unactive.png',
                                        width: 30,
                                        height: 30,
                                      )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
                  }),
            ),
            // Tất cả nhóm thủ tục
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả nhóm thủ tục',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                      (profilesProcedureController!.mapAllFilter.containsKey(5))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(false, 5);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureController!
                                    .checkboxFilterAll(true, 5);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_unactive.png',
                                width: 30,
                                height: 30,
                              )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      profilesProcedureController!.rxListGroupProcedure.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureController!
                        .rxListGroupProcedure[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.ten!,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (profilesProcedureController!
                                      .mapGroupProcedureFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxGroupProcedure(
                                                false, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        profilesProcedureController!
                                            .checkboxGroupProcedure(
                                                true, index, "${item.id};");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_unactive.png',
                                        width: 30,
                                        height: 30,
                                      )))
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              thickness: 1,
                              color: kgray,
                            )),
                      ],
                    );
                  }),
            ),
            //bottom button
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            var agencies = "";
                            var branch = "";
                            var status = "";
                            var procedure = "";
                            var groupProcedure = "";
                            if (profilesProcedureController!.mapAllFilter
                                .containsKey(0)) {
                              profilesProcedureController!
                                  .postProfileProcByFilter(agencies, branch,
                                      status, procedure, groupProcedure);
                            } else {
                              agencies = getStringFilterFromMap(
                                  profilesProcedureController!.mapAllFilter,
                                  profilesProcedureController!
                                      .mapAgenciesFilter,
                                  1);
                              branch = getStringFilterFromMap(
                                  profilesProcedureController!.mapAllFilter,
                                  profilesProcedureController!.mapBranchFilter,
                                  2);
                              status = getStringFilterFromMap(
                                  profilesProcedureController!.mapAllFilter,
                                  profilesProcedureController!.mapStatusFilter,
                                  3);
                              procedure = getStringFilterFromMap(
                                  profilesProcedureController!.mapAllFilter,
                                  profilesProcedureController!
                                      .mapProcedureFilter,
                                  4);
                              groupProcedure = getStringFilterFromMap(
                                  profilesProcedureController!.mapAllFilter,
                                  profilesProcedureController!
                                      .mapGroupProcedureFilter,
                                  5);

                              print(agencies);
                              print(branch);
                              print(status);
                              print(procedure);
                              print(groupProcedure);
                              profilesProcedureController!
                                  .postProfileProcByFilter(agencies, branch,
                                      status, procedure, groupProcedure);
                            }
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

Widget signProfileProcWidget(ProfileProcedureListItems docModel) {
  if (docModel.status == "Hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          docModel.status!,
          style: const TextStyle(color: kGreenSign),
        )
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.status!, style: const TextStyle(color: kOrangeSign))
      ],
    );
  }
}
