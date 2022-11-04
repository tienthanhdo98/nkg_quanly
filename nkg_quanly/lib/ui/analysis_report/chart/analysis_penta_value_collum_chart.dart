import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../const/const.dart';
import '../../../const/widget.dart';
import '../../../model/ChartModel.dart';
import '../../../model/analysis_report/preschool_chart_model.dart';

class AnalysisPentaValueCollumChartWidget extends StatefulWidget {
  const AnalysisPentaValueCollumChartWidget({UniqueKey? key, this.listChart})
      : super(key: key);

  final List<ChartChildItems>? listChart;

  @override
  State<StatefulWidget> createState() => AnalysisPentaValueCollumChartState();
}

class AnalysisPentaValueCollumChartState
    extends State<AnalysisPentaValueCollumChartWidget> {
  List<ChartChildItems> listChart = [];
  List<ChartCollumThreeValueModel> listCollumCharData = [];
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    listChart = widget.listChart!;
    _tooltipBehavior = TooltipBehavior(enable: true);

    for (int i = 0; i < listChart.length; i++) {
      listCollumCharData.add(
        ChartCollumThreeValueModel(
            title: listChart[i].name!,
            value1: double.parse(listChart[i].items![0].value!),
            value2: double.parse(listChart[i].items![1].value!),
            value3: double.parse(listChart[i].items![2].value!),
            value4: double.parse(listChart[i].items![3].value!),
            value5: double.parse(listChart[i].items![4].value!)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                legendChart("Trung thực", kBlueButton),
                const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                legendChart("Chăm chỉ", kOrange),
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(15, 15, 0, 0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                legendChart("Yêu nước", kGreenChart),
                const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                legendChart("Trách nhiệm", kRedChart),
                const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                legendChart("Nhân ái", kRedChart),
              ],
            )
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

  List<ColumnSeries<ChartCollumThreeValueModel, String>>
      _getDefaultColumnSeries() {
    return <ColumnSeries<ChartCollumThreeValueModel, String>>[
      ColumnSeries<ChartCollumThreeValueModel, String>(
          dataSource: listCollumCharData,
          width: 0.7,
          spacing: 0.1,
          xValueMapper: (ChartCollumThreeValueModel sales, _) => sales.title,
          yValueMapper: (ChartCollumThreeValueModel sales, _) => sales.value1,
          pointColorMapper: ((ChartCollumThreeValueModel sales, _) =>
              kBlueButton),
          dataLabelMapper: (ChartCollumThreeValueModel sales, _) =>
              sales.toString(),
          dataLabelSettings: const DataLabelSettings(
              isVisible: false, textStyle: TextStyle(fontSize: 8)),
          name: "Trung thực"),
      ColumnSeries<ChartCollumThreeValueModel, String>(
          dataSource: listCollumCharData,
          width: 0.7,
          spacing: 0.1,
          xValueMapper: (ChartCollumThreeValueModel sales, _) => sales.title,
          yValueMapper: (ChartCollumThreeValueModel sales, _) => sales.value2,
          pointColorMapper: ((ChartCollumThreeValueModel sales, _) => kOrange),
          dataLabelMapper: (ChartCollumThreeValueModel sales, _) =>
              sales.toString(),
          dataLabelSettings: const DataLabelSettings(
              isVisible: false, textStyle: TextStyle(fontSize: 8)),
          name: "Chăm chỉ"),
      ColumnSeries<ChartCollumThreeValueModel, String>(
          dataSource: listCollumCharData,
          width: 0.7,
          spacing: 0.1,
          xValueMapper: (ChartCollumThreeValueModel sales, _) => sales.title,
          yValueMapper: (ChartCollumThreeValueModel sales, _) => sales.value3,
          pointColorMapper: ((ChartCollumThreeValueModel sales, _) =>
              kGreenChart),
          dataLabelMapper: (ChartCollumThreeValueModel sales, _) =>
              sales.toString(),
          dataLabelSettings: const DataLabelSettings(
              isVisible: false, textStyle: TextStyle(fontSize: 8)),
          name: "Yêu nước"),
      ColumnSeries<ChartCollumThreeValueModel, String>(
          dataSource: listCollumCharData,
          width: 0.7,
          spacing: 0.1,
          xValueMapper: (ChartCollumThreeValueModel sales, _) => sales.title,
          yValueMapper: (ChartCollumThreeValueModel sales, _) => sales.value4,
          pointColorMapper: ((ChartCollumThreeValueModel sales, _) =>
              kRedChart),
          dataLabelMapper: (ChartCollumThreeValueModel sales, _) =>
              sales.toString(),
          dataLabelSettings: const DataLabelSettings(
              isVisible: false, textStyle: TextStyle(fontSize: 8)),
          name: "Trách nhiệm"),
      ColumnSeries<ChartCollumThreeValueModel, String>(
          dataSource: listCollumCharData,
          width: 0.7,
          spacing: 0.1,
          xValueMapper: (ChartCollumThreeValueModel sales, _) => sales.title,
          yValueMapper: (ChartCollumThreeValueModel sales, _) => sales.value4,
          pointColorMapper: ((ChartCollumThreeValueModel sales, _) =>
          kBluePriority),
          dataLabelMapper: (ChartCollumThreeValueModel sales, _) =>
              sales.toString(),
          dataLabelSettings: const DataLabelSettings(
              isVisible: false, textStyle: TextStyle(fontSize: 8)),
          name: "Nhân ái")
    ];
  }
}
