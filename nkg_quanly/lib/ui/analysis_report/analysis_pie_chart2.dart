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
import 'analysis_report_type_screen.dart';

class AnalysisChart2Widget extends StatefulWidget {
  AnalysisChart2Widget({UniqueKey? key, })
      : super(key: key);



  @override
  State<StatefulWidget> createState() => AnalysisChartState();
}

class AnalysisChartState extends State<AnalysisChart2Widget> {
  List<PieCharData> listPieChartData = [];
  List<chart> listPreSchoolChartItems = [];
  List<ChartSampleData> listCollumCharData = [];
  List<PmisChartModel>? listCollumChartModel;
  bool isPieChart = false;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    var total = 100;


    for (int i = 0; i < 4; i++) {
      listPieChartData.add(PieCharData(
          title: calcuPercen(int.parse("25"), total),
          value: int.parse("25"),
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
            SizedBox(height: 200, width: 200, child: _buildGroupingPieChart()),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    return legendChartCircleVerti("test ${index+1}", listColorChart[index]);
                  }),
            )
          ],
        ));
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
