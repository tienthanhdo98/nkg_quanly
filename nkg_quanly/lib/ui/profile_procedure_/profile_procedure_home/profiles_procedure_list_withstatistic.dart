
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile__proceduce_filter_screen.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_home_detail.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';
import 'package:nkg_quanly/ui/search_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../../model/profile_procedure_model/profile_procedure_model.dart';
import '../../theme/theme_data.dart';


class ProfilesProcedureListWithStatistic extends GetView {

  final profilesProcedureViewModel = Get.put(ProfilesProcedureViewModel());

  ProfilesProcedureListWithStatistic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              "Danh sách hồ sơ hành chính",
              SearchScreen(
                hintText: 'Nhập mã hồ sơ, tên hồ sơ',
                typeScreen: type_profile_procedure,
              ),
              context),
          //
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
                              Get.to(() => ProfileProceduceFilterScreen(profilesProcedureViewModel));
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
                    height: 140,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      childAspectRatio: 3/2,
                      crossAxisCount: 3,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Cơ quan',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Obx(() => Text(
                                    profilesProcedureViewModel.rxSelectedAgencies.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5)))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Lĩnh vực',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Obx(() => Text(
                                    profilesProcedureViewModel.rxSelectedBranch.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5)))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Trạng thái',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child:  Obx(() => Text(
                                    profilesProcedureViewModel.rxSelectedStatus.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5)))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Thủ tục',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child:  Obx(() => Text(
                                    profilesProcedureViewModel.rxSelectedProcedure.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5)))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Nhóm thủ tục',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child:  Obx(() => Text(
                                    profilesProcedureViewModel.rxSelectedGroupProcedure.value,
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
          //
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
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
                          Obx(() => Text(checkingNullNumberAndConvertToString(
                              profilesProcedureViewModel
                                  .rxProfileProcedureStatistic.value.tongSoHoSo),
                              style: textBlueCountTotalStyle)
                          ),
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
                Obx(() => (menuController.rxShowStatistic.value == true)
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                    height: 250,
                    child: GridView.count(
                      shrinkWrap: true,

                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 0,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ tiếp nhận trực tuyến",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString( profilesProcedureViewModel
                                    .rxProfileProcedureStatistic.value.hoSoTiepNhanTrucTuyen),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ tiếp nhận trực tiếp",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(profilesProcedureViewModel
                                    .rxProfileProcedureStatistic.value.hoSoTiepNhanTrucTiep
                                    ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ đúng hạn",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel
                                    .rxProfileProcedureStatistic.value.hoSoQuaHan
                              ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ sớm hạn",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel
                                    .rxProfileProcedureStatistic.value.hoSoSomHan
                              ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ chưa đến hạn",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel
                                    .rxProfileProcedureStatistic.value.hoSoChuaDenHan
                                 ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ quá hạn",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel
                                    .rxProfileProcedureStatistic.value.hoSoQuaHan
                                   ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ chờ tiếp nhận",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel
                                    .rxProfileProcedureStatistic.value.choTiepNhan
                                 ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ chờ bổ sung",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                              checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .choBoSung
                              ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ chờ trả kết quả",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .choTraKetQua
                                ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ đã bổ sung",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .daBoSung
                                ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ đang xử lý",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .daBoSung
                                ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ đã xử lý",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .daXuLy
                                ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ chờ giải quyết",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .choGiaiQuyet
                                ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ đang trình ký",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .dangTrinhKy
                                ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ đang được phân công",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .dangPhanCong
                                ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 28,
                              child: Text("Hồ sơ chờ phân công thụ lý",
                                  style: CustomTextStyle
                                      .robotow400s12TextStyle),
                            ),
                            Text(
                                checkingNullNumberAndConvertToString(  profilesProcedureViewModel.rxProfileProcedureStatistic.value
                                    .choPhanCongThuLy
                                ),
                                style: textBlackCountEofficeStyle)
                          ],
                        ),

                      ],
                    ),
                  ),
                )
                    : const SizedBox.shrink()),
                fromDateToDateWidget(profilesProcedureViewModel,(){
                  String strDateFrom =
                      menuController.rxFromDateWithoutWeekDayToApi.value;
                  String strDateTo =
                      menuController.rxToDateWithoutWeekDayToApi.value;
                  if(strDateFrom != "" && strDateTo != "") {
                    profilesProcedureViewModel.getProfileProcListByDiffDate(
                        strDateFrom, strDateTo);
                  }
                  else
                  {
                    profilesProcedureViewModel.postProfileDefault();
                  }
                })
              ],
            ),
          ),
          const Divider(
            thickness: 1,),
          Expanded(
              child: Obx(() => (profilesProcedureViewModel
                      .rxProfileProcedureListItems.isNotEmpty)
                  ? ListView.builder(
                      shrinkWrap: true,
                      controller: profilesProcedureViewModel.controller,
                      itemCount: profilesProcedureViewModel
                          .rxProfileProcedureListItems.length,
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
                                      height: 360,
                                      child: DetailProfileProcBottomSheet(
                                          index,
                                          profilesProcedureViewModel
                                              .rxProfileProcedureListItems[index]));
                                },
                              );
                            },
                            child: ProfileProcItem(
                                index,
                                profilesProcedureViewModel
                                    .rxProfileProcedureListItems[index]));
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
                            profilesProcedureViewModel.getProfileProcListByDiffDate(
                                strDateFrom, strDateTo);
                            menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                            menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                            profilesProcedureViewModel.switchBottomButton(0);
                          },
                          child: bottomDateButton(
                              "Ngày",
                              profilesProcedureViewModel
                                  .selectedBottomButton.value,
                              0)),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String strDateFrom = formatDateToString(findFirstDateOfTheWeek(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheWeek(dateNow));

                          profilesProcedureViewModel.getProfileProcListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          profilesProcedureViewModel.switchBottomButton(1);
                        },
                        child: bottomDateButton(
                            "Tuần",
                            profilesProcedureViewModel
                                .selectedBottomButton.value,
                            1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String strDateFrom = formatDateToString(findFirstDateOfTheMonth(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheMonth(dateNow));

                          profilesProcedureViewModel.getProfileProcListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          profilesProcedureViewModel.switchBottomButton(2);
                        },
                        child: bottomDateButton(
                            "Tháng",
                            profilesProcedureViewModel
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

class DetailProfileProcBottomSheet extends StatelessWidget {
  const DetailProfileProcBottomSheet(this.index, this.docModel, {Key? key})
      : super(key: key);
  final int? index;
  final ProfileProcedureListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin hồ sơ hành chính',
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
          sheetButtonDetailTitleItem(docModel!.tenThuTucHanhChinh!,context),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: textCodeStyle(docModel!.maSoBienNhan!)),
          signProfileProcWidget(docModel!),
          SizedBox(
            height: 120,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              childAspectRatio: 3.5 / 2,

              crossAxisCount: 3,
              children: <Widget>[
                sheetDetailBottemItem('Tên cơ quan',docModel!.tenCoquan!,context),
                sheetDetailBottemItem('Hạn xử lý',formatDate(docModel!.ngayHenTraKetQua!),context),
                sheetDetailBottemItem('Tình trạng hồ sơ',docModel!.tinhTrangHoSo!,context),
                sheetDetailBottemItem('Lĩnh vực',docModel!.tenLinhVuc!,context),
                sheetDetailBottemItem('Hình thức tiếp nhận',docModel!.receptionForm!,context),
                sheetDetailBottemItem('Loại hồ sơ',docModel!.receptionForm!,context),
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
                      ProfileProcHomeDetail(id: docModel!.maSoBienNhan!));
                })
              ],
            ),
          )
        ],
      ),
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
