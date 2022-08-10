import 'package:flutter/material.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatefulWidget {
  const ColumnChart({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ColumnChartState();


  // final TooltipBehavior? _tooltipBehavior =
  //     TooltipBehavior(enable: true, header: '', canShowMarker: false);


}
class ColumnChartState extends State<ColumnChart>{
  var selected = 0;
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
      child: borderItem(Column(
        children: [
          headerChartTable("Hồ sơ trình", "5.987"),
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ElevatedButton(
                      style: selected == 0 ? kActiveButtonStyle : kUnActiveButtonStyle,
                      onPressed: () {
                        setState(() {
                          selected = 0;
                          listCharData = <ChartSampleData>[
                            ChartSampleData(x: 'Thấp', y: 760, color: kViolet),
                            ChartSampleData(x: 'Trung bình', y: 1240, color: kBlueChart),
                            ChartSampleData(x: 'Cao', y: 1369, color: kOrange),
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
                      style: selected == 1 ? kActiveButtonStyle : kUnActiveButtonStyle,
                      onPressed: () {
                        setState(() {
                          selected = 1;
                          listCharData = <ChartSampleData>[
                            ChartSampleData(x: 'Thấp', y: 560, color: kViolet),
                            ChartSampleData(x: 'Trung bình', y: 1540, color: kBlueChart),
                            ChartSampleData(x: 'Cao', y: 9369, color: kOrange),
                          ];
                        });

                      },
                      child: const Text("Trạng thái"),
                    ),
                  ))
            ],
          ),
          _buildDefaultColumnChart()
        ],
      )),
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
        series: _getDefaultColumnSeries()
    );
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