import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/profile_work/profile_work_model.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../mission/e_office/filter_mission_screen.dart';
import '../../search_screen.dart';
import '../../theme/theme_data.dart';
import '../profile_work_viewmodel.dart';

class ProfileWorkEOfficeList extends GetView {
  final String? header;

  final profileWorkViewModel = Get.put(ProfileWorkViewModel());

  ProfileWorkEOfficeList({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              header!,  SearchScreen(
            hintText: 'Nhập mã hồ sơ',
            typeScreen: type_profile_work,
          ),context),
          //date table
          Padding(
            padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
            child: Container(

              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: kDarkGray, style: BorderStyle.solid, width: 1),
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                            "Thống kê",
                            style: Theme.of(context).textTheme.headline2,
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: elevetedButtonWhite,
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
                                      height: 560,
                                      child: FilterProfileWorkEOfficeBottomSheet(
                                          profileWorkViewModel));
                                },
                              );
                            },
                            child: const Text(
                              'Bộ lọc',
                              style: TextStyle(color: kVioletButton),
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: SizedBox(
                    height: 60,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 0,
                      crossAxisCount: 3,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Trạng thái',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Obx(() => Text(
                                    profileWorkViewModel.rxStatusSelected.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5)))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
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
                          'Tất cả hồ sơ công việc',
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
                              Obx(() => (profileWorkViewModel
                                          .rxProfileWorkStatistic.value.tong !=
                                      null)
                                  ? Text(
                                      profileWorkViewModel
                                          .rxProfileWorkStatistic.value.tong
                                          .toString(),
                                      style: textBlueCountTotalStyle)
                                  : const Text("")),
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

                  ],
                ),
                Obx(() => (menuController.rxShowStatistic.value == true)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: SizedBox(
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 0,
                            crossAxisCount: 3,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Tạo mới',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                      profileWorkViewModel
                                          .rxProfileWorkStatistic.value.taoMoi
                                          .toString(),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã thu hồi',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    profileWorkViewModel
                                        .rxProfileWorkStatistic.value.daThuHoi
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đang xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    profileWorkViewModel
                                        .rxProfileWorkStatistic.value.dangXuLy
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã hoàn thành',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    profileWorkViewModel.rxProfileWorkStatistic
                                        .value.daHoanThanh
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Quá hạn xủ lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    profileWorkViewModel
                                        .rxProfileWorkStatistic.value.quaHan
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Trong hạn xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    profileWorkViewModel.rxProfileWorkStatistic
                                        .value.trongHanXuLy
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink())
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
            child: Obx(() => (profileWorkViewModel.rxProfileWorkList.isNotEmpty)
                ? ListView.builder(
                    itemCount: profileWorkViewModel.rxProfileWorkList.length,
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
                                    height: 340,
                                    child: DetailProfileWorkBottomSheet(
                                        index,
                                        profileWorkViewModel
                                            .rxProfileWorkList[index]));
                              },
                            );
                          },
                          child: ProfileWorkItem(index,
                              profileWorkViewModel.rxProfileWorkList[index]));
                    })
                : const Text("Không có hồ sơ trình nào")),
          ),
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
                          profileWorkViewModel.onSelectDay(DateTime.now());
                          profileWorkViewModel.switchBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            profileWorkViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          profileWorkViewModel.postProfileWorkByWeek(
                              strdateFrom, strdateTo);
                          profileWorkViewModel.switchBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            profileWorkViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          profileWorkViewModel.postProfileWorkByMonth();
                          profileWorkViewModel.switchBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            profileWorkViewModel.selectedBottomButton.value, 2),
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

class ProfileWorkItem extends StatelessWidget {
  const ProfileWorkItem(this.index, this.docModel, {Key? key}) : super(key: key);

  final int? index;
  final ProfileWorkListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${index! + 1}. ${docModel!.name}",
            style: Theme.of(context).textTheme.headline3,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: textCodeStyle(docModel!.code!)),
          signWidgetProfileWork(docModel!),
          SizedBox(
            height: 60,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                sheetDetailBottemItem(
                    'Người xử lý', docModel!.handler!, context),
                sheetDetailBottemItem(
                    'Thời hạn', formatDate(docModel!.endDate!), context),
                sheetDetailBottemItem(
                    'Ngày xử lý', formatDate(docModel!.toDate!), context),
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

Widget signWidgetProfileWork(ProfileWorkListItems docModel) {
  if (docModel.status == "Đã hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(
          docModel.status!,
          style: const TextStyle(color: kGreenSign, fontSize: 12),
        )
      ],
    );
  } else if (docModel.status == "Đang xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.status!,
            style: const TextStyle(color: kOrangeSign, fontSize: 12))
      ],
    );
  } else if (docModel.status == "Quá hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.status!,
            style: const TextStyle(color: kRedPriority, fontSize: 12))
      ],
    );
  } else if (docModel.status == "Tạo mới") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_add.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.status!,
            style: const TextStyle(color: kGreenSign, fontSize: 12))
      ],
    );
  } else if (docModel.status == "Đã thu hồi") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_outdate.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.status!,
            style: const TextStyle(color: Colors.black, fontSize: 12))
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
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.status!,
            style: const TextStyle(color: Colors.black, fontSize: 12))
      ],
    );
  }
}

class DetailProfileWorkBottomSheet extends StatelessWidget {
  const DetailProfileWorkBottomSheet(this.index, this.docModel, {Key? key})
      : super(key: key);
  final int? index;
  final ProfileWorkListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin hồ sơ công việc',
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
          sheetButtonDetailTitleItem(docModel!.name!,context),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: textCodeStyle(docModel!.code!)),
          signWidgetProfileWork(docModel!),
          SizedBox(
            height: 110,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              childAspectRatio: 3.5 / 2,
              crossAxisCount: 3,
              children: <Widget>[
                sheetDetailBottemItem(
                    'Người xử lý', docModel!.handler!, context),
                sheetDetailBottemItem(
                    'Thời hạn', formatDate(docModel!.endDate!), context),
                sheetDetailBottemItem(
                    'Ngày xử lý', formatDate(docModel!.toDate!), context),
                sheetDetailBottemItem('Ngày khởi tạo',
                    formatDate(docModel!.innitiatedDate!), context),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              sheetButtonDetailButtonClose(),
              sheetButtonDetailButtonOk(() async {

              })
            ],
          )
        ],
      ),
    );
  }
}

class FilterProfileWorkEOfficeBottomSheet extends StatelessWidget {
  const FilterProfileWorkEOfficeBottomSheet(this.profileWorkViewModel,
      {Key? key})
      : super(key: key);

  final ProfileWorkViewModel? profileWorkViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          // Tất cả trang thai
          FilterAllItem(
              "Tất cả trạng thái", 3, profileWorkViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 360,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listProfileWorkStatus.length,
                itemBuilder: (context, index) {
                  var item = listProfileWorkStatus[index];
                  return FilterItem(
                      item, item, index, profileWorkViewModel!.mapStatus);
                }),
          ),

          //bottom button
          Spacer(),
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
                        if (profileWorkViewModel!.mapAllFilter
                            .containsKey(3)) {
                          changeValueSelectedFilter(
                              profileWorkViewModel!.rxStatusSelected,
                              "Tất cả trạng thái");
                        } else {
                          var status = "";
                          var statusName = "";
                          profileWorkViewModel!.mapStatus
                              .forEach((key, value) {
                            status += value;
                          });
                          var listId = status.split(";");
                          for (var id in listId) {
                            for (var item
                            in listProfileWorkStatus) {
                              if (item == id) {
                                statusName += "$item;";
                              }
                            }
                          }
                          if (statusName != "") {
                            changeValueSelectedFilter(
                                profileWorkViewModel!.rxStatusSelected,
                                statusName.substring(0, statusName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profileWorkViewModel!.rxStatusSelected, "");
                          }
                        }
                        ///
                        var status = "";
                        if (profileWorkViewModel!.mapAllFilter
                            .containsKey(0)) {
                          profileWorkViewModel!.postProfileWorkByFilter(
                            status,
                          );
                        } else {
                          if (profileWorkViewModel!.mapAllFilter
                              .containsKey(3)) {
                            status = "";
                          } else {
                            profileWorkViewModel!.mapStatus
                                .forEach((key, value) {
                              status += value;
                            });
                          }
                        }
                        print(status);
                        profileWorkViewModel!
                            .postProfileWorkByFilter(status);
                        Get.back();
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
