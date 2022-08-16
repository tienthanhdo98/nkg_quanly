import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/chart/sline_chart2.dart';

import '../../const.dart';
import '../chart/column_chart2.dart';
import '../chart/doughnut_chart.dart';
import '../chart/work_schedule.dart';

class ChartScreen extends StatelessWidget{
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(child: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 80,
            color: Theme.of(context).cardColor,
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
          const WorkSchedule(),
          SLineChart2(),
          DoughnutChart(),
          ColumnChart2()

        ],),
      ),),);
  }

}