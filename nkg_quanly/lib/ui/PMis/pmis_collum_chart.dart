import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../model/ChartModel.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/pmis_model/pmis_chart_model.dart';

class PmisCollumChartWidget extends StatefulWidget {
  PmisCollumChartWidget({UniqueKey? key, this.listPmisChartModel}) : super(key: key);

  final List<PmisChartModel>? listPmisChartModel;

  @override
  State<StatefulWidget> createState() => PmisCollumChartState();
}

class PmisCollumChartState extends State<PmisCollumChartWidget> {
  List<ChartSampleData> listCharData = [];
  List<PmisChartModel>? listPmisChartModel;
  @override
  void initState() {
    listPmisChartModel = widget.listPmisChartModel!;
    for (int i = 0; i < listPmisChartModel!.length; i++) {
      listCharData.add(
        ChartSampleData(
            x: listPmisChartModel![i].ten!,
            y: int.parse(listPmisChartModel![i].soLuong!),
            color: listColorChart[0]),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
        width: 0.5,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: ((ChartSampleData sales, _) => sales.color),
        dataLabelMapper: (ChartSampleData sales, _) => sales.y.toString(),
        dataLabelSettings: DataLabelSettings(
            isVisible: (listCharData.length < 12 ) ? true : false, textStyle: TextStyle(fontSize: 8)),
      )
    ];
  }
}
