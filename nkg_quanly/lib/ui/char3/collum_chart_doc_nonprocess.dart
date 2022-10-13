import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../model/ChartModel.dart';
import '../../model/document_unprocess/document_filter.dart';

class CollumChartWidget extends StatefulWidget {
  CollumChartWidget({UniqueKey? key, this.documentFilterModel})
      : super(key: key);
  DocumentFilterModel? documentFilterModel;

  @override
  State<StatefulWidget> createState() => CollumChartReportState();
}

class CollumChartReportState extends State<CollumChartWidget> {
  List<ChartSampleData> listCharData = [];
  DocumentFilterModel? documentFilterModel;

  @override
  void initState() {
    documentFilterModel = widget.documentFilterModel;
    List<FilterItems> listQuantity = documentFilterModel!.items!;
    print(listQuantity.length);
    for (int i = 0; i < listQuantity.length; i++) {
      listCharData.add(
        ChartSampleData(
            x: listQuantity[i].name!,
            y: listQuantity[i].quantity!,
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
