import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../const/const.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../../model/ChartModel.dart';
import '../../../model/analysis_report/preschool_chart_model.dart';
import '../../../model/pmis_model/pmis_chart_model.dart';

class AnalysisPieChartWidget extends StatefulWidget {
  AnalysisPieChartWidget({UniqueKey? key, this.listChart})
      : super(key: key);

  final List<ChartChildItems>? listChart;

  @override
  State<StatefulWidget> createState() => AnalysisPieChartState();
}

class AnalysisPieChartState extends State<AnalysisPieChartWidget> {
  List<PieCharData> listPieChartData = [];
  List<ChartChildItems> listPreSchoolChartItems = [];
  List<ChartSampleData> listCollumCharData = [];
  List<PmisChartModel>? listCollumChartModel;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    var total = 0;
    listPreSchoolChartItems =  widget.listChart!;

    listPreSchoolChartItems.removeWhere((element) => element.value?.isNum != true );

      for (int i = 0; i < listPreSchoolChartItems.length; i++) {

          total += int.parse(listPreSchoolChartItems[i].value!);
      }
      for (int i = 0; i < listPreSchoolChartItems.length; i++) {
          listPieChartData.add(PieCharData(
              title: calcuPercen(
                  int.parse(listPreSchoolChartItems[i].value!), total),
              value: int.parse(listPreSchoolChartItems[i].value!),
              color: listColorChart[i]));
      }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
              children: [
                SizedBox(
                    height: 200, width: 200, child: _buildGroupingPieChart()),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listPreSchoolChartItems.length,
                      itemBuilder: (_, index) {
                        var item = listPreSchoolChartItems![index].name;
                        return legendChartCircleVerti(
                            item!, listColorChart[index]);
                      }),
                )
              ],
            )

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
}
