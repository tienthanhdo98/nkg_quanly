import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';

import '../../../const/const.dart';
import '../../../model/misstion/mission_detail.dart';
import '../../../model/profile_procedure_model/profile_procedure_model.dart';
import '../../mission/mission_detail.dart';
import '../../theme/theme_data.dart';
import '../profiles_procedure_viewmodel.dart';




class ProfileProcTracesDetail extends GetView {
  final ProfileProcedureListItems? profileProcedureListItems;

  final profilesProcedureViewModel = Get.put(ProfilesProcedureViewModel());

  ProfileProcTracesDetail(this.profileProcedureListItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios_outlined),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                  Expanded(
                    child: Text(
                      "Các hoạt động",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => ProfilesProcedureListWithStatistic(header: "Danh sách hồ sơ hành chính"));
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Image.asset(
                              'assets/icons/ic_close_2.png',
                              width: 15,
                              height: 15,
                            ))),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: kgray,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  SizedBox(
                      width: 100,
                      child: Text(
                        "Thời gian",
                        style: Theme.of(context).textTheme.headline5,
                      )),
                  Expanded(
                      child: Text(
                    "Các hoạt động",
                    style: Theme.of(context).textTheme.headline5,
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: profileProcedureListItems!.timelines!.length,
                itemBuilder: (context, index) {
                  Timelines itemTimeLine =
                  profileProcedureListItems!.timelines![index];
                  return TimelineItem(itemTimeLine: itemTimeLine);
                }),
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
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(11.0),
                      child: Text(
                        'Đóng',
                        style: TextStyle(fontSize: 16),
                      )),
                  style: bottomButtonStyle,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}




