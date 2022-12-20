import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../profiles_procedure_viewmodel.dart';

class ProfileProceduceFilterScreen extends GetView {
  const ProfileProceduceFilterScreen(this.profilesProcedureViewModel,
      {Key? key})
      : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_arrow_back.png',
                        width: 18,
                        height: 18,
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Text(
                        "Bộ lọc",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          profilesProcedureViewModel!.clearSelectedFilter();

                        },
                        child: const Text(
                          "Xóa bộ lọc",
                          style: TextStyle(color: kBlueButton),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //nhom đơn vị ban hành
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Cơ quan:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
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
                                    height: 300,
                                    child: FilterAgenciesBottomSheet(
                                        profilesProcedureViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profilesProcedureViewModel!
                                          .rxSelectedAgencies.value !=
                                      "")
                                  ? profilesProcedureViewModel!
                                      .rxSelectedAgencies.value
                                  : "Chọn cơ quan",
                              context))),
                      //muc do
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Lĩnh vực:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
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
                                    height: 420,
                                    child: FilterBranchBottomSheet(
                                        profilesProcedureViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profilesProcedureViewModel!
                                          .rxSelectedBranch.value !=
                                      "")
                                  ? profilesProcedureViewModel!
                                      .rxSelectedBranch.value
                                  : "Chọn lĩnh vực",
                              context))),
                      //loai phieu trinh
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Trạng thái:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
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
                                    height: MediaQuery.of(context).size.height *
                                        0.80,
                                    child: FilterStatusBottomSheet(
                                        profilesProcedureViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profilesProcedureViewModel!
                                          .rxSelectedStatus.value !=
                                      "")
                                  ? profilesProcedureViewModel!
                                      .rxSelectedStatus.value
                                  : "Chọn trạng thái",
                              context))),
                      //thu tuc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Thủ tục:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
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
                                    child: FilterProceduceBottomSheet(
                                        profilesProcedureViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profilesProcedureViewModel!
                                          .rxSelectedProcedure.value !=
                                      "")
                                  ? profilesProcedureViewModel!
                                      .rxSelectedProcedure.value
                                  : "Chọn thủ tục",
                              context))),
                      //nhom thu tuc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Nhóm thủ tục:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
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
                                    child: FilterGroupProceduceBottomSheet(
                                        profilesProcedureViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profilesProcedureViewModel!
                                          .rxSelectedGroupProcedure.value !=
                                      "")
                                  ? profilesProcedureViewModel!
                                      .rxSelectedGroupProcedure.value
                                  : "Chọn nhóm thủ tục",
                              context))),
                      // const Spacer(),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
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
                                      profilesProcedureViewModel!
                                          .mapBranchFilter,
                                      2);
                                  status = getStringFilterFromMap(
                                      profilesProcedureViewModel!.mapAllFilter,
                                      profilesProcedureViewModel!
                                          .mapStatusFilter,
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

                                  profilesProcedureViewModel!
                                      .postProfileProcByFilter(agencies, branch,
                                          status, procedure, groupProcedure);
                                }
                              },
                              child: buttonShowListScreen("Tìm kiếm"),
                              style: bottomButtonStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class FilterAgenciesBottomSheet extends StatelessWidget {
  const FilterAgenciesBottomSheet(this.profilesProcedureViewModel, {Key? key})
      : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca don vi
          FilterAllItem(
            "Tất cả cơ quan",
            1,
            profilesProcedureViewModel!.mapAllFilter,
            profilesProcedureViewModel!.mapAgenciesFilter,
            profilesProcedureViewModel!.rxListAgenciesList,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 120,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    profilesProcedureViewModel!.rxListAgenciesList.length,
                itemBuilder: (context, index) {
                  var item =
                      profilesProcedureViewModel!.rxListAgenciesList[index];
                  return FilterItem(item.ten!, item.id!, index,
                      profilesProcedureViewModel!.mapAgenciesFilter);
                }),
          ),
          //bottom button
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
                        if (profilesProcedureViewModel!.mapAllFilter
                            .containsKey(1)) {
                          profilesProcedureViewModel!.changeValueSelectedFilter(
                              profilesProcedureViewModel!.rxSelectedAgencies,
                              "Tất cả cơ quan");
                        } else {
                          var agencies = "";
                          var agenciesName = "";
                          profilesProcedureViewModel!.mapAgenciesFilter
                              .forEach((key, value) {
                            agencies += value;
                          });
                          var listId = agencies.split(";");
                          for (var id in listId) {
                            for (var item in profilesProcedureViewModel!
                                .rxListAgenciesList) {
                              if (item.id == id) {
                                agenciesName += "${item.ten!};";
                              }
                            }
                          }
                          if (agenciesName != "") {
                            profilesProcedureViewModel!
                                .changeValueSelectedFilter(
                                    profilesProcedureViewModel!
                                        .rxSelectedAgencies,
                                    agenciesName.substring(
                                        0, agenciesName.length - 1));
                          } else {
                            profilesProcedureViewModel!
                                .changeValueSelectedFilter(
                                    profilesProcedureViewModel!
                                        .rxSelectedAgencies,
                                    "");
                          }
                        }
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

class FilterBranchBottomSheet extends StatelessWidget {
  const FilterBranchBottomSheet(this.profilesProcedureViewModel, {Key? key})
      : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca linh cuc
          FilterAllItem(
            "Tất cả lĩnh vực",
            2,
            profilesProcedureViewModel!.mapAllFilter,
            profilesProcedureViewModel!.mapBranchFilter,
            profilesProcedureViewModel!.rxListBranch,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 240,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: profilesProcedureViewModel!.rxListBranch.length,
                itemBuilder: (context, index) {
                  var item = profilesProcedureViewModel!.rxListBranch[index];
                  return FilterItem(item.tenLinhVuc!, item.id!, index,
                      profilesProcedureViewModel!.mapBranchFilter);
                }),
          ),
          //bottom button
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
                        if (profilesProcedureViewModel!.mapAllFilter
                            .containsKey(2)) {
                          changeValueSelectedFilter(
                              profilesProcedureViewModel!.rxSelectedBranch,
                              "Tất cả lĩnh vực");
                        } else {
                          var branch = "";
                          var branchName = "";
                          profilesProcedureViewModel!.mapBranchFilter
                              .forEach((key, value) {
                            branch += value;
                          });
                          var listId = branch.split(";");
                          for (var id in listId) {
                            for (var item
                                in profilesProcedureViewModel!.rxListBranch) {
                              if (item.id == id) {
                                branchName += "${item.tenLinhVuc!};";
                              }
                            }
                          }
                          if (branchName != "") {
                            changeValueSelectedFilter(
                                profilesProcedureViewModel!.rxSelectedBranch,
                                branchName.substring(0, branchName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profilesProcedureViewModel!.rxSelectedBranch,
                                "");
                          }
                        }
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

class FilterStatusBottomSheet extends StatelessWidget {
  const FilterStatusBottomSheet(this.profilesProcedureViewModel, {Key? key})
      : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca trang thai
          FilterAllItem(
            "Tất cả trạng thái",
            3,
            profilesProcedureViewModel!.mapAllFilter,
            profilesProcedureViewModel!.mapStatusFilter,
            profilesProcedureViewModel!.rxListStatus,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: profilesProcedureViewModel!.rxListStatus.length,
                itemBuilder: (context, index) {
                  var item = profilesProcedureViewModel!.rxListStatus[index];
                  return FilterItem(item.trangThai!, item.id!, index,
                      profilesProcedureViewModel!.mapStatusFilter);
                }),
          ),
          //bottom button
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
                        if (profilesProcedureViewModel!.mapAllFilter
                            .containsKey(3)) {
                          changeValueSelectedFilter(
                              profilesProcedureViewModel!.rxSelectedStatus,
                              "Tất cả trạng thái");
                        } else {
                          var status = "";
                          var statusName = "";
                          profilesProcedureViewModel!.mapStatusFilter
                              .forEach((key, value) {
                            status += value;
                          });
                          var listId = status.split(";");
                          for (var id in listId) {
                            for (var item
                                in profilesProcedureViewModel!.rxListStatus) {
                              if (item.id == id) {
                                statusName += "${item.trangThai!};";
                              }
                            }
                          }
                          if (statusName != "") {
                            changeValueSelectedFilter(
                                profilesProcedureViewModel!.rxSelectedStatus,
                                statusName.substring(0, statusName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profilesProcedureViewModel!.rxSelectedStatus,
                                "");
                          }
                        }
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

class FilterProceduceBottomSheet extends StatelessWidget {
  const FilterProceduceBottomSheet(this.profilesProcedureViewModel, {Key? key})
      : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca thu tuc
          FilterAllItem(
            "Tất cả thủ tục",
            4,
            profilesProcedureViewModel!.mapAllFilter,
            profilesProcedureViewModel!.mapProcedureFilter,
            profilesProcedureViewModel!.rxListProcedure,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          //list van de trinh
          SizedBox(
            height: 120,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: profilesProcedureViewModel!.rxListProcedure.length,
                itemBuilder: (context, index) {
                  var item = profilesProcedureViewModel!.rxListProcedure[index];
                  return FilterItem(item.ten!, item.id!, index,
                      profilesProcedureViewModel!.mapProcedureFilter);
                }),
          ),
          //bottom button
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
                        if (profilesProcedureViewModel!.mapAllFilter
                            .containsKey(4)) {
                          changeValueSelectedFilter(
                              profilesProcedureViewModel!.rxSelectedProcedure,
                              "Tất cả thủ tục");
                        } else {
                          var procedure = "";
                          var procedureName = "";
                          profilesProcedureViewModel!.mapProcedureFilter
                              .forEach((key, value) {
                            procedure += value;
                          });
                          var listId = procedure.split(";");
                          for (var id in listId) {
                            for (var item in profilesProcedureViewModel!
                                .rxListProcedure) {
                              if (item.id == id) {
                                procedureName += "${item.ten!};";
                              }
                            }
                          }
                          if (procedureName != "") {
                            changeValueSelectedFilter(
                                profilesProcedureViewModel!.rxSelectedProcedure,
                                procedureName.substring(
                                    0, procedureName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profilesProcedureViewModel!.rxSelectedProcedure,
                                "");
                          }
                        }
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

class FilterGroupProceduceBottomSheet extends StatelessWidget {
  const FilterGroupProceduceBottomSheet(this.profilesProcedureViewModel,
      {Key? key})
      : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca don vi
          FilterAllItem(
            "Tất cả nhóm thủ tục",
            5,
            profilesProcedureViewModel!.mapAllFilter,
            profilesProcedureViewModel!.mapGroupProcedureFilter,
            profilesProcedureViewModel!.rxListGroupProcedure,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          //list van de trinh
          SizedBox(
            height: 120,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    profilesProcedureViewModel!.rxListGroupProcedure.length,
                itemBuilder: (context, index) {
                  var item =
                      profilesProcedureViewModel!.rxListGroupProcedure[index];
                  return FilterItem(item.ten!, item.id!, index,
                      profilesProcedureViewModel!.mapGroupProcedureFilter);
                }),
          ),
          //bottom button
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
                        if (profilesProcedureViewModel!.mapAllFilter
                            .containsKey(5)) {
                          changeValueSelectedFilter(
                              profilesProcedureViewModel!
                                  .rxSelectedGroupProcedure,
                              "Tất cả nhóm thủ tục");
                        } else {
                          var groupProcId = "";
                          var groupProcName = "";
                          profilesProcedureViewModel!.mapGroupProcedureFilter
                              .forEach((key, value) {
                            groupProcId += value;
                          });
                          var listId = groupProcId.split(";");
                          for (var id in listId) {
                            for (var item in profilesProcedureViewModel!
                                .rxListGroupProcedure) {
                              if (item.id == id) {
                                groupProcName += "${item.ten!};";
                              }
                            }
                          }
                          if (groupProcName != "") {
                            changeValueSelectedFilter(
                                profilesProcedureViewModel!
                                    .rxSelectedGroupProcedure,
                                groupProcName.substring(
                                    0, groupProcName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profilesProcedureViewModel!
                                    .rxSelectedGroupProcedure,
                                "");
                          }
                        }
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
