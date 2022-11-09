import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/ui/chart/calendar_work_widget.dart';
import 'package:nkg_quanly/ui/chart/procedure_profile_widget.dart';
import 'package:nkg_quanly/ui/chart/profile%20_widget.dart';
import 'package:nkg_quanly/ui/chart/report_widget.dart';
import 'package:nkg_quanly/ui/chart/workbook_widget.dart';
import 'birthday_widget.dart';
import 'booking_room_widget.dart';
import 'document_nonapproved _widget.dart';
import 'document_out_widget.dart';
import 'document_unprocess _widget.dart';
import 'mission _widget.dart';



class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kDarkGray,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Theme.of(context).dividerColor,
                        ))),
                width: double.infinity,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/logo.png",
                      width: 200,
                      height: 150,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
