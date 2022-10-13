import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';

import '../../../const/style.dart';
import '../../../model/misstion/mission_detail.dart';
import '../../../model/profile_procedure_model/profile_procedure_model.dart';
import '../../mission/mission_detail_comments_child.dart';
import '../profiles_procedure_viewmodel.dart';



class ProfileProcCommentDetail extends GetView {
  final ProfileProcedureListItems? profileProcedureListItems;

  final profilesProcedureViewModel = Get.put(ProfilesProcedureViewModel());

  ProfileProcCommentDetail(this.profileProcedureListItems);

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
                      "Đóng góp chỉ đạo",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                  Get.offAll(() => ProfilesProcedureListWithStatistic());
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
          Expanded(
            child: ListView.builder(
                itemCount: profileProcedureListItems!.timelines![0].comments!.length,
                itemBuilder: (context, index) {
                  Comments commentsItems =
                      profileProcedureListItems!.timelines![0].comments![index];
                  return CommentItem(commentsItems: commentsItems);
                }),
          ),
        ]),
      ),
    );
  }
}


