import 'package:flutter/material.dart';

import '../chart/collum_red_chart.dart';
import '../chart/column_chart.dart';
import '../chart/pie_chart.dart';
import '../chart/sline_chart.dart';
import '../chart/calendar_work_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 200,
                    height: 150,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CalendarWorkWidget(),
           ColumnRedChart(),
           PieChart(),
           ColumnChart(),
           SLineChart(),
          CalendarWorkWidget(),
           PieChart(),
        ],
      ),
    );
  }
}


