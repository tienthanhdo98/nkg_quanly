import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../const/const.dart';
import '../../../../const/widget.dart';
import '../../../../model/ChartModel.dart';
import '../../../../model/profile_procedure_model/profile_proc_chart_model.dart';

class ProfileProcChartWidget extends StatefulWidget {
  const ProfileProcChartWidget(this.listPmisChartModel, {UniqueKey? key})
      : super(key: key);

  final List<ProfileProcChartModel>? listPmisChartModel;

  @override
  State<StatefulWidget> createState() => ProfileProcChartState();
}

class ProfileProcChartState extends State<ProfileProcChartWidget> {
  List<ChartCollumTwoValueModel> listCharData = [];
  List<ProfileProcChartModel>? listPmisChartModel;

  @override
  void initState() {
    listPmisChartModel = widget.listPmisChartModel!;
    for (int i = 0; i < listPmisChartModel!.length; i++) {
      listCharData.add(
        ChartCollumTwoValueModel(
            title: listPmisChartModel![i].ten!,
            value1: listPmisChartModel![i].trongHan!,
            value2: listPmisChartModel![i].quaHan!,
            color: listColorChart[i]),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            legendChartCircleHozi('Trong hạn', kBlueChart),
            legendChartCircleHozi('Quá hạn', kGreenSign),
          ],
        ),
        SizedBox(height: 300, child: _buildDefaultColumnChart()),

      ],
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

  List<ColumnSeries<ChartCollumTwoValueModel, String>>
      _getDefaultColumnSeries() {
    return <ColumnSeries<ChartCollumTwoValueModel, String>>[
      ColumnSeries<ChartCollumTwoValueModel, String>(
        dataSource: listCharData,
        width: 0.7,
        spacing: 0.1,
        xValueMapper: (ChartCollumTwoValueModel sales, _) => sales.title,
        yValueMapper: (ChartCollumTwoValueModel sales, _) => sales.value1,
        pointColorMapper: ((ChartCollumTwoValueModel sales, _) => kBlueChart),
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 8)),
      ),
      ColumnSeries<ChartCollumTwoValueModel, String>(
        dataSource: listCharData,
        width: 0.7,
        spacing: 0.1,
        xValueMapper: (ChartCollumTwoValueModel sales, _) => sales.title,
        yValueMapper: (ChartCollumTwoValueModel sales, _) => sales.value2,
        pointColorMapper: ((ChartCollumTwoValueModel sales, _) => kGreenSign),
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 8)),
      )
    ];
  }
}
