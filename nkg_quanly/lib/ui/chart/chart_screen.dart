import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/ui/chart/calendar_work_widget.dart';
import 'package:nkg_quanly/ui/chart/procedure_profile_widget.dart';
import 'package:nkg_quanly/ui/chart/profile%20_widget.dart';
import 'package:nkg_quanly/ui/chart/report_widget.dart';
import 'package:nkg_quanly/ui/chart/workbook_widget.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../home/home_search.dart';
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
                                  child: const Icon(Icons.person),
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: kViolet,
                                    borderRadius: BorderRadius.circular(25),
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
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 15, 5, 15),
                                          child: Text(
                                            'Thông báo khẩn',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          )),
                                      Image.asset(
                                        'assets/icons/ic_speaker.png',
                                        width: 24,
                                        height: 24,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 40),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/anhdemo.png',
                                          width: 150,
                                          height: 100,
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
                      CalendarWorkWidget(),
                      DocumentUnProcessWidget(),
                      DocumentNonapprovedWidget(),
                      ProfileWidget(),
                      DocumentOutWidget(),
                      BookingRoomWidget(),
                      MissionWidget(),
                      ProcedureProfileWidget(),
                      ReportWidget(),
                      WorkBookWidget(),
                      BirthdayWidget()
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
