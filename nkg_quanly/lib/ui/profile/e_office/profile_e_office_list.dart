import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/model/proflie_model/profile_model.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:nkg_quanly/ui/profile/e_office/profile_filter_screen.dart';
import 'package:nkg_quanly/ui/profile/profile_viewmodel.dart';

import '../../../const.dart';
import '../../../const/style.dart';
import '../../../const/ultils.dart';
import '../../../const/widget.dart';
import '../../document_out/document_out_search.dart';
import '../../misstion/mission_detail.dart';
import '../../misstion/profile_detail.dart';
import '../../theme/theme_data.dart';

class ProfileEOfficeList extends GetView {
  final String? header;

  final MenuController menuController = Get.put(MenuController());
  final profileViewModel = Get.put(ProfileViewModel());

  ProfileEOfficeList({this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSeatch(
              header!,
              DocumenOutSearch(
                header: header,
              ),
              context),
          //date table
          headerTableDate(
              Obx(() => TableCalendar(
                  locale: 'vi_VN',
                  headerVisible: false,
                  calendarFormat: profileViewModel.rxCalendarFormat.value,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: profileViewModel.rxSelectedDay.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(profileViewModel.rxSelectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    if (!isSameDay(
                        profileViewModel.rxSelectedDay.value, selectedDay)) {
                      profileViewModel.onSelectDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (profileViewModel.rxCalendarFormat.value != format) {
                      // Call `setState()` when updating calendar format
                      profileViewModel.rxCalendarFormat.value = format;
                    }
                  })),
              Center(
                  child: InkWell(
                onTap: () {
                  if (profileViewModel.rxCalendarFormat.value !=
                      CalendarFormat.month) {
                    profileViewModel.switchFormat(CalendarFormat.month);
                  } else {
                    profileViewModel.switchFormat(CalendarFormat.week);
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Image.asset(
                      "assets/icons/ic_showmore.png",
                      height: 15,
                      width: 80,
                    )),
              )),
              context),
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
                              .rxProfileStatistic.value.hoSoTrinh != null) ?Text(
                                  profileViewModel
                                      .rxProfileStatistic.value.hoSoTrinh
                                      .toString(),
                                  style: textBlueCountTotalStyle) : const Text("0")),
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
                                      profileViewModel
                                          .rxProfileStatistic.value.taoMoi
                                          .toString(),
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
                                      profileViewModel
                                          .rxProfileStatistic.value.choDuyet
                                          .toString(),
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
                                      profileViewModel
                                          .rxProfileStatistic.value.yKienDonVi
                                          .toString(),
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
                                      profileViewModel
                                          .rxProfileStatistic.value.daThuHoi
                                          .toString(),
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
                                      profileViewModel
                                          .rxProfileStatistic.value.daDuyet
                                          .toString(),
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
                                      profileViewModel
                                          .rxProfileStatistic.value.choTiepNhan
                                          .toString(),
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
                                      profileViewModel
                                          .rxProfileStatistic.value.daTiepNhan
                                          .toString(),
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
                                      profileViewModel.rxProfileStatistic.value
                                          .hoSoTrinhChoPhatHanh
                                          .toString(),
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
                  : const Text("Hôm nay không có hồ sơ trình nào"))),
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
                          profileViewModel.rxSelectedDay.value = DateTime.now();
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
              Text(
                "${index! + 1}. ${docModel!.name}",
                style: Theme.of(context).textTheme.headline2,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: priorityWidget(docModel!))),
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
              Text(
                "${index! + 1}. ${docModel!.name}",
                style: Theme.of(context).textTheme.headline2,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: priorityWidget(docModel!))),
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
