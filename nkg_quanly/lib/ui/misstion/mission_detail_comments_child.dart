import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/ultils.dart';

import '../../const.dart';
import '../../model/misstion/mission_detail.dart';
import '../../model/misstion/mission_model.dart';
import '../theme/theme_data.dart';
import 'mission_list.dart';
import 'mission_viewmodel.dart';

class MissionCommentsDetail extends GetView {
  final MissionItem? missionDetailModel;

  final missionController = Get.put(MissionViewModel());

  MissionCommentsDetail(this.missionDetailModel);

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
                  Text(
                    "Đóng góp chỉ đạo",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.offAll(() =>MissionList(header: "Nhiện vụ"));
                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Image.asset('assets/icons/ic_close_2.png',width: 15,height: 15,))),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: missionDetailModel!.timelines![0].comments!.length,
                itemBuilder: (context, index) {
                  Comments commentsItems =
                      missionDetailModel!.timelines![0].comments![index];
                  return CommentItem(commentsItems: commentsItems);
                }),
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                    top: BorderSide(
                        color: Theme.of(context).dividerColor))),
            height: 80,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset(
                        'assets/icons/ic_user.png',
                        width: 40,
                        height: 40,
                      ),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                  const Expanded(child: TextField(
                      decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Thêm chỉ đạo',
                      )

                  )),
                  InkWell(
                      onTap: (){
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: const Text('Đăng',style: blueTextStyle,))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key? key,
    required this.commentsItems,
  }) : super(key: key);

  final Comments? commentsItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  child: Image.asset(
                    'assets/icons/ic_user.png',
                    width: 40,
                    height: 40,
                  ),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  )),
              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
              Text(
                commentsItems!.employeeName!,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                commentsItems!.comment!,
                style: CustomTextStyle.roboto400s16TextStyle,
              )),
          Row(
            children: [
              Text(
                commentsItems!.time!,
                style: CustomTextStyle.robotow700s12TextStyle,
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Phản hồi",
                    style: CustomTextStyle.robotow700s12TextStyle,
                  )),
            ],
          ),
          if (commentsItems!.responses?.isNotEmpty == true)
          SizedBox(
            height: 80,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                itemCount: commentsItems!.responses?.length,
                itemBuilder: (context, index) {
                var responses = commentsItems!.responses![index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Image.asset(
                                'assets/icons/ic_user.png',
                                width: 40,
                                height: 40,
                              ),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  responses.employeeName!,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                                Text(
                                  responses.comment!,
                                  style:
                                      CustomTextStyle.roboto400s16TextStyle,
                                ),
                                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                                Row(
                                  children: [
                                    Text(
                                      responses.time!,
                                      style:
                                          CustomTextStyle.robotow700s12TextStyle,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                        child: Text(
                                          "Phản hồi",
                                          style: CustomTextStyle
                                              .robotow700s12TextStyle,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
