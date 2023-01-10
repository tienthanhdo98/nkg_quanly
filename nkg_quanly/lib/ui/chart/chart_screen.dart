import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/main.dart';
import 'package:nkg_quanly/ui/chart/calendar_work_widget.dart';
import 'package:nkg_quanly/ui/chart/procedure_profile_widget.dart';
import 'package:nkg_quanly/ui/chart/profile%20_widget.dart';
import 'package:nkg_quanly/ui/chart/report_widget.dart';
import 'package:nkg_quanly/ui/chart/workbook_widget.dart';

import '../../const/utils.dart';
import '../../const/widget.dart';
import '../home/home_screen.dart';
import '../home/home_search.dart';
import '../home/list_all_item_kgs.dart';
import '../theme/theme_data.dart';
import 'birthday_widget.dart';
import 'booking_room_widget.dart';
import 'chart_viewmodel.dart';
import 'document_nonapproved _widget.dart';
import 'document_out_widget.dart';
import 'document_unprocess _widget.dart';
import 'mission _widget.dart';

class ChartScreen extends StatefulWidget {
  ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final chartViewModel = Get.put(ChartViewModel());
  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    chartViewModel.initDataHomeScreen();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kDarkGray,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(children: [
                        Image.asset(
                          "assets/bgtophome.png",
                          height: 250,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                  child: Image.asset("assets/ic_person.png"),
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: kViolet,
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Xin chào",
                                      style: TextStyle(color: kWhite),
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 0)),
                                    Text(
                                      checkingStringNull(loginViewModel
                                          .rxUserInfoModel.value.name),
                                      style: const TextStyle(
                                          color: kWhite, fontSize: 24),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => HomeSearch());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: kPink,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.asset(
                                      'assets/icons/ic_search_white.png',
                                      width: 20,
                                      height: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 130, 20, 0),
                          child: border(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 5, 15),
                                      child: Obx(() => Text(
                                            checkingStringNull(chartViewModel
                                                .rxEventDes.value.name),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 40),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/anhdemo.jpeg',
                                          width: 150,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        Flexible(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Obx(
                                                () => Text(
                                                  checkingStringNull(
                                                      chartViewModel.rxEventDes
                                                          .value.description),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              context),
                        )
                      ]),
                      SizedBox(
                        height: 50,
                        child: ListView(
                          padding: const EdgeInsets.only(
                              left: 15, top: 15, right: 15),
                          scrollDirection: Axis.horizontal,
                          children: [
                            ElevatedButton(
                                key: _globalKey,
                                onPressed: () {
                                  chartViewModel.isShowCase.value =
                                      !chartViewModel.isShowCase.value;
                                  chartViewModel.setPositionWidget(_globalKey);
                                },
                                style: styleEleveButtonWidget,
                                child: const Text("Thêm khối thông tin")),
                            Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: ElevatedButton(
                                    style: styleEleveButtonWidget,
                                    onPressed: () async {
                                      chartViewModel.isShowCase.value = false;
                                      await chartViewModel.getListWidgetKgs(
                                          loginViewModel
                                              .rxAccessTokenIoc.value);
                                      setState(() {
                                        chartViewModel.restoreCheckedWidget();
                                      });
                                    },
                                    child: const Text("Khôi phục mặc định"))),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    chartViewModel.isShowCase.value = false;
                                    chartViewModel.clearCheckedWidgetItem();
                                  });
                                },
                                style: styleEleveButtonWidget,
                                child: const Text("Gỡ toàn bộ")),
                          ],
                        ),
                      ),
                      Obx(() => Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                  children: listWidgetByUser(chartViewModel)),
                              if (chartViewModel.isShowCase.value)
                                Stack(
                                  children: [
                                    Positioned(
                                      left:
                                          chartViewModel.positionWidget.value -
                                              15,
                                      child: CustomPaint(
                                        painter: TrianglePainter(
                                          strokeColor: Colors.white,
                                          strokeWidth: 10,
                                          paintingStyle: PaintingStyle.fill,
                                        ),
                                        child: const SizedBox(
                                          height: 16,
                                          width: 32,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 10),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: StatefulBuilder(
                                          builder: (context, setStateDialog) {
                                        return ListView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: [
                                            Text("Thêm khối thông tin",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3),
                                            const Divider(
                                              thickness: 1,
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            GridView.count(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              crossAxisCount:
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .width >=
                                                          390)
                                                      ? 4
                                                      : 3,
                                              // childAspectRatio: 0.9,
                                              children: List.generate(
                                                  chartViewModel
                                                      .rxListWidgetItem
                                                      .length, (index) {
                                                return Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setStateDialog(() {
                                                          if (chartViewModel.getCheckedWidgetItem(
                                                              chartViewModel
                                                                      .rxListWidgetItem[
                                                                          index]
                                                                      .id! +
                                                                  chartViewModel
                                                                      .rxListWidgetItem[
                                                                          index]
                                                                      .code!)) {
                                                            chartViewModel.setCheckedWidgetItem(
                                                                chartViewModel
                                                                        .rxListWidgetItem[
                                                                            index]
                                                                        .id! +
                                                                    chartViewModel
                                                                        .rxListWidgetItem[
                                                                            index]
                                                                        .code!,
                                                                false);
                                                          } else {
                                                            chartViewModel.setCheckedWidgetItem(
                                                                chartViewModel
                                                                        .rxListWidgetItem[
                                                                            index]
                                                                        .id! +
                                                                    chartViewModel
                                                                        .rxListWidgetItem[
                                                                            index]
                                                                        .code!,
                                                                true);
                                                          }
                                                        });
                                                      },
                                                      child: Stack(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8,
                                                                  right: 8),
                                                          child: (list.firstWhereOrNull((element) => element.title! == chartViewModel.rxListWidgetItem[index].name!) != null)
                                                              ? Image.asset(
                                                                  list.firstWhereOrNull((element) => element.title! == chartViewModel.rxListWidgetItem[index].name!)!.img!,
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : CachedNetworkImage(
                                                                  width: 50,
                                                                  height: 50,
                                                                  imageUrl:
                                                                      "http://123.31.31.237:8001/${chartViewModel.rxListWidgetItem[index].image ?? ""}",
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image: DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover),
                                                                    ),
                                                                  ),
                                                                  // placeholder: (context, url) => const CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                ),
                                                        ),
                                                        if (chartViewModel.getCheckedWidgetItem(
                                                            chartViewModel
                                                                    .rxListWidgetItem[
                                                                        index]
                                                                    .id! +
                                                                chartViewModel
                                                                    .rxListWidgetItem[
                                                                        index]
                                                                    .code!))
                                                          Positioned(
                                                            top: 0,
                                                            right: 0,
                                                            width: 20,
                                                            height: 20,
                                                            child: Checkbox(
                                                              checkColor:
                                                                  Colors.white,
                                                              // fillColor: kWhite,
                                                              value: true,
                                                              onChanged: (bool?
                                                                  value) {
                                                                setStateDialog(
                                                                    () {
                                                                  chartViewModel.setCheckedWidgetItem(
                                                                      chartViewModel
                                                                          .rxListWidgetItem[
                                                                              index]
                                                                          .id!,
                                                                      false);
                                                                });
                                                              },
                                                            ),
                                                          )
                                                      ]),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        chartViewModel
                                                            .rxListWidgetItem[
                                                                index]
                                                            .name!,
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .resolveWith<
                                                                    Color>(
                                                          (Set<MaterialState>
                                                              states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .pressed)) {
                                                              return kVioletBg;
                                                            } else {
                                                              return kWhite;
                                                            } // Use the component's default.
                                                          },
                                                        ),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ))),
                                                    onPressed: () {
                                                      chartViewModel.isShowCase
                                                              .value =
                                                          !chartViewModel
                                                              .isShowCase.value;
                                                      for (int i = 0;
                                                          i <
                                                              chartViewModel
                                                                  .listBeforeClose
                                                                  .length;
                                                          i++) {
                                                        chartViewModel.setCheckedWidgetItem(
                                                            chartViewModel
                                                                    .rxListWidgetItem[
                                                                        i]
                                                                    .id! +
                                                                chartViewModel
                                                                    .rxListWidgetItem[
                                                                        i]
                                                                    .code!,
                                                            chartViewModel
                                                                .listBeforeClose[i]);
                                                      }
                                                    },
                                                    child: const Text(
                                                      "Đóng",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15)),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .resolveWith<
                                                                    Color>(
                                                          (Set<MaterialState>
                                                              states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .pressed)) {
                                                              return kBlueButton;
                                                            } else {
                                                              return kBlueButton;
                                                            } // Use the component's default.
                                                          },
                                                        ),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ))),
                                                    onPressed: () {
                                                      chartViewModel.isShowCase
                                                              .value =
                                                          !chartViewModel
                                                              .isShowCase.value;
                                                    },
                                                    child: const Text("Lưu")),
                                              ],
                                            )
                                          ],
                                        );
                                      }),
                                    )
                                  ],
                                ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

List<Widget> listWidgetByUser(ChartViewModel chartViewModel) {
  List<Widget> listWidget = [];
  for (var element in chartViewModel.rxListWidgetItem) {
    if (chartViewModel.getCheckedWidgetItem(element.id! + element.code!)) {
      var widget = getWidgetByName(element.code!);
      listWidget.add(widget);
    }
  }
  return listWidget;
}

Widget getWidgetByName(String widgetName) {
  Widget resWidget = const SizedBox();
  switch (widgetName) {
    case "app-widget-calendar":
      {
        resWidget = CalendarWorkWidget();
      }
      break;
    case "app-widget-text-unprocessed":
      {
        resWidget = DocumentUnProcessWidget();
      }
      break;
    case "app-widget-document-in-non-aprroved":
      {
        resWidget = DocumentNonapprovedWidget();
      }
      break;
    case "app-widget-profile-submission":
      {
        resWidget = ProfileWidget();
      }
      break;
    case "app-widget-document-ready":
      {
        resWidget = DocumentOutWidget();
      }
      break;
    case "app-widget-mettingschedule":
      {
        resWidget = BookingRoomWidget();
      }
      break;
    case "app-widget-mission":
      {
        resWidget = MissionWidget();
      }
      break;
    case "app-widget-administrative-records":
      {
        resWidget = ProcedureProfileWidget();
      }
      break;
    case "app-widget-report-view":
      {
        resWidget = ReportWidget();
      }
      break;
    case "app-widget-work-book":
      {
        resWidget = WorkBookWidget();
      }
      break;
    case "app-widget-birthday":
      {
        resWidget = BirthdayWidget();
      }
      break;
  }
  return resWidget;
}
