import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../profiles_procedure_viewmodel.dart';


class ProfileProceduceFilterScreen extends GetView {
  ProfileProceduceFilterScreen(this.profilesProcedureViewModel, {Key? key}) : super(key: key);
  final ProfilesProcedureViewModel? profilesProcedureViewModel;

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
                          child: borderTextFilterEOffice(
                              "Chọn cơ quan", context)),
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
                          child: borderTextFilterEOffice(
                              "Chọn lĩnh vực", context)),
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
                                    height: MediaQuery.of(context).size.height*0.85,
                                    child: FilterStatusBottomSheet(
                                        profilesProcedureViewModel));
                              },
                            );
                          },
                          child: borderTextFilterEOffice(
                              "Chọn trạng thái", context)),
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
                                    height: 350,
                                    child: FilterProceduceBottomSheet(
                                        profilesProcedureViewModel));
                              },
                            );
                          },
                          child: borderTextFilterEOffice(
                              "Chọn thủ tục", context)),
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
                                    height: 350,
                                    child: FilterGroupProceduceBottomSheet(
                                        profilesProcedureViewModel));
                              },
                            );
                          },
                          child: borderTextFilterEOffice(
                              "Chọn nhóm thủ tục", context)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tat ca don vi
            FilterAllItem( "Tất cả cơ quan", 1,profilesProcedureViewModel!.mapAllFilter),

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
                  itemCount: profilesProcedureViewModel!.rxListAgenciesList.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureViewModel!.rxListAgenciesList[index];
                    return
                      FilterItem(item.ten!,item.id!,index,
                          profilesProcedureViewModel!.mapAgenciesFilter);
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

class FilterBranchBottomSheet extends StatelessWidget {
  const FilterBranchBottomSheet(this.profilesProcedureViewModel, {Key? key})
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
            //tat ca linh cuc
            FilterAllItem( "Tất cả lĩnh vực", 2,profilesProcedureViewModel!.mapAllFilter),
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
                    return
                      FilterItem(item.tenLinhVuc!,item.id!,index,
                          profilesProcedureViewModel!.mapBranchFilter);
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

class FilterStatusBottomSheet extends StatelessWidget {
  const FilterStatusBottomSheet(this.profilesProcedureViewModel, {Key? key})
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
            //tat ca trang thai
            FilterAllItem( "Tất cả trạng thái", 3,profilesProcedureViewModel!.mapAllFilter),
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
                    return
                      FilterItem(item.trangThai!,item.id!,index,
                          profilesProcedureViewModel!.mapStatusFilter);
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

class FilterProceduceBottomSheet extends StatelessWidget {
  const FilterProceduceBottomSheet(this.profilesProcedureViewModel, {Key? key})
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
            //tat ca thu tuc
            FilterAllItem( "Tất cả thủ tục", 4,profilesProcedureViewModel!.mapAllFilter),
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
                  itemCount: profilesProcedureViewModel!.rxListProcedure.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureViewModel!.rxListProcedure[index];
                    return
                      FilterItem(item.ten!,item.id!,index,
                          profilesProcedureViewModel!.mapProcedureFilter);
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

class FilterGroupProceduceBottomSheet extends StatelessWidget {
  const FilterGroupProceduceBottomSheet(this.profilesProcedureViewModel, {Key? key})
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
            //tat ca don vi
            FilterAllItem( "Tất cả nhóm cơ quan", 5,profilesProcedureViewModel!.mapAllFilter),
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
                  itemCount: profilesProcedureViewModel!.rxListGroupProcedure.length,
                  itemBuilder: (context, index) {
                    var item = profilesProcedureViewModel!.rxListGroupProcedure[index];
                    return
                      FilterItem(item.ten!,item.id!,index,
                          profilesProcedureViewModel!.mapGroupProcedureFilter);
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
