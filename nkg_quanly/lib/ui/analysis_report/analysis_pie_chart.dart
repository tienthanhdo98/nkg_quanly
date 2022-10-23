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

class AnalysisChartWidget extends StatefulWidget {
  AnalysisChartWidget({UniqueKey? key, this.listPreSchoolChartItems})
      : super(key: key);

  final List<PreSchoolChartItems>? listPreSchoolChartItems;

  @override
  State<StatefulWidget> createState() => AnalysisChartState();
}

class AnalysisChartState extends State<AnalysisChartWidget> {
  List<PieCharData> listPieChartData = [];
  List<PreSchoolChartItems> listPreSchoolChartItems = [];
  List<ChartSampleData> listCollumCharData = [];
  List<PmisChartModel>? listCollumChartModel;
  bool isPieChart = false;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    var total = 0;
    listPreSchoolChartItems =  widget.listPreSchoolChartItems!;

    listPreSchoolChartItems.removeWhere((element) => element.value?.isNum != true );
    if (listPreSchoolChartItems.length > 6) {
      isPieChart = false;
      for (int i = 0; i < listPreSchoolChartItems.length; i++) {
        listCollumCharData.add(
          ChartSampleData(
              x: listPreSchoolChartItems[i].name!,
              y: double.parse(listPreSchoolChartItems[i].value!).toInt(),
              color: listColorChart[0]),
        );
      }
    } else {
      isPieChart = true;
      for (int i = 0; i < listPreSchoolChartItems.length; i++) {

          total += int.parse(listPreSchoolChartItems[i].value!);
      }
      for (int i = 0; i < listPreSchoolChartItems!.length; i++) {
          listPieChartData.add(PieCharData(
              title: calcuPercen(
                  int.parse(listPreSchoolChartItems[i].value!), total),
              value: int.parse(listPreSchoolChartItems[i].value!),
              color: listColorChart[i]));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: (isPieChart == true)
          ? Row(
              children: [
                SizedBox(
                    height: 200, width: 200, child: _buildGroupingPieChart()),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listPreSchoolChartItems!.length,
                      itemBuilder: (_, index) {
                        var item = listPreSchoolChartItems![index].name;
                        return legendChartCircleVerti(
                            item!, listColorChart[index]);
                      }),
                )
              ],
            )
          : Padding(
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

  //pie chart
  SfCircularChart _buildGroupingPieChart() {
    return SfCircularChart(
      margin: EdgeInsets.zero,
      series: _getGroupingPieSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<PieSeries<PieCharData, String>> _getGroupingPieSeries() {
    return <PieSeries<PieCharData, String>>[
      PieSeries<PieCharData, String>(
          radius: '100%',
          dataLabelMapper: (PieCharData data, _) =>
              (data.title != "0%") ? data.title : " ",
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          dataSource: listPieChartData,
          startAngle: 100,
          endAngle: 100,

          /// To enable and specify the group mode for pie chart.
          xValueMapper: (PieCharData data, _) => data.title,
          yValueMapper: (PieCharData data, _) => data.value,
          pointColorMapper: ((PieCharData sales, _) => sales.color)),
    ];
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
        dataLabelSettings: DataLabelSettings(
            isVisible: (listCollumCharData.length < 12) ? true : false,
            textStyle: TextStyle(fontSize: 8)),
      )
    ];
  }
}
