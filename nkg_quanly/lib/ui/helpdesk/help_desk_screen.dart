import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';
import 'help_desk_chart.dart';
import 'help_desk_list.dart';
import 'helpdesk_collum_chart.dart';
import 'helpdesk_viewmodel.dart';

class HelpDeskScreen extends GetView {
  final String? header;
  final String? icon;

  final helpdeskViewModel = Get.put(HelpdeskViewModel());

  HelpDeskScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            headerWidget(header!, context),
            Expanded(
              child: SingleChildScrollView(
                  child: Obx(
                () => (helpdeskViewModel.rxIsLoadingScreen.value == false)
                    ? Column(children: [
                      Stack(
                        children: [
                          Image.asset("assets/bgtophome.png",
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: border(
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Tổng số câu hỏi'),
                                            Obx(() => Text(
                                                  checkingStringNull(
                                                      helpdeskViewModel
                                                          .rxHelpdeskModel
                                                          .value
                                                          .totalRecords
                                                          ?.toString()),
                                                  style: const TextStyle(
                                                      color: kBlueButton,
                                                      fontSize: 40),
                                                ))
                                          ],
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Image.asset(
                                              icon!,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Obx(() => GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                            ),
                                            itemCount: helpdeskViewModel
                                                .rxHelpdeskListStatistic
                                                .length,
                                            itemBuilder: (context, index) {
                                              var item = helpdeskViewModel
                                                      .rxHelpdeskListStatistic[
                                                  index];
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                    child: Text(item.name!,
                                                        style: CustomTextStyle
                                                            .robotow400s12TextStyle),
                                                  ),
                                                  Text(
                                                      item.total
                                                          .toString()
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))
                                                ],
                                              );
                                            },
                                          )),
                                    )
                                  ]),
                                ),
                                context),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: SizedBox(
                            height: 50,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 10, 10),
                                  child: Obx(() => ElevatedButton(
                                        style: helpdeskViewModel
                                                    .selectedChartButton
                                                    .value ==
                                                0
                                            ? activeButtonStyle
                                            : unActiveButtonStyle,
                                        onPressed: () async {
                                          helpdeskViewModel
                                              .postHelpdeskListAndStatistic();
                                          helpdeskViewModel
                                              .selectedChartButton(0);
                                        },
                                        child: const Text("Tình hình xử lý"),
                                      )),
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 10),
                                    child: Obx(
                                      () => ElevatedButton(
                                        style: helpdeskViewModel
                                                    .selectedChartButton
                                                    .value ==
                                                1
                                            ? activeButtonStyle
                                            : unActiveButtonStyle,
                                        onPressed: () async {
                                          helpdeskViewModel
                                              .getChartRecently();
                                          helpdeskViewModel
                                              .selectedChartButton(1);
                                        },
                                        child: const Text(
                                          "SL câu hỏi 5 ngày gần nhất",
                                          maxLines: 1,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )),
                      Obx(
                        () => chartItemForHelpDesk(
                          helpdeskViewModel.selectedChartButton.value,
                          helpdeskViewModel,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => HelpDeskList(
                                    header: header,
                                  ));
                            },
                            child:
                                buttonShowListScreen("Xem danh sách câu hỏi"),
                            style: bottomButtonStyle,
                          ),
                        ),
                      )
                    ])
                    : Center(child: loadingIcon()),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget chartItemForHelpDesk(int index, HelpdeskViewModel helpdeskViewModel) {
  if (helpdeskViewModel.rxHelpdeskListStatistic.isNotEmpty) {
    if (index == 0) {
      return Obx(() => HelpHeskChartWidget(
          key: UniqueKey(),
          listHelpDeskStatistic: helpdeskViewModel.rxHelpdeskListStatistic,
          helpdeskModel: helpdeskViewModel.rxHelpdeskModel.value));
    } else {
      return Obx(() => HelpDeskCollumChart(
            key: UniqueKey(),
            listHelpDeskStatistic: helpdeskViewModel.rxListRecen,
          ));
    }
  } else {
    return const SizedBox(
      height: 300,
    );
  }
}
