import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../mission_viewmodel.dart';

class FilterMissionScreen extends GetView {
  FilterMissionScreen(this.missionViewModel, {Key? key}) : super(key: key);
  final MissionViewModel? missionViewModel;
  String? department;
  String? level;
  String? status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidget("Bộ lọc", context),
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
                          child: borderTextFilterEOffice(
                              "Chọn đơn vị ban hành", context)),
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
                              borderTextFilterEOffice("Chọn mức độ", context)),
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
                          child: borderTextFilterEOffice(
                              "Chọn trạng thái", context)),
                      const Spacer(),
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
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                physics: BouncingScrollPhysics(),
                itemCount: missionViewModel!.rxListDepartmentFilter.length,
                itemBuilder: (context, index) {
                  var item = missionViewModel!.rxListDepartmentFilter[index];
                  return
                    FilterItem(item,item.toString(),index,
                        missionViewModel!.mapDepartmentFilter);
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
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                physics: NeverScrollableScrollPhysics(),
                itemCount: listLevel.length,
                itemBuilder: (context, index) {
                  var item = listLevel[index];
                  return
                    FilterItem(item,item,index,
                        missionViewModel!.mapLevelFilter);
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
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
            height: 250,
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listMissionState.length,
                itemBuilder: (context, index) {
                  var item = listMissionState[index];
                  return
                    FilterItem(item,item,index,
                        missionViewModel!.mapStatusFilter);
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
    );
  }
}
