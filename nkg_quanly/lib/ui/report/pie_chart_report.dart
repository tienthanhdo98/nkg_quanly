import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/ChartModel.dart';
import '../../model/report_model/report_model.dart';

class PieChartReport extends StatefulWidget {
  PieChartReport({this.reportStatistic});

  final ReportStatistic? reportStatistic;

  @override
  State<StatefulWidget> createState() => PieChartReportState();
}

class PieChartReportState extends State<PieChartReport> {
  List<PieCharData> listChartData = [];
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    var item = widget.reportStatistic;
    var tong = item!.tong;
    listChartData = [
      PieCharData(
          title: calcuPercen(item.daTiepNhan!, tong!),
          value: item.daTiepNhan!,
          color: listColorChart[0]),
      PieCharData(
          title: calcuPercen(item.daGiao!, tong),
          value: item.daGiao!,
          color: listColorChart[1]),
      PieCharData(
          title: calcuPercen(item.dungHan!, tong),
          value: item.dungHan!,
          color: listColorChart[2]),
      PieCharData(
          title: calcuPercen(item.chuaDenHan!, tong),
          value: item.chuaDenHan!,
          color: listColorChart[3]),
      PieCharData(
          title: calcuPercen(item.somHan!, tong),
          value: item.somHan!,
          color: listColorChart[4]),
      PieCharData(
          title: calcuPercen(item.quaHan!, tong),
          value: item.quaHan!,
          color: listColorChart[5]),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          SizedBox(height: 200, width: MediaQuery.of(context).size.width, child: _buildGroupingPieChart()),
          const Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0)),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
               legendChart("Đã tiếp nhận", listColorChart[0]),
               const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
               legendChart("Đã giao", listColorChart[1]),
               const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
               legendChart("Đúng hạn", listColorChart[2]),
             ],),
             const Padding(padding: EdgeInsets.fromLTRB(15, 5, 0, 0)),
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 legendChart("Chưa đến hạn", listColorChart[3]),
                 const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                 legendChart("Sớm hạn", listColorChart[4]),
                 const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                 legendChart("Quá hạn", listColorChart[5]),
               ],),

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
          radius: '90%',
          dataLabelMapper: (PieCharData data, _) =>
              (data.title != "0%") ? data.title : " ",
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
