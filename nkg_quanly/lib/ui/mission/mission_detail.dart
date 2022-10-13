import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../../model/misstion/mission_detail.dart';
import '../theme/theme_data.dart';
import 'mission_detail_comments_child.dart';
import 'mission_detail_trace_child.dart';
import 'mission_viewmodel.dart';

class MissionDetail extends GetView {
  final int? id;

  final missionController = Get.put(MissionViewModel());

  MissionDetail({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: missionController.getMissionDetail(id!),
          builder: (context, AsyncSnapshot<MissionItem> snapshot) {
            if (snapshot.hasData) {
              var item = snapshot.data;
              return Column(children: [
                headerWidget('Chi tiết nhiệm vụ', context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "1.${item!.name}",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: priorityWidget(item))),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: signWidgetMission(item)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Người xử lý',
                              style: CustomTextStyle.grayColorTextStyle),
                          Text(item.organizationName!,
                              style: Theme.of(context).textTheme.headline5)
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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
                        InkWell(
                          onTap: () {
                            Get.to(() => MissionTracesDetail(snapshot.data!));
                          },
                          child: const SizedBox(
                              width: 80,
                              child: Text(
                                "Xem chi tiết",
                                style: blueTextStyle,
                                textAlign: TextAlign.end,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                      itemCount: item.timelines!.length,
                      itemBuilder: (context, index) {
                        Timelines itemTimeLine = item.timelines![index];
                        return TimelineItem(itemTimeLine: itemTimeLine);
                      }),
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  color: kgray,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Text(
                            "Đóng góp chỉ đạo",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(() =>
                                    MissionCommentsDetail(snapshot.data!));
                              },
                              child: const Text(
                                "Xem chi tiết",
                                style: blueTextStyle,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: item.timelines![0].comments!.length,
                          itemBuilder: (context, index) {
                            var commentItem = item.timelines![0].comments![0];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Container(
                                  width: 280,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          offset: const Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(commentItem.comment!,
                                            style: CustomTextStyle
                                                .roboto400s16TextStyle),
                                        const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0)),
                                        Text(
                                          commentItem.employeeName!,
                                          style: CustomTextStyle
                                              .robotow400s12TextStyle,
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          }),
                    )
                  ]),
                ))
              ]);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  const TimelineItem({
    Key? key,
    required this.itemTimeLine,
  }) : super(key: key);

  final Timelines? itemTimeLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatDate(itemTimeLine!.moment!),
            style: Theme.of(context).textTheme.headline5,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: Divider(
              thickness: 2,
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  var missionTraces = itemTimeLine!.missionTraces![index];
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 100,
                              child: Text(
                                missionTraces.time!,
                                style: Theme.of(context).textTheme.headline5,
                              )),
                          Expanded(
                              child: Text(
                            missionTraces.action!,
                            style: Theme.of(context).textTheme.headline5,
                          )),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Divider(
                          thickness: 1,
                        ),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget signWidgetMission(MissionItem docModel) {
  if (docModel.status == "Hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(
          docModel.status!,
          style: const TextStyle(color: kGreenSign, fontSize: 12),
        )
      ],
    );
  } else if (docModel.status == "Chưa hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.status!,
            style: const TextStyle(color: kOrangeSign, fontSize: 12))
      ],
    );
  } else if (docModel.status == "Quá hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.status!,
            style: const TextStyle(color: kRedPriority, fontSize: 12))
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_done_black.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.status!,
            style: const TextStyle(color: Colors.black, fontSize: 12))
      ],
    );
  }
}
