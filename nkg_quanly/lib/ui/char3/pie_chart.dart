import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/document_unprocess/document_filter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/ChartModel.dart';

class PieChartWidget extends StatefulWidget {
  PieChartWidget({UniqueKey? key, this.documentFilterModel}) : super(key: key);

  final DocumentFilterModel? documentFilterModel;

  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State<PieChartWidget> {
  List<PieCharData> listChartData = [];
  DocumentFilterModel? documentFilterModel;
  List<FilterItems>? listQuantity;

  @override
  void initState() {
    documentFilterModel = widget.documentFilterModel;
    int total = documentFilterModel!.totalRecords!;
    listQuantity = documentFilterModel!.items!;
    print(listQuantity!.length);
    for (int i = 0; i < listQuantity!.length; i++) {
      listChartData.add(PieCharData(
          title: calcuPercen(listQuantity![i].quantity!, total),
          value: listQuantity![i].quantity!,
          color: listColorChart[i]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Column(
        children: [
          SizedBox(height: 200, width: 220, child: _buildGroupingPieChart()),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              legendChart(listQuantity![1].name.toString(), listColorChart[1]),
              legendChart(listQuantity![0].name.toString(), listColorChart[0]),
            ],
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
          dataLabelMapper: (PieCharData data, _) => data.title,
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
