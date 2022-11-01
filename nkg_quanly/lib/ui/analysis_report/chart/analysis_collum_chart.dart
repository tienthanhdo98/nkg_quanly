import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../const/const.dart';
import '../../../model/ChartModel.dart';
import '../../../model/analysis_report/preschool_chart_model.dart';


class AnalysisCollumChartWidget extends StatefulWidget {

  AnalysisCollumChartWidget({UniqueKey? key, this.listChart})
      : super(key: key);

  final List<ChartChildItems>? listChart;


  @override
  State<StatefulWidget> createState() => AnalysisCollumChartState();
}

class AnalysisCollumChartState extends State<AnalysisCollumChartWidget> {
  List<ChartChildItems> listChart = [];
  List<ChartCollumData> listCollumCharData = [];
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    listChart = widget.listChart!;
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);

      for (int i = 0; i < listChart.length; i++) {
        listCollumCharData.add(
          ChartCollumData(
              x: listChart[i].name!,
              y: double.parse(listChart[i].value!),
              color: listColorChart[0]),
        );
      }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child:  Padding(
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

  List<ColumnSeries<ChartCollumData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartCollumData, String>>[
      ColumnSeries<ChartCollumData, String>(
        dataSource: listCollumCharData,
        width: 0.5,
        xValueMapper: (ChartCollumData sales, _) => sales.x,
        yValueMapper: (ChartCollumData sales, _) => sales.y,
        pointColorMapper: ((ChartCollumData sales, _) => sales.color),
        dataLabelMapper: (ChartCollumData sales, _) => sales.y.toString(),
        dataLabelSettings: const DataLabelSettings(
            isVisible: false ,
            textStyle: TextStyle(fontSize: 8)),
      )
    ];
  }
}
