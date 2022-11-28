import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/ui/chart/calendar_work_widget.dart';
import 'package:nkg_quanly/ui/chart/procedure_profile_widget.dart';
import 'package:nkg_quanly/ui/chart/profile%20_widget.dart';
import 'package:nkg_quanly/ui/chart/report_widget.dart';
import 'package:nkg_quanly/ui/chart/workbook_widget.dart';

import '../../const/utils.dart';
import '../../const/widget.dart';
import '../home/home_screen.dart';
import '../home/home_search.dart';
import '../theme/theme_data.dart';
import 'birthday_widget.dart';
import 'booking_room_widget.dart';
import 'chart_viewmodel.dart';
import 'document_nonapproved _widget.dart';
import 'document_out_widget.dart';
import 'document_unprocess _widget.dart';
import 'mission _widget.dart';

class ChartScreen extends StatelessWidget {
  ChartScreen({Key? key}) : super(key: key);
  final chartViewModel = Get.put(ChartViewModel());

  @override
  Widget build(BuildContext context) {
    chartViewModel.getLatestEvent(loginViewModel.rxAccessTokenIoc.value);

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
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: 470,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Thêm khối thông tin",style: Theme.of(context).textTheme.headline3),
                                              const Padding(padding: EdgeInsets.only(top: 15)),
                                              GridView.count(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                // Create a grid with 2 columns. If you change the scrollDirection to
                                                // horizontal, this produces 2 rows.
                                                crossAxisCount: 3,
                                                childAspectRatio: 0.9,
                                                // Generate 100 widgets that display their index in the List.
                                                children: List.generate(list.length, (index) {
                                                  return InkWell(
                                                    onTap: () {

                                                    },
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          list[index].img!,
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            list[index].title!,
                                                            style: const TextStyle(fontSize: 12),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                                child: Divider(thickness: 1,),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                            (Set<MaterialState> states) {
                                                          if (states.contains(MaterialState.pressed)) {
                                                            return kLightBlueButton;
                                                          } else {
                                                            return kLightBlueButton;
                                                          } // Use the component's default.
                                                        },
                                                      ),
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ))
                                                    ),
                                                    onPressed: (){}, child: const Text("Lưu")),
                                                const Padding(padding: EdgeInsets.only(left: 15)),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                            (Set<MaterialState> states) {
                                                          if (states.contains(MaterialState.pressed)) {
                                                            return kVioletBg;
                                                          } else {
                                                            return kWhite;
                                                          } // Use the component's default.
                                                        },

                                                      ),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                          ))

                                                  ),
                                                    onPressed: (){
                                                  Get.back();
                                                }, child: const Text("Đóng",style: TextStyle(color: Colors.black),)),
                                              ],)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: styleEleveButtonWidget,
                                child: const Text("Thêm khối thông tin")),
                            Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: ElevatedButton(
                                  style: styleEleveButtonWidget,
                                    onPressed: () async {
                                      await chartViewModel.getListWidget(
                                          loginViewModel
                                              .rxAccessTokenIoc.value);
                                    },
                                    child: const Text("Khôi phục mặc định"))),
                            ElevatedButton(
                                onPressed: () {},
                                style:  styleEleveButtonWidget,
                                child: const Text("Gỡ toàn bộ")),
                          ],
                        ),
                      ),
                      Obx(() => Column(
                            children: listWidgetByUser(chartViewModel),
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

List<Widget> listWidgetByUser(ChartViewModel chartViewModel) {
  List<Widget> listWidget = [];
  for (var element in chartViewModel.rxListWidgetItem) {
    var widget = getWidgetByName(element.code!);
    listWidget.add(widget);
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


