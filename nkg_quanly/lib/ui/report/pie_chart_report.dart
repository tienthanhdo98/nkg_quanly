import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/document_unprocess/document_filter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/ChartModel.dart';

class PieChartReport extends StatefulWidget {
  PieChartReport({this.documentFilterModel});

  final DocumentFilterModel? documentFilterModel;

  @override
  State<StatefulWidget> createState() => PieChartReportState();
}

class PieChartReportState extends State<PieChartReport> {
  List<PieCharData> listChartData = [];
  DocumentFilterModel? documentFilterModel;
  List<FilterItems>? listQuantity;

  @override
  void initState() {
    documentFilterModel = widget.documentFilterModel;
    listQuantity = documentFilterModel!.items!;
    int total = documentFilterModel!.totalRecords!;
    int num1 = listQuantity![0].quantity!;
    int num2 = listQuantity![1].quantity!;
    listChartData.add(PieCharData(
        title: calcuPercen(num1, total), value: num1, color: kOrange));
    listChartData.add(PieCharData(
        title: calcuPercen(num2, total), value: num2, color: kBlueChart));
    // listChartData = <PieCharData>[
    //   PieCharData(title: "44%", value: 44, color: kOrange),
    //   PieCharData(title: "56%", value: 56, color: kBlueChart),
    // ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        children: [
          SizedBox(height: 190, width: 210, child: _buildGroupingPieChart()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              legendChart(listQuantity![1].name.toString(), kBlueChart),
              legendChart(listQuantity![0].name.toString(), kOrange),
            ],
          ),
          Text('Biểu đồ minh họa')
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
          radius: '85%',
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
