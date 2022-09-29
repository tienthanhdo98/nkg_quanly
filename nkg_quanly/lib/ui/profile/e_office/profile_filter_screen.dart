import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const.dart';
import '../../../const/style.dart';
import '../../../const/ultils.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../profile_viewmodel.dart';



class ProfileFilterScreen extends GetView {
  ProfileFilterScreen(this.profileViewModel, {Key? key}) : super(key: key);
  final ProfileViewModel? profileViewModel;
  String? department ;
  String? level;
  String? status ;

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
                                  child: FilterUnitBottomSheet(profileViewModel));
                            },
                          );
                        },
                        child: borderTextFilterEOffice("Chọn đơn vị soạn thảo",context)),
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
                                  child: FilterSubmitProblemBottomSheet(profileViewModel));
                            },
                          );
                        },
                        child: borderTextFilterEOffice("Chọn vấn đề trình",context)),
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
                                  child: FilterSubmitTypeBottomSheet(profileViewModel));
                            },
                          );
                        },
                        child: borderTextFilterEOffice("Chọn loại phiếu trình",context)),
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
                                  height:400,
                                  child: FilterStateBottomSheet(profileViewModel));
                            },
                          );
                        },
                        child: borderTextFilterEOffice("Chọn trạng thái",context)),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                          child: ElevatedButton(
                            onPressed: () {
                              var state ="";
                              var unitEditor ="";
                              var submissionProblem ="";
                              var typeSubmission ="";
                              if (profileViewModel!.mapAllFilter.containsKey(0)) {
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
                            child: buttonShowListScreen(
                                "Tìm kiếm"),
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
        ),));
  }
}



class FilterStateBottomSheet extends StatelessWidget {
  const FilterStateBottomSheet(this.profileViewModel,
      {Key? key})
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
                  Obx(() => (profileViewModel!.mapAllFilter.containsKey(1))
                      ? InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(false, 1);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(true, 1);
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
                  itemCount: listProfileState.length,
                  itemBuilder: (context, index) {
                    var item = listProfileState[index];
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
                              Obx(() => (profileViewModel!.mapState
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxState(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxState(
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
  const FilterUnitBottomSheet(this.profileViewModel,
      {Key? key})
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả đơn vị',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (profileViewModel!.mapAllFilter.containsKey(2))
                      ? InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(false, 2);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(true, 2);
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
                  itemCount: profileViewModel!.rxListUnitEditor.length,
                  itemBuilder: (context, index) {
                    var item = profileViewModel!.rxListUnitEditor[index];
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
                              Obx(() => (profileViewModel!.mapUnitEditorFilter
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxUnitEditor(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxUnitEditor(
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
  const FilterSubmitProblemBottomSheet(this.profileViewModel,
      {Key? key})
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả Vấn đề trình',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (profileViewModel!.mapAllFilter.containsKey(3))
                      ? InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(false, 3);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(true, 3);
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
                  itemCount: profileViewModel!.rxListSubmissProblem.length,
                  itemBuilder: (context, index) {
                    var item = profileViewModel!.rxListSubmissProblem[index];
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
                              Obx(() => (profileViewModel!.mapSubmissProblem
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    profileViewModel!.checkboxSubmissProblemr(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    profileViewModel!.checkboxSubmissProblemr(
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
  const FilterSubmitTypeBottomSheet(this.profileViewModel,
      {Key? key})
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả loại phiếu trình',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (profileViewModel!.mapAllFilter.containsKey(4))
                      ? InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(false, 4);
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        profileViewModel!.checkboxFilterAll(true, 4);
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
                  itemCount: profileViewModel!.rxListTypeSubmission.length,
                  itemBuilder: (context, index) {
                    var item = profileViewModel!.rxListTypeSubmission[index];
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
                              Obx(() => (profileViewModel!.mapTypeSubmission
                                  .containsKey(index))
                                  ? InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxTypeSubmission(
                                        false, index, "$item;");
                                  },
                                  child: Image.asset(
                                    'assets/icons/ic_checkbox_active.png',
                                    width: 30,
                                    height: 30,
                                  ))
                                  : InkWell(
                                  onTap: () {
                                    profileViewModel!
                                        .checkboxTypeSubmission(
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