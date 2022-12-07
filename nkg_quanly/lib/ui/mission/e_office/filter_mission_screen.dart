import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../mission_viewmodel.dart';

class FilterMissionScreen extends GetView {
  const FilterMissionScreen(this.missionViewModel, {Key? key}) : super(key: key);
  final MissionViewModel? missionViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
              // headerWidget("Bộ lọc", context),
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
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Text(
                        "Bộ lọc",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          missionViewModel!.clearSelectedFilter();
                          // Get.back();
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
                          "Đơn vị ban hành:",
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
                                    height: 350,
                                    child: FilterDepartmentBottomSheet(
                                        missionViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (missionViewModel!
                                  .rxDepartmentSelected.value !=
                                  "")
                                  ? missionViewModel!
                                  .rxDepartmentSelected.value
                                  : "Chọn đơn vị ban hành",
                              context))),
                      //muc do
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Mức độ:",
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
                                    height: 400,
                                    child: FilterLevelmentBottomSheet(
                                        missionViewModel));
                              },
                            );
                          },
                          child:
                          Obx(() => borderTextFilterEOffice(
                              (missionViewModel!
                                  .rxLevelSelected.value !=
                                  "")
                                  ? missionViewModel!
                                  .rxLevelSelected.value
                                  : "Chọn mức độ",
                              context))),
                      //nhom trang thai
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
                                    height: 450,
                                    child: FilterStatusBottomSheet(
                                        missionViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (missionViewModel!
                                  .rxStatusSelected.value !=
                                  "")
                                  ? missionViewModel!
                                  .rxStatusSelected.value
                                  : "Chọn trạng thái",
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
                                var status = "";
                                var level = "";
                                var department = "";
                                if (missionViewModel!.mapAllFilter
                                    .containsKey(0)) {
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
                                print(department);
                                print(level);
                                print(status);
                                missionViewModel!.postMissionByFilter(
                                    status, level, department);
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

class FilterDepartmentBottomSheet extends StatelessWidget {
  const FilterDepartmentBottomSheet(this.missionViewModel, {Key? key})
      : super(key: key);
  final MissionViewModel? missionViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca don vi
          FilterAllItem( 'Tất cả đơn vị ban hành', 1,missionViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 150,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: missionViewModel!.rxListDepartmentFilter.length,
                itemBuilder: (context, index) {
                  var item = missionViewModel!.rxListDepartmentFilter[index];
                  return
                    FilterItem(item,item.toString(),index,
                        missionViewModel!.mapDepartmentFilter);
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
                        if (missionViewModel!.mapAllFilter
                            .containsKey(1)) {
                          changeValueSelectedFilter(
                              missionViewModel!.rxDepartmentSelected,
                              "Tất cả đơn vị");
                        } else {
                          var department = "";
                          var departmentName = "";
                          missionViewModel!.mapDepartmentFilter
                              .forEach((key, value) {
                            department += value;
                          });
                          var listId = department.split(";");
                          for (var id in listId) {
                            for (var item
                            in missionViewModel!.rxListDepartmentFilter) {
                              if (item == id) {
                                departmentName += "$item;";
                              }
                            }
                          }
                          if (departmentName != "") {
                            changeValueSelectedFilter(
                                missionViewModel!.rxDepartmentSelected,
                                departmentName.substring(0, departmentName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                missionViewModel!.rxDepartmentSelected, "");
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

class FilterLevelmentBottomSheet extends StatelessWidget {
  const FilterLevelmentBottomSheet(this.missionViewModel, {Key? key})
      : super(key: key);
  final MissionViewModel? missionViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca muc do
          FilterAllItem( "Tất cả mức độ'", 2,missionViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          //list van de trinh
          SizedBox(
            height: 200,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listLevel.length,
                itemBuilder: (context, index) {
                  var item = listLevel[index];
                  return
                    FilterItem(item,item,index,
                        missionViewModel!.mapLevelFilter);
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
                        if (missionViewModel!.mapAllFilter
                            .containsKey(2)) {
                          changeValueSelectedFilter(
                              missionViewModel!.rxLevelSelected,
                              "Tất cả mức độ");
                        } else {
                          var level = "";
                          var levelName = "";
                          missionViewModel!.mapLevelFilter
                              .forEach((key, value) {
                            level += value;
                          });
                          var listId = level.split(";");
                          for (var id in listId) {
                            for (var item
                            in listLevel) {
                              if (item == id) {
                                levelName += "$item;";
                              }
                            }
                          }
                          if (levelName != "") {
                            changeValueSelectedFilter(
                                missionViewModel!.rxLevelSelected,
                                levelName.substring(0, levelName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                missionViewModel!.rxLevelSelected, "");
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
  const FilterStatusBottomSheet(this.missionViewModel, {Key? key})
      : super(key: key);
  final MissionViewModel? missionViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca trang thai
          FilterAllItem( "Tất cả trạng thái", 3,missionViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 240,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listMissionState.length,
                itemBuilder: (context, index) {
                  var item = listMissionState[index];
                  return
                    FilterItem(item,item,index,
                        missionViewModel!.mapStatusFilter);
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
                        if (missionViewModel!.mapAllFilter
                            .containsKey(3)) {
                          changeValueSelectedFilter(
                              missionViewModel!.rxStatusSelected,
                              "Tất cả trạng thái");
                        } else {
                          var status = "";
                          var statusName = "";
                          missionViewModel!.mapStatusFilter
                              .forEach((key, value) {
                            status += value;
                          });
                          var listId = status.split(";");
                          for (var id in listId) {
                            for (var item
                            in listMissionState) {
                              if (item == id) {
                                statusName += "$item;";
                              }
                            }
                          }
                          if (statusName != "") {
                            changeValueSelectedFilter(
                                missionViewModel!.rxStatusSelected,
                                statusName.substring(0, statusName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                missionViewModel!.rxStatusSelected, "");
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
