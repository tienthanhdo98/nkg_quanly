import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/document_unprocess/document_filter.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/meeting_room/meeting_room_statistic_model.dart';
import '../theme/theme_data.dart';

class PieChartRoomMeetingWidget extends StatefulWidget {
  PieChartRoomMeetingWidget({UniqueKey? key, this.documentFilterModel})
      : super(key: key);

  final MeetingRoomStatisticModel? documentFilterModel;

  @override
  State<StatefulWidget> createState() => PieChartRoomMeetingState();
}

class PieChartRoomMeetingState extends State<PieChartRoomMeetingWidget> {
  List<PieCharData> listChartData = [];
  MeetingRoomStatisticModel? documentFilterModel;
  List<FilterItems>? listQuantity;

  @override
  void initState() {
    documentFilterModel = widget.documentFilterModel;
    int total = documentFilterModel!.total!;
    int num2 = documentFilterModel!.vacancy!;
    int num1 = documentFilterModel!.booked!;
    listChartData.add(PieCharData(
        title: calcuPercen(num1, total),
        value: num1,
        color: kBlueChart));
    listChartData.add(PieCharData(
        title: calcuPercen(num2, total),
        value: num2,
        color: kOrange));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
      child: Column(
        children: [
          SizedBox(height: 200, width: 220, child: _buildGroupingPieChart()),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              legendChart('Còn trống', kBlueChart),
              legendChart('Đã đặt', kOrange),

            ],
          ),
          const Text('Biểu đồ minh họa')
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
