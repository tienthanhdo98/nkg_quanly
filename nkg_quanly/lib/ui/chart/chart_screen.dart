import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/chart/sline_chart2.dart';

import '../chart/column_chart2.dart';
import '../chart/doughnut_chart.dart';
import '../chart/work_schedule.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              const WorkSchedule(),
              SLineChart2(),
              DoughnutChart(),
              ColumnChart2()
            ],
          ),
        ),
      ),
    );
  }
}
