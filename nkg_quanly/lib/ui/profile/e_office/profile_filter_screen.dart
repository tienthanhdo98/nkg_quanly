import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../profile_viewmodel.dart';

class ProfileFilterScreen extends GetView {
  ProfileFilterScreen(this.profileViewModel, {Key? key}) : super(key: key);
  final ProfileViewModel? profileViewModel;
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
                          child: borderTextFilterEOffice(
                              "Chọn đơn vị soạn thảo", context)),
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
                          child: borderTextFilterEOffice(
                              "Chọn vấn đề trình", context)),
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
                                    height: 350,
                                    child: FilterSubmitTypeBottomSheet(
                                        profileViewModel));
                              },
                            );
                          },
                          child: borderTextFilterEOffice(
                              "Chọn loại phiếu trình", context)),
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
                                    height: 400,
                                    child: FilterStateBottomSheet(
                                        profileViewModel));
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

                                  print(state);
                                  print(unitEditor);
                                  print(submissionProblem);
                                  print(typeSubmission);
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

class FilterStateBottomSheet extends StatelessWidget {
  const FilterStateBottomSheet(this.profileViewModel, {Key? key})
      : super(key: key);
  final ProfileViewModel? profileViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
            Align(
              alignment: Alignment.bottomCenter,
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
      ),
    );
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: profileViewModel!.rxListUnitEditor.length,
                  itemBuilder: (context, index) {
                    var item = profileViewModel!.rxListUnitEditor[index];
                    return FilterItem(item, item, index,
                        profileViewModel!.mapUnitEditorFilter);
                  }),
            ),
            //bottom button
            Align(
              alignment: Alignment.bottomCenter,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tat ca van de trinh
            FilterAllItem(
                "Tất cả trạng thái", 3, profileViewModel!.mapAllFilter),
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
                  itemCount: profileViewModel!.rxListSubmissProblem.length,
                  itemBuilder: (context, index) {
                    var item = profileViewModel!.rxListSubmissProblem[index];
                    return FilterItem(
                        item, item, index, profileViewModel!.mapSubmissProblem);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: profileViewModel!.rxListTypeSubmission.length,
                  itemBuilder: (context, index) {
                    var item = profileViewModel!.rxListTypeSubmission[index];
                    return FilterItem(
                        item, item, index, profileViewModel!.mapTypeSubmission);
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
      ),
    );
  }
}
