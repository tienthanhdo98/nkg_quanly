import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../const/const.dart';
import '../../../const/widget.dart';
import '../../../model/ChartModel.dart';
import '../../../model/analysis_report/preschool_chart_model.dart';

class AnalysisReportStackedChartWidget extends StatefulWidget {
  AnalysisReportStackedChartWidget(this.listEducationChart,{UniqueKey? key}) : super(key: key);

  final List<ChartChildItems>? listEducationChart;

  @override
  State<StatefulWidget> createState() => AnalysisReportStackedChartState();
}

class AnalysisReportStackedChartState extends State<AnalysisReportStackedChartWidget> {
  List<ChartChildItems>? listEducationChart;
  List<StackedChartModel> chartData = [];

  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    listEducationChart = widget.listEducationChart!;
    for (int i = 0; i < 12; i++) {
      chartData.add(
          StackedChartModel(listEducationChart![i].name!,num.parse(listEducationChart![i].items![0].value!), num.parse(listEducationChart![i].items![1].value!), num.parse(listEducationChart![i].items![2].value!))
      );
    }
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              legendChartCircleHozi('Mức độ 1', kBlueChart),
              legendChartCircleHozi('Mức độ 2', kGreenSign),
              legendChartCircleHozi('Mức độ 3', kOrangeSign),
            ],
          ),
          SizedBox(height: 300, child: _buildStackedColumn100Chart ()),
        ],
      ),
    );
  }

  /// Returns the cartesian stacked column 100 chart.
  SfCartesianChart _buildStackedColumn100Chart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelRotation: -60,
        maximumLabels: 5,
        labelStyle: TextStyle(),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.none,
          axisLine: const AxisLine(width: 0),

          majorTickLines: const MajorTickLines(size: 0)),
      series: _getStackedColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }


  List<ChartSeries<StackedChartModel, String>> _getStackedColumnSeries() {
    return <ChartSeries<StackedChartModel, String>>[
      StackedColumn100Series<StackedChartModel, String>(
          dataSource: chartData,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
          xValueMapper: (StackedChartModel sales, _) => sales.title,
          yValueMapper: (StackedChartModel sales, _) => sales.value1,
          pointColorMapper: (StackedChartModel sales, _) => kLightBlueSign,
      ),
      StackedColumn100Series<StackedChartModel, String>(
          dataSource: chartData,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
          xValueMapper: (StackedChartModel sales, _) => sales.title,
          yValueMapper: (StackedChartModel sales, _) => sales.value2,
          pointColorMapper: (StackedChartModel sales, _) => kGreenChart,
         ),
      StackedColumn100Series<StackedChartModel, String>(
          dataSource: chartData,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
          xValueMapper: (StackedChartModel sales, _) => sales.title,
          yValueMapper: (StackedChartModel sales, _) => sales.value3,
          pointColorMapper: (StackedChartModel sales, _) => kOrangeSign,
      ),
    ];
  }
}
