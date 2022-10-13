import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../model/misstion/mission_detail.dart';
import '../theme/theme_data.dart';
import 'mission_viewmodel.dart';

class MissionTracesDetail extends GetView {
  final MissionItem? missionDetailModel;

  final missionController = Get.put(MissionViewModel());

  MissionTracesDetail(this.missionDetailModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          headerWidget('Các hoạt động', context),
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
                itemCount: missionDetailModel!.timelines!.length,
                itemBuilder: (context, index) {
                  Timelines itemTimeLine =
                      missionDetailModel!.timelines![index];
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
                itemCount: itemTimeLine!.missionTraces!.length,
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
          'assets/icons/ic_still.png',
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
