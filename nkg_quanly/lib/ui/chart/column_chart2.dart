import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../model/ChartModel.dart';
import '../theme/theme_data.dart';

class ColumnChart2 extends StatefulWidget {
  const ColumnChart2({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ColumnChart2State();

// final TooltipBehavior? _tooltipBehavior =
//     TooltipBehavior(enable: true, header: '', canShowMarker: false);

}

class ColumnChart2State extends State<ColumnChart2> {
  var selected = 0;
  String dropdownValue = 'Trạng thái';
  List<ChartSampleData> listCharData = [];

  @override
  void initState() {
    listCharData = <ChartSampleData>[
      ChartSampleData(x: 'Thấp', y: 760, color: kViolet),
      ChartSampleData(x: 'Trung bình', y: 1240, color: kBlueChart),
      ChartSampleData(x: 'Cao', y: 1369, color: kOrange),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  style:
                      selected == 0 ? activeButtonStyle : unActiveButtonStyle,
                  onPressed: () {},
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
                    });
                  },
                  child: const Text("Trạng thái"),
                ),
              ))
            ],
          ),
          SizedBox(height: 230, child: _buildDefaultColumnChart()),
          Center(child: Text('Biểu đồ minh họa'))
        ],
      ),
    );
  }

  SfCartesianChart _buildDefaultColumnChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 1),
        ),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            labelFormat: '{value}',
            majorTickLines: const MajorTickLines(size: 0)),
        series: _getDefaultColumnSeries());
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: listCharData,
        width: 0.4,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: ((ChartSampleData sales, _) => sales.color),
        dataLabelSettings: const DataLabelSettings(
            isVisible: false, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}
