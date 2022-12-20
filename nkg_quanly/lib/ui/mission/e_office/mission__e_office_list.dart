import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../../model/misstion/mission_detail.dart';
import '../../search_screen.dart';
import '../../theme/theme_data.dart';
import '../mission_detail.dart';
import '../mission_viewmodel.dart';
import 'filter_mission_screen.dart';

class MissionEOfficeList extends GetView {
  final missionViewModel = Get.put(MissionViewModel());

  MissionEOfficeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    missionViewModel.getDataInScreen();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              "Nhiệm vụ",
              SearchScreen(
                hintText: 'Nhập mã nhiệm vụ, tên nhiệm vụ',
                typeScreen: type_mission,
              ),
              context),
          //date table
          Obx(() =>(missionViewModel.rxDepartmentSelected.value != "" || missionViewModel.rxLevelSelected.value != "" || missionViewModel.rxStatusSelected.value != "") ? Padding(
              padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: kDarkGray, style: BorderStyle.solid, width: 1),
                ),
                child: Padding(
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
                        if(missionViewModel.rxDepartmentSelected.value != "")Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Đơn vị ban hành',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                    missionViewModel.rxDepartmentSelected.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5))
                          ],
                        ),
                        if(missionViewModel.rxLevelSelected.value != "")Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mức độ',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Obx(() => Text(
                                    missionViewModel.rxLevelSelected.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5)))
                          ],
                        ),
                        if(missionViewModel.rxStatusSelected.value != "")Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Trạng thái',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child:  Obx(() => Text(
                                    missionViewModel.rxStatusSelected.value,
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
              ),
            ) : const SizedBox.shrink(),
          ),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tất cả nhiệm vụ',
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
                              Obx(() => (missionViewModel
                                          .rxMissionStatistic.value.tong !=
                                      null)
                                  ? Text(
                                      missionViewModel
                                          .rxMissionStatistic.value.tong
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
                    Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: elevetedButtonWhite,
                          onPressed: () {
                            Get.to(() => FilterMissionScreen(missionViewModel));
                          },
                          child: const Text(
                            'Bộ lọc',
                            style: TextStyle(color: kVioletButton),
                          ),
                        )),
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
                                  const Text('Chưa xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                      missionViewModel
                                          .rxMissionStatistic.value.chuaXuLy
                                          .toString(),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đang thực hiện',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatistic.value.dangThucHien
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã hủy',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatistic.value.daHuy
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã tạm dừng',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatistic.value.daTamDung
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Quá hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatistic.value.quaHan
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Trong hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatistic.value.trongHan
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink()),
                //select Date box
                fromDateToDateWidget(missionViewModel,(){
                  String strDateFrom =
                      menuController.rxFromDateWithoutWeekDayToApi.value;
                  String strDateTo =
                      menuController.rxToDateWithoutWeekDayToApi.value;
                  if(strDateFrom != "" && strDateTo != "") {
                    missionViewModel.getMissionByFromAndToDate(
                        strDateFrom, strDateTo);
                  }
                  else
                  {
                    missionViewModel.getMissionDefault(true);
                  }
                })
                //end select Date box
              ],
            ),
          ),

          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => (missionViewModel.rxMissionItem.isNotEmpty)
                  ? ListView.builder(
                      controller: missionViewModel.controller,
                      itemCount: missionViewModel.rxMissionItem.length,
                      itemBuilder: (context, index) {
                        var item = missionViewModel.rxMissionItem[index];
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
                                      child: DetailMissionBottomSheet(
                                           item));
                                },
                              );
                            },
                            child: MissionListItem(item));
                      })
                  : noData())),
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
                          String strDateFrom = formatDateToString(dateNow);
                          String strDateTo = formatDateToString(dateNow);
                          missionViewModel.getMissionByFromAndToDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          missionViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            missionViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {

                          String strDateFrom = formatDateToString(findFirstDateOfTheWeek(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheWeek(dateNow));

                          missionViewModel.getMissionByFromAndToDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          missionViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            missionViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {

                          String strDateFrom = formatDateToString(findFirstDateOfTheMonth(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheMonth(dateNow));

                          missionViewModel.getMissionByFromAndToDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;

                          missionViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            missionViewModel.selectedBottomButton.value, 2),
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

class MissionListItem extends StatelessWidget {
  const MissionListItem(this.docModel, {Key? key}) : super(key: key);


  final MissionItem? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: sheetButtonDetailTitleItem(docModel!.name!,context),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: textCodeStyle(docModel!.code!)),
          signWidgetMission(docModel!),
          SizedBox(
            height: 70,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              childAspectRatio: 3.5 / 2,
              crossAxisCount: 3,
              children: <Widget>[
                sheetDetailBottemItem(
                    'Đơn vị xử lý', docModel!.organizationName!, context),
                sheetDetailBottemItem(
                    'Hạn xử lý', formatDate(docModel!.deadline!), context),
                sheetDetailBottemItem(
                    'Tình trạng xử lý', docModel!.status!, context),
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

Widget signWidgetMission(MissionItem docModel) {
  if (docModel.state == "Đang thực hiện") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(
          docModel.state!,
          style: const TextStyle(color: kGreenSign, fontSize: 12),
        )
      ],
    );
  } else if (docModel.state == "Chưa xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.state!,
            style: const TextStyle(color: kOrangeSign, fontSize: 12))
      ],
    );
  } else if (docModel.state == "Đã hủy") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.state!,
            style: const TextStyle(color: kRedPriority, fontSize: 12))
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
        Text(docModel.state!,
            style: const TextStyle(color: Colors.black, fontSize: 12))
      ],
    );
  }
}

class DetailMissionBottomSheet extends StatelessWidget {
  const DetailMissionBottomSheet( this.docModel, {Key? key})
      : super(key: key);
  final MissionItem? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin nhiệm vụ',
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
          Row(
            children: [
              Expanded(
                child: sheetButtonDetailTitleItem(docModel!.name!,context),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: textCodeStyle(docModel!.code!)),
          signWidgetMission(docModel!),
          SizedBox(
            height: 110,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              childAspectRatio: 3.5 / 2,
              crossAxisCount: 3,
              children: <Widget>[
                sheetDetailBottemItem(
                    'Đơn vị xử lý', docModel!.organizationName!, context),
                sheetDetailBottemItem(
                    'Hạn xử lý', formatDate(docModel!.deadline!), context),
                sheetDetailBottemItem(
                    'Tình trạng xử lý', docModel!.status!, context),
                sheetDetailBottemItem('Ngày khởi tạo',
                    formatDate(docModel!.innitiatedDate!), context),
              ],
            ),
          ),
          const Spacer(),
          Align(
            child: Row(
              children: [
                sheetButtonDetailButtonClose(),
                sheetButtonDetailButtonOk(() async {
                  Get.back();
                  Get.to(() =>
                      MissionDetail(id: int.parse(docModel!.id!)));
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterMissionBottomSheet extends StatelessWidget {
  const FilterMissionBottomSheet(this.missionViewModel, {Key? key})
      : super(key: key);
  final MissionViewModel? missionViewModel;

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
                      'Tất cả nhiệm vụ',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() => (missionViewModel!.mapAllFilter.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(false, 0);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(true, 0);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            // tat ca muc do
            const Divider(
              thickness: 1,
              color: kBlueButton,
            ),
            //tat ca don vi
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả đơn vị ban hành',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (missionViewModel!.mapAllFilter.containsKey(1))
                      ? InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(false, 1);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(true, 1);
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
                  itemCount: missionViewModel!.rxListDepartmentFilter.length,
                  itemBuilder: (context, index) {
                    var item = missionViewModel!.rxListDepartmentFilter[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (missionViewModel!.mapDepartmentFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxDepartment(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxDepartment(
                                            true, index, "$item;");
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
            // Tất cả van de trinh
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả mức độ',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (missionViewModel!.mapAllFilter.containsKey(2))
                      ? InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(false, 2);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(true, 2);
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
            //list van de trinh
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: listLevel.length,
                  itemBuilder: (context, index) {
                    var item = listLevel[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (missionViewModel!.mapLevelFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxLevel(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxLevel(
                                            true, index, "$item;");
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
            // Tất cả loai phieu trinh
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
                  Obx(() => (missionViewModel!.mapAllFilter.containsKey(3))
                      ? InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(false, 3);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(true, 3);
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
                  itemCount: listMissionState.length,
                  itemBuilder: (context, index) {
                    var item = listMissionState[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (missionViewModel!.mapStatusFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxStatus(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxStatus(
                                            true, index, "$item;");
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
                            var status = "";
                            var level = "";
                            var department = "";
                            if (missionViewModel!.mapAllFilter.containsKey(0)) {
                              missionViewModel!.postMissionByFilter(
                                status,
                                level,
                                department,
                              );
                            } else {
                              if (missionViewModel!.mapAllFilter
                                  .containsKey(1)) {
                                department = "";
                              } else {
                                missionViewModel!.mapDepartmentFilter
                                    .forEach((key, value) {
                                  department += value;
                                });
                              }
                              if (missionViewModel!.mapAllFilter
                                  .containsKey(2)) {
                                level = "";
                              } else {
                                missionViewModel!.mapLevelFilter
                                    .forEach((key, value) {
                                  level += value;
                                });
                              }
                              if (missionViewModel!.mapAllFilter
                                  .containsKey(3)) {
                                status = "";
                              } else {
                                missionViewModel!.mapStatusFilter
                                    .forEach((key, value) {
                                  status += value;
                                });
                              }
                            }
                            missionViewModel!
                                .postMissionByFilter(status, level, department);
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
