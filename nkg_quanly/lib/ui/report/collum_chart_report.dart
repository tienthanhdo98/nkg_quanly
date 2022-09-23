import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/api.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/document_unprocess/document_filter.dart';

class CollumChartReport extends StatefulWidget {
  CollumChartReport({ this.documentFilterModel});
  final DocumentFilterModel? documentFilterModel;

  @override
  State<StatefulWidget> createState() => CollumChartReportState();
}

class CollumChartReportState extends State<CollumChartReport> {

  List<ChartSampleData> listCharData = [];
  DocumentFilterModel? documentFilterModel;

  @override
  void initState() {
    documentFilterModel = widget.documentFilterModel;
    List<FilterItems> listQuantity = documentFilterModel!.items!;

    listCharData.add(
      ChartSampleData(x: listQuantity[0].name!, y: listQuantity[0].quantity!, color:  kOrange),
    );
    listCharData.add(
      ChartSampleData(x: listQuantity[1].name!, y: listQuantity[1].quantity!, color:  kViolet),
    );
    listCharData.add(
      ChartSampleData(x: listQuantity[2].name!, y: listQuantity[2].quantity!, color: kBlueChart),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 230, child: _buildDefaultColumnChart()),
        ],
      ),
    );
  }

  SfCartesianChart _buildDefaultColumnChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
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
        width: 0.4,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: ((ChartSampleData sales, _) => sales.color),
        dataLabelSettings: const DataLabelSettings(
            isVisible: false, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}
