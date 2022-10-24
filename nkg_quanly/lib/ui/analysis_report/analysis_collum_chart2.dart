import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/document_unprocess/document_filter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/ChartModel.dart';
import '../../model/analysis_report/preschool_chart_model.dart';
import '../../model/helpdesk_model/helpdesk_model.dart';
import '../../model/pmis_model/pmis_chart_model.dart';
import 'analysis_report_type_screen.dart';

class AnalysisChartCollum2Widget extends StatefulWidget {
  AnalysisChartCollum2Widget({UniqueKey? key,})
      : super(key: key);



  @override
  State<StatefulWidget> createState() => AnalysisChartState();
}

class AnalysisChartState extends State<AnalysisChartCollum2Widget> {
  List<PieCharData> listPieChartData = [];
  List<chart> listPreSchoolChartItems = [];
  List<ChartSampleData> listCollumCharData = [];
  List<PmisChartModel>? listCollumChartModel;
  bool isPieChart = false;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);

    for (int i = 0; i < 5; i++) {
      listCollumCharData.add(
        ChartSampleData(
            x: "test ${i}",
            y: (20+i*2) + 20,
            color: listColorChart[i]),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 300, child: _buildDefaultColumnChart()),
                ],
              ),
            ),
    );
  }


  //collum chart
  SfCartesianChart _buildDefaultColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelRotation: -60,
        maximumLabels: 5,
        labelStyle: const TextStyle(fontSize: 10),
        majorGridLines: const MajorGridLines(width: 1),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getDefaultColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: listCollumCharData,
        width: 0.5,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: ((ChartSampleData sales, _) => sales.color),
        dataLabelMapper: (ChartSampleData sales, _) => sales.y.toString(),
        dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            textStyle: TextStyle(fontSize: 8)),
      )
    ];
  }
}
