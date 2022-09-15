import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/document_unprocess/document_filter.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/meeting_room/meeting_room_statistic_model.dart';
import '../theme/theme_data.dart';

class RoomMeetingPieChart2 extends StatefulWidget {
  RoomMeetingPieChart2({this.statisticModel});

  final MeetingRoomStatisticModel? statisticModel;

  @override
  State<StatefulWidget> createState() => RoomMeetingPieChartState();
}

class RoomMeetingPieChartState extends State<RoomMeetingPieChart2> {
  // final TooltipBehavior? _tooltipBehavior =
  //     TooltipBehavior(enable: true, format: 'point.x : point.y%');
  var selected = 0;

  List<PieCharData> listChartData = [];

  @override
  void initState() {
    var total = widget.statisticModel!.total!;
    var num1 = widget.statisticModel!.vacancy;
    var num2 = widget.statisticModel!.booked;
    listChartData.add(PieCharData(title: calcuPercen(num1!,total),value: num1,color: kOrange));
    listChartData.add(PieCharData(title: calcuPercen(num2!,total),value: num2,color: kBlueChart));
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
              legendChart("Đã bút phê", kBlueChart),
              legendChart("Đã bút phê", kOrange),
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
