import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../model/ChartModel.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/helpdesk_model/helpdesk_model.dart';

class HelpDeskCollumChart extends StatefulWidget {
  HelpDeskCollumChart(
      {UniqueKey? key, this.listHelpDeskStatistic})
      : super(key: key);

  final List<HelpDeskStatistic>? listHelpDeskStatistic;

  @override
  State<StatefulWidget> createState() => CollumChartReportState();
}

class CollumChartReportState extends State<HelpDeskCollumChart> {
  List<ChartSampleData> listCharData = [];
  DocumentFilterModel? documentFilterModel;

  @override
  void initState() {
    for (int i = 0; i < widget.listHelpDeskStatistic!.length; i++) {
      listCharData.add(
        ChartSampleData(
            x: widget.listHelpDeskStatistic![i].name!,
            y: widget.listHelpDeskStatistic![i].total!,
            color: listColorChart[i]),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 300, child: _buildDefaultColumnChart()),
        ],
      ),
    );
  }

  SfCartesianChart _buildDefaultColumnChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          labelRotation: -60,
          labelStyle: TextStyle(),
          majorGridLines: const MajorGridLines(width: 1),
        ),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            labelFormat: '{value}',
            majorTickLines: const MajorTickLines(size: 0)),
        series: _getDefaultColumnSeries());
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: listCharData,
        width: 0.2,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: ((ChartSampleData sales, _) => sales.color),
        dataLabelSettings: const DataLabelSettings(
            isVisible: false, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}
