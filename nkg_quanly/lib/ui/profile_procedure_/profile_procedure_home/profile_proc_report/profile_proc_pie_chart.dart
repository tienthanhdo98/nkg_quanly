import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/document_unprocess/document_filter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../const/const.dart';
import '../../../../const/utils.dart';
import '../../../../const/widget.dart';
import '../../../../model/ChartModel.dart';


class ProfileProcPieChartWidget extends StatefulWidget {
  ProfileProcPieChartWidget(this.documentFilterModel,{UniqueKey? key}) : super(key: key);

  final DocumentFilterModel documentFilterModel;

  @override
  State<StatefulWidget> createState() => ProfileProcPieChartState();
}

class ProfileProcPieChartState extends State<ProfileProcPieChartWidget> {
  List<PieCharData> listChartData = [];
  DocumentFilterModel? documentFilterModel;

  @override
  void initState() {

    documentFilterModel = widget.documentFilterModel;
    var total = documentFilterModel!.totalRecords;
    for (int i = 0; i < documentFilterModel!.items!.length; i++) {
      listChartData.add(PieCharData(
          title: calcuPercen(documentFilterModel!.items![i].quantity!, total!),
          value: documentFilterModel!.items![i].quantity!,
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
                itemCount: documentFilterModel!.items!.length,
                itemBuilder: (_, index) {
                  var item = documentFilterModel!.items![index].name;
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
