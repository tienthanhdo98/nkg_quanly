import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/proflie_model/profile_model.dart';
import 'package:nkg_quanly/ui/profile/e_office/profile_filter_screen.dart';
import 'package:nkg_quanly/ui/profile/profile_viewmodel.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../document_out/document_out_search.dart';
import '../../mission/profile_detail.dart';
import '../../theme/theme_data.dart';
import '../profile_search.dart';

class ProfileEOfficeList extends GetView {
  final String? header;

  final profileViewModel = Get.put(ProfileViewModel());

  ProfileEOfficeList({this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              header!,
              ProfileSearch(
                  profileViewModel
              ),
              context),
          //date table
          headerTableDatePicker(context, profileViewModel),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tất cả hồ sơ trình',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        InkWell(
                          onTap: () {
                            if (menuController.rxShowStatistic.value == true) {
                              menuController.changeStateShowStatistic(false);
                            } else {
                              menuController.changeStateShowStatistic(true);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(children: [
                              Obx(() => (profileViewModel
                                          .rxProfileStatistic.value.hoSoTrinh !=
                                      null)
                                  ? Text(
                                      profileViewModel
                                          .rxProfileStatistic.value.hoSoTrinh
                                          .toString(),
                                      style: textBlueCountTotalStyle)
                                  : const Text("0",
                                      style: textBlueCountTotalStyle)),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: kBlueButton,
                                  ))
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: elevetedButtonWhite,
                          onPressed: () {
                            Get.to(() => ProfileFilterScreen(profileViewModel));
                          },
                          child: const Text(
                            'Bộ lọc',
                            style: TextStyle(color: kVioletButton),
                          ),
                        ))
                  ],
                ),
                Obx(() => (menuController.rxShowStatistic.value == true)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: SizedBox(
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 28,
                                    child: Text("Tạo mới",
                                        style: CustomTextStyle
                                            .robotow400s12TextStyle),
                                  ),
                                  Text(
                                      checkingNullNumberAndConvertToString(
                                          profileViewModel
                                              .rxProfileStatistic.value.taoMoi),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 28,
                                    child: Text("Chờ duyệt",
                                        style: CustomTextStyle
                                            .robotow400s12TextStyle),
                                  ),
                                  Text(
                                      checkingNullNumberAndConvertToString(
                                          profileViewModel.rxProfileStatistic
                                              .value.choDuyet),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 28,
                                    child: Text("Ý kiến đơn vị",
                                        style: CustomTextStyle
                                            .robotow400s12TextStyle),
                                  ),
                                  Text(
                                      checkingNullNumberAndConvertToString(
                                          profileViewModel.rxProfileStatistic
                                              .value.yKienDonVi),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 28,
                                    child: Text("Đã thu hồi",
                                        style: CustomTextStyle
                                            .robotow400s12TextStyle),
                                  ),
                                  Text(
                                      checkingNullNumberAndConvertToString(
                                          profileViewModel.rxProfileStatistic
                                              .value.daThuHoi),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 28,
                                    child: Text("Đã duyệt",
                                        style: CustomTextStyle
                                            .robotow400s12TextStyle),
                                  ),
                                  Text(
                                      checkingNullNumberAndConvertToString(
                                          profileViewModel.rxProfileStatistic
                                              .value.daDuyet),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 28,
                                    child: Text("Chờ tiếp nhận",
                                        style: CustomTextStyle
                                            .robotow400s12TextStyle),
                                  ),
                                  Text(
                                      checkingNullNumberAndConvertToString(
                                          profileViewModel.rxProfileStatistic
                                              .value.choTiepNhan),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 28,
                                    child: Text("Đã tiếp nhận",
                                        style: CustomTextStyle
                                            .robotow400s12TextStyle),
                                  ),
                                  Text(
                                      checkingNullNumberAndConvertToString(
                                          profileViewModel.rxProfileStatistic
                                              .value.daTiepNhan),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 28,
                                    child: Text("Hồ sơ trình chờ phát hành",
                                        style: CustomTextStyle
                                            .robotow400s12TextStyle),
                                  ),
                                  Text(
                                      checkingNullNumberAndConvertToString(
                                          profileViewModel.rxProfileStatistic
                                              .value.hoSoTrinhChoPhatHanh),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink())
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
              child: Obx(() => (profileViewModel.rxProfileItems.isNotEmpty)
                  ? ListView.builder(
                      controller: profileViewModel.controller,
                      itemCount: profileViewModel.rxProfileItems.length,
                      itemBuilder: (context, index) {
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
                                      height: 320,
                                      child: DetailProfileBottomSheet(
                                          index,
                                          profileViewModel
                                              .rxProfileItems[index]));
                                },
                              );
                            },
                            child: ProfileListItem(
                                index, profileViewModel.rxProfileItems[index]));
                      })
                  : const Text("Không có hồ sơ trình nào"))),
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
                          profileViewModel.onSelectDay(DateTime.now());
                          profileViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            profileViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          profileViewModel.postProfileByWeek(
                              strdateFrom, strdateTo);
                          profileViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            profileViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          profileViewModel.postProfileByMonth();
                          profileViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            profileViewModel.selectedBottomButton.value, 2),
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

class ProfileListItem extends StatelessWidget {
  ProfileListItem(this.index, this.docModel);

  final int? index;
  final ProfileItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.name}",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: textCodeStyle(docModel!.code!)),
          signWidget(docModel!),
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
                        style: CustomTextStyle.secondTextStyle),
                    Text(docModel!.handler!)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.deadline!))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày xử lý',
                        style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.dateProcess!))
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

//filter by ui

class DetailProfileBottomSheet extends StatelessWidget {
  const DetailProfileBottomSheet(this.index, this.docModel, {Key? key})
      : super(key: key);
  final int? index;
  final ProfileItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tất cả hồ sơ trình',
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
          const Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.name}",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          signWidget(docModel!),
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
                        style: CustomTextStyle.secondTextStyle),
                    Text(docModel!.handler!)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.deadline!))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày xử lý',
                        style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.dateProcess!))
                  ],
                ),
              ],
            ),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => ProfileDetail(id: 1));
                        },
                        style: buttonFilterBlue,
                        child: const Text('Xem chi tiết')),
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

Widget signWidget(ProfileItems docModel) {
  if (docModel.state == "Đã duyệt") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          docModel.state!,
          style: const TextStyle(color: kGreenSign),
        )
      ],
    );
  } else if (docModel.state == "Chờ duyệt") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: kOrangeSign))
      ],
    );
  } else if (docModel.state == "Đã thu hồi") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: kRedPriority))
      ],
    );
  } else if (docModel.state == "Đã tiếp nhận") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_done_black.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: Colors.black))
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: Colors.black))
      ],
    );
  }
}
