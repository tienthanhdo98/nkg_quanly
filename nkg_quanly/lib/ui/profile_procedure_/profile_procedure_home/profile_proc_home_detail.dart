import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_detail_comments_child.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_detail_trace_child.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profiles_procedure_list_withstatistic.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../../model/misstion/mission_detail.dart';
import '../../../model/profile_procedure_model/profile_procedure_model.dart';
import '../../mission/mission_detail.dart';
import '../../theme/theme_data.dart';
import '../profiles_procedure_list.dart';
import '../profiles_procedure_viewmodel.dart';


class ProfileProcHomeDetail extends GetView {
  final String? id;

  final profilesProcedureViewModel = Get.put(ProfilesProcedureViewModel());

  ProfileProcHomeDetail({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: profilesProcedureViewModel.getProfileProcDetail(id!),
          builder: (context, AsyncSnapshot<ProfileProcedureListItems> snapshot) {
            if (snapshot.hasData) {
              var item = snapshot.data;
              return Column(children: [
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
                            "Chi tiết hồ sơ",
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. ${item!.tenThuTucHanhChinh!}",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: textCodeStyle(item.maSoBienNhan!)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: signProfileProcWidget(item)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Đơn vị xử lý',
                              style: CustomTextStyle.grayColorTextStyle),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                          Text(item.tenCoquan!,
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
                            Get.to(() => ProfileProcTracesDetail(snapshot.data!));
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
                                    ProfileProcCommentDetail(snapshot.data!));
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



