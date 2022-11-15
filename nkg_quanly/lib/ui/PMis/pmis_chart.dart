import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/ChartModel.dart';
import '../../model/pmis_model/pmis_chart_model.dart';

class PmisChartWidget extends StatefulWidget {
  PmisChartWidget({UniqueKey? key, this.listPmisChartModel}) : super(key: key);

  final List<PmisChartModel>? listPmisChartModel;

  @override
  State<StatefulWidget> createState() => PmisChartWidgetState();
}

class PmisChartWidgetState extends State<PmisChartWidget> {
  List<PieCharData> listChartData = [];
  List<PmisChartModel>? listPmisChartModel;

  @override
  void initState() {
    var total = 0;
    listPmisChartModel = widget.listPmisChartModel!;
    for (int i = 0; i < listPmisChartModel!.length; i++) {
      total += int.parse(listPmisChartModel![i].soLuong!);
    }
    for (int i = 0; i < listPmisChartModel!.length; i++) {
      listChartData.add(PieCharData(
          title: calcuPercen(int.parse(listPmisChartModel![i].soLuong!), total),
          value: int.parse(listPmisChartModel![i].soLuong!),
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
                physics: NeverScrollableScrollPhysics(),
                itemCount: listPmisChartModel!.length,
                itemBuilder: (_, index) {
                  var item = listPmisChartModel![index].ten;
                  return legendChartCircleVerti(item!, listColorChart[index]);
                }),
          )
        ],
      ),
    );
  }

  SfCircularChart _buildGroupingPieChart() {
    return SfCircularChart(
      margin: EdgeInsets.zero,
      series: _getGroupingPieSeries(),
      // tooltipBehavior: _tooltipBehavior,
    );
  }

  List<PieSeries<PieCharData, String>> _getGroupingPieSeries() {
    return <PieSeries<PieCharData, String>>[
      PieSeries<PieCharData, String>(
          radius: '100%',
          dataLabelMapper: (PieCharData data, _) => (data.title != "0%") ?  data.title : " ",
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          dataSource: listChartData,
          startAngle: 100,
          endAngle: 100,

          /// To enable and specify the group mode for pie chart.
          pointColorMapper: (PieCharData data, _) => data.color,
          xValueMapper: (PieCharData data, _) => data.title,
          yValueMapper: (PieCharData data, _) => data.value)
    ];
  }
}
