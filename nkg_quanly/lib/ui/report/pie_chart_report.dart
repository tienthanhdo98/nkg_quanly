import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/document_unprocess/document_filter.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../theme/theme_data.dart';

class PieChartReport extends StatefulWidget {
  PieChartReport({this.total,this.num1,this.num2});

  final int? total;
  final int? num1;
  final int? num2 ;

  @override
  State<StatefulWidget> createState() => PieChartReportState();
}

class PieChartReportState extends State<PieChartReport> {
  // final TooltipBehavior? _tooltipBehavior =
  //     TooltipBehavior(enable: true, format: 'point.x : point.y%');
  var selected = 0;

  List<PieCharData> listChartData = [];

  @override
  void initState() {

    listChartData.add(PieCharData(title: calcuPercen(widget.num1!,widget.total!),value: widget.num1!,color: kOrange));
    listChartData.add(PieCharData(title: calcuPercen(widget.num2!,widget.total!),value: widget.num2!,color: kBlueChart));
    // listChartData = <PieCharData>[
    //   PieCharData(title: "44%", value: 44, color: kOrange),
    //   PieCharData(title: "56%", value: 56, color: kBlueChart),
    // ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  style:
                      selected == 0 ? activeButtonStyle : unActiveButtonStyle,
                  onPressed: () {
                    setState(() {
                      selected = 0;
                      listChartData = <PieCharData>[
                        PieCharData(title: "44%", value: 44, color: kOrange),
                        PieCharData(title: "56%", value: 56, color: kBlueChart),
                      ];
                    });
                  },
                  child: const Text("Mức độ"),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  style:
                      selected == 1 ? kActiveButtonStyle : kUnActiveButtonStyle,
                  onPressed: () {
                    setState(() {
                      selected = 1;
                      listChartData = <PieCharData>[
                        PieCharData(title: "23%", value: 23, color: kOrange),
                        PieCharData(title: "77%", value: 77, color: kBlueChart),
                      ];
                    });
                  },
                  child: const Text("Trạng thái"),
                ),
              ))
            ],
          ),
          SizedBox(height: 190, width: 210, child: _buildGroupingPieChart()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              legendChart("Đã tiếp nhận", kBlueChart),
              legendChart("Đã giao", kOrange),
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
