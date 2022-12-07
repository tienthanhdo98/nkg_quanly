import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../profile_viewmodel.dart';

class ProfileFilterScreen extends GetView {
  const ProfileFilterScreen(this.profileViewModel, {Key? key}) : super(key: key);
  final ProfileViewModel? profileViewModel;

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
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Text(
                        "Bộ lọc",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                         profileViewModel!.clearSelectedFilter();
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
                          "Đơn vị soạn thảo:",
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
                                    child: FilterUnitBottomSheet(
                                        profileViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profileViewModel!
                                  .rxUnitEditorSelected.value !=
                                  "")
                                  ? profileViewModel!
                                  .rxUnitEditorSelected.value
                                  : "Chọn đơn vị soạn thảo",
                              context))),
                      //muc do
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Vấn đề trình:",
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
                                    child: FilterSubmitProblemBottomSheet(
                                        profileViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profileViewModel!
                                  .rxSubmissProblemSelected.value !=
                                  "")
                                  ? profileViewModel!
                                  .rxSubmissProblemSelected.value
                                  : "Chọn vấn đề trình",
                              context))),
                      //loai phieu trinh
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Loại phiếu trình:",
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
                                    child: FilterSubmitTypeBottomSheet(
                                        profileViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profileViewModel!
                                  .rxTypeSubmissSelected.value !=
                                  "")
                                  ? profileViewModel!
                                  .rxTypeSubmissSelected.value
                                  : "Chọn loại phiếu trình",
                              context))),
                      //trang thai
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
                                    height: 500,
                                    child: FilterStateBottomSheet(
                                        profileViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (profileViewModel!
                                  .rxStateSelected.value !=
                                  "")
                                  ? profileViewModel!
                                  .rxStateSelected.value
                                  : "Chọn trạng thái",
                              context))),
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
                                var state = "";
                                var unitEditor = "";
                                var submissionProblem = "";
                                var typeSubmission = "";
                                if (profileViewModel!.mapAllFilter
                                    .containsKey(0)) {
                                  profileViewModel!.postProfileByFilter(
                                      state,
                                      unitEditor,
                                      submissionProblem,
                                      typeSubmission);
                                } else {
                                  state = getStringFilterFromMap(
                                      profileViewModel!.mapAllFilter,
                                      profileViewModel!.mapState,
                                      1);
                                  unitEditor = getStringFilterFromMap(
                                      profileViewModel!.mapAllFilter,
                                      profileViewModel!.mapUnitEditorFilter,
                                      2);
                                  submissionProblem = getStringFilterFromMap(
                                      profileViewModel!.mapAllFilter,
                                      profileViewModel!.mapSubmissProblem,
                                      3);
                                  typeSubmission = getStringFilterFromMap(
                                      profileViewModel!.mapAllFilter,
                                      profileViewModel!.mapTypeSubmission,
                                      4);


                                  profileViewModel!.postProfileByFilter(
                                      state,
                                      unitEditor,
                                      submissionProblem,
                                      typeSubmission);
                                }
                                Get.back();
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



class FilterUnitBottomSheet extends StatelessWidget {
  const FilterUnitBottomSheet(this.profileViewModel, {Key? key})
      : super(key: key);
  final ProfileViewModel? profileViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca don vi
          FilterAllItem("Tất cả đơn vị", 2, profileViewModel!.mapAllFilter),
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
                itemCount: profileViewModel!.rxListUnitEditor.length,
                itemBuilder: (context, index) {
                  var item = profileViewModel!.rxListUnitEditor[index];
                  return FilterItem(item, item, index,
                      profileViewModel!.mapUnitEditorFilter);
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
                        if (profileViewModel!.mapAllFilter
                            .containsKey(2)) {
                          changeValueSelectedFilter(
                              profileViewModel!.rxUnitEditorSelected,
                              "Tất cả đơn vị");
                        } else {
                          var unitEdit = "";
                          var unitEditName = "";
                          profileViewModel!.mapUnitEditorFilter
                              .forEach((key, value) {
                            unitEdit += value;
                          });
                          var listId = unitEdit.split(";");
                          for (var id in listId) {
                            for (var item
                            in profileViewModel!.rxListUnitEditor) {
                              if (item == id) {
                                unitEditName += "$item;";
                              }
                            }
                          }
                          if (unitEditName != "") {
                            changeValueSelectedFilter(
                                profileViewModel!.rxUnitEditorSelected,
                                unitEditName.substring(0, unitEditName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profileViewModel!.rxUnitEditorSelected, "");
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

class FilterSubmitProblemBottomSheet extends StatelessWidget {
  const FilterSubmitProblemBottomSheet(this.profileViewModel, {Key? key})
      : super(key: key);
  final ProfileViewModel? profileViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca van de trinh
          FilterAllItem(
              "Tất cả vấn đề trình", 3, profileViewModel!.mapAllFilter),
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
                itemCount: profileViewModel!.rxListSubmissProblem.length,
                itemBuilder: (context, index) {
                  var item = profileViewModel!.rxListSubmissProblem[index];
                  return FilterItem(
                      item, item, index, profileViewModel!.mapSubmissProblem);
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
                        if (profileViewModel!.mapAllFilter
                            .containsKey(3)) {
                          changeValueSelectedFilter(
                              profileViewModel!.rxSubmissProblemSelected,
                              "Tất cả vấn đề trình");
                        } else {
                          var submissProb = "";
                          var submissprobName = "";
                          profileViewModel!.mapSubmissProblem
                              .forEach((key, value) {
                            submissProb += value;
                          });
                          var listId = submissProb.split(";");
                          for (var id in listId) {
                            for (var item
                            in profileViewModel!.rxListSubmissProblem) {
                              if (item == id) {
                                submissprobName += "$item;";
                              }
                            }
                          }
                          if (submissprobName != "") {
                            changeValueSelectedFilter(
                                profileViewModel!.rxSubmissProblemSelected,
                                submissprobName.substring(0, submissprobName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profileViewModel!.rxSubmissProblemSelected, "");
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

class FilterSubmitTypeBottomSheet extends StatelessWidget {
  const FilterSubmitTypeBottomSheet(this.profileViewModel, {Key? key})
      : super(key: key);
  final ProfileViewModel? profileViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca loai phieu
          FilterAllItem(
              "Tất cả loại phiếu trình", 4, profileViewModel!.mapAllFilter),
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
                itemCount: profileViewModel!.rxListTypeSubmission.length,
                itemBuilder: (context, index) {
                  var item = profileViewModel!.rxListTypeSubmission[index];
                  return FilterItem(
                      item, item, index, profileViewModel!.mapTypeSubmission);
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
                        if (profileViewModel!.mapAllFilter
                            .containsKey(4)) {
                          changeValueSelectedFilter(
                              profileViewModel!.rxTypeSubmissSelected,
                              "Tất cả loại phiếu trình");
                        } else {
                          var typeSubmiss = "";
                          var typeSubmissName = "";
                          profileViewModel!.mapTypeSubmission
                              .forEach((key, value) {
                            typeSubmiss += value;
                          });
                          var listId = typeSubmiss.split(";");
                          for (var id in listId) {
                            for (var item
                            in profileViewModel!.rxListTypeSubmission) {
                              if (item == id) {
                                typeSubmissName += "$item;";
                              }
                            }
                          }
                          if (typeSubmissName != "") {
                            changeValueSelectedFilter(
                                profileViewModel!.rxTypeSubmissSelected,
                                typeSubmissName.substring(0, typeSubmissName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profileViewModel!.rxTypeSubmissSelected, "");
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

class FilterStateBottomSheet extends StatelessWidget {
  const FilterStateBottomSheet(this.profileViewModel, {Key? key})
      : super(key: key);
  final ProfileViewModel? profileViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //tat ca trang thai
          FilterAllItem(
              "Tất cả trạng thái", 1, profileViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 320,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: listProfileState.length,
                itemBuilder: (context, index) {
                  var item = listProfileState[index];
                  return FilterItem(
                      item, item, index, profileViewModel!.mapState);
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
                        if (profileViewModel!.mapAllFilter
                            .containsKey(1)) {
                          changeValueSelectedFilter(
                              profileViewModel!.rxStateSelected,
                              "Tất cả trạng thái");
                        } else {
                          var status = "";
                          var statusName = "";
                          profileViewModel!.mapState
                              .forEach((key, value) {
                            status += value;
                          });
                          var listId = status.split(";");
                          for (var id in listId) {
                            for (var item
                            in listProfileState) {
                              if (item == id) {
                                statusName += "$item;";
                              }
                            }
                          }
                          if (statusName != "") {
                            changeValueSelectedFilter(
                                profileViewModel!.rxStateSelected,
                                statusName.substring(0, statusName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                profileViewModel!.rxStateSelected, "");
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