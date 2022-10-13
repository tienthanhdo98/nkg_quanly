
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_proc_search.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile__proceduce_filter_screen.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_home_detail.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profiles_procedure_viewmodel.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../../model/profile_procedure_model/profile_procedure_model.dart';
import '../../theme/theme_data.dart';
import '../profiles_procedure_list.dart';


class ProfilesProcedureListWithStatistic extends GetView {
  final String? header;

  final profilesProcedureViewModel = Get.put(ProfilesProcedureViewModel());

  ProfilesProcedureListWithStatistic({Key? key, this.header}) : super(key: key);

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
                header: header,
              ),
              context),
          headerTableDatePicker(context, profilesProcedureViewModel),
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
                    const Spacer(),
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
                    : const SizedBox.shrink())
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
                                      height: 400,
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
                  : loadingIcon())),
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
                            profilesProcedureViewModel
                                .onSelectDay(DateTime.now());
                            profilesProcedureViewModel.swtichBottomButton(0);
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
                          DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          profilesProcedureViewModel.postProfileProcByWeek(
                              strdateFrom, strdateTo);
                          profilesProcedureViewModel.swtichBottomButton(1);
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
                          profilesProcedureViewModel.postProfileProcByMonth();
                          profilesProcedureViewModel.swtichBottomButton(2);
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





class FilterProfileProcBottomSheet extends StatelessWidget {
  const FilterProfileProcBottomSheet(this.profilesProcedureViewModel,
      {Key? key})
      : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureViewModel;

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
                      (profilesProcedureViewModel!.mapAllFilter.containsKey(0))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
                                    .checkboxFilterAll(false, 0);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
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
                      (profilesProcedureViewModel!.mapAllFilter.containsKey(1))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
                                    .checkboxFilterAll(false, 1);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
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
                      profilesProcedureViewModel!.rxListAgenciesList.length,
                  itemBuilder: (context, index) {
                    var item =
                        profilesProcedureViewModel!.rxListAgenciesList[index];
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
                              Obx(() => (profilesProcedureViewModel!
                                      .mapAgenciesFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureViewModel!
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
                                        profilesProcedureViewModel!
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
                      (profilesProcedureViewModel!.mapAllFilter.containsKey(2))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
                                    .checkboxFilterAll(false, 2);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
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
                  itemCount: profilesProcedureViewModel!.rxListBranch.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureViewModel!.rxListBranch[index];
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
                              Obx(() => (profilesProcedureViewModel!
                                      .mapBranchFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureViewModel!
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
                                        profilesProcedureViewModel!
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
                      (profilesProcedureViewModel!.mapAllFilter.containsKey(3))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
                                    .checkboxFilterAll(false, 3);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
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
                  itemCount: profilesProcedureViewModel!.rxListStatus.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureViewModel!.rxListStatus[index];
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
                              Obx(() => (profilesProcedureViewModel!
                                      .mapStatusFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureViewModel!
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
                                        profilesProcedureViewModel!
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
                      (profilesProcedureViewModel!.mapAllFilter.containsKey(4))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
                                    .checkboxFilterAll(false, 4);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
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
                      profilesProcedureViewModel!.rxListProcedure.length,
                  itemBuilder: (context, index) {
                    var item =
                        profilesProcedureViewModel!.rxListProcedure[index];
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
                              Obx(() => (profilesProcedureViewModel!
                                      .mapProcedureFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureViewModel!
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
                                        profilesProcedureViewModel!
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
                      (profilesProcedureViewModel!.mapAllFilter.containsKey(5))
                          ? InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
                                    .checkboxFilterAll(false, 5);
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                profilesProcedureViewModel!
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
                      profilesProcedureViewModel!.rxListGroupProcedure.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureViewModel!
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
                              Obx(() => (profilesProcedureViewModel!
                                      .mapGroupProcedureFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        profilesProcedureViewModel!
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
                                        profilesProcedureViewModel!
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
                            if (profilesProcedureViewModel!.mapAllFilter
                                .containsKey(0)) {
                              profilesProcedureViewModel!
                                  .postProfileProcByFilter(agencies, branch,
                                      status, procedure, groupProcedure);
                            } else {
                              agencies = getStringFilterFromMap(
                                  profilesProcedureViewModel!.mapAllFilter,
                                  profilesProcedureViewModel!
                                      .mapAgenciesFilter,
                                  1);
                              branch = getStringFilterFromMap(
                                  profilesProcedureViewModel!.mapAllFilter,
                                  profilesProcedureViewModel!.mapBranchFilter,
                                  2);
                              status = getStringFilterFromMap(
                                  profilesProcedureViewModel!.mapAllFilter,
                                  profilesProcedureViewModel!.mapStatusFilter,
                                  3);
                              procedure = getStringFilterFromMap(
                                  profilesProcedureViewModel!.mapAllFilter,
                                  profilesProcedureViewModel!
                                      .mapProcedureFilter,
                                  4);
                              groupProcedure = getStringFilterFromMap(
                                  profilesProcedureViewModel!.mapAllFilter,
                                  profilesProcedureViewModel!
                                      .mapGroupProcedureFilter,
                                  5);

                              print(agencies);
                              print(branch);
                              print(status);
                              print(procedure);
                              print(groupProcedure);
                              profilesProcedureViewModel!
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

class DetailProfileProcBottomSheet extends StatelessWidget {
  const DetailProfileProcBottomSheet(this.index, this.docModel, {Key? key})
      : super(key: key);
  final int? index;
  final ProfileProcedureListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 25),
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
          Text(
            "${index! + 1}. ${docModel!.tenThuTucHanhChinh!}",
            style: Theme.of(context).textTheme.headline5,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: textCodeStyle(docModel!.maSoBienNhan!)),
          signProfileProcWidget(docModel!),
          SizedBox(
            height: 150,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,

              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3/2,
              crossAxisCount: 3,
              children: <Widget>[
                infoDetailWidget('Tên cơ quan',docModel!.tenCoquan!,context),
                infoDetailWidget('Hạn xử lý',formatDate(docModel!.ngayHenTraKetQua!),context),
                infoDetailWidget('Tình trạng hồ sơ',docModel!.tinhTrangHoSo!,context),
                infoDetailWidget('Lĩnh vực',"docModel!.tenLinhVuc!docModel!.tenLinhVuc!docModel!.tenLinhVuc!",context),
                infoDetailWidget('Hình thức tiếp nhận',docModel!.receptionForm!,context),
                infoDetailWidget('Loại hồ sơ',docModel!.receptionForm!,context),
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
                          Get.to(() =>
                              ProfileProcHomeDetail(id: docModel!.maSoBienNhan!));
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
