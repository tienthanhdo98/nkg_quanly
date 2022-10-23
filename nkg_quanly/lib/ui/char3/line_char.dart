import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../model/document_unprocess/document_filter.dart';

class LineCharWidget extends StatefulWidget {
  LineCharWidget({UniqueKey? key, this.documentFilterModel}) : super(key: key);

  final DocumentFilterModel? documentFilterModel;

  @override
  State<StatefulWidget> createState() => LineCharWidgetState();
}

class LineCharWidgetState extends State<LineCharWidget> {
  List<_ChartData> listChartData = [];
  DocumentFilterModel? documentFilterModel;
  List<FilterItems>? listQuantity;

  @override
  void initState() {
    documentFilterModel = widget.documentFilterModel;
    listQuantity = documentFilterModel!.items!;
    print(listQuantity!.length);
    for (int i = 0; i < listQuantity!.length; i++) {
      listChartData
          .add(_ChartData(listQuantity![i].name!, listQuantity![i].quantity!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: SizedBox(height: 200, child: _buildDefaultLineChart()),
    );
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 1)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, String>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, String>>[
      LineSeries<_ChartData, String>(
          animationDuration: 1000,
          dataSource: listChartData,
          width: 2,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          color: kRedChart,
          markerSettings:
              const MarkerSettings(isVisible: true, color: kRedChart)),
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final int y;
}
