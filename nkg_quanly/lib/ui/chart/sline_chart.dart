import 'package:flutter/material.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SLineChart extends StatefulWidget {
  const SLineChart({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>SlineChartState();


}
class SlineChartState extends State<SLineChart>{
  int selected = 0;
  final whiteBt =
  ElevatedButton.styleFrom(primary: kWhite, onPrimary: Colors.black);
  final blueBt = ElevatedButton.styleFrom(primary: kBlueButton);

  List<LineCharData>? listDataChart = [];
  @override
  void initState() {
    listDataChart=  <LineCharData>[
      LineCharData(title: 'Tháng 1', value: 12),
      LineCharData(title: 'Tháng 2', value: 8),
      LineCharData(title: 'Tháng 3', value: 7.5),
      LineCharData(title: 'Tháng 4', value: 8),
      LineCharData(title: 'Tháng 5', value: 10),
      LineCharData(title: 'Tháng 6', value: 2),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(Column(
        children: [
          headerChartTable("Nhiệm vụ", "5.987"),
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context,index){
                return buttonItem(index);
              },
            ),
          ),
          _buildDefaultSplineChart()
        ],
      )),
    );
  }
  Widget buttonItem(int index){
    return  Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
        child: ElevatedButton(
            style: selected == index ? blueBt : whiteBt,
            onPressed: () {
              setState(() {
                selected = index;
                switch(index){
                  case 0 : {
                    listDataChart=  <LineCharData>[
                      LineCharData(title: 'Tháng 1', value: 12),
                      LineCharData(title: 'Tháng 2', value: 8),
                      LineCharData(title: 'Tháng 3', value: 7.5),
                      LineCharData(title: 'Tháng 4', value: 8),
                      LineCharData(title: 'Tháng 5', value: 10),
                      LineCharData(title: 'Tháng 6', value: 2),
                    ];
                  }
                  break;
                  case 1: {
                    listDataChart=  <LineCharData>[
                      LineCharData(title: 'Tháng 1', value:2),
                      LineCharData(title: 'Tháng 2', value: 16),
                      LineCharData(title: 'Tháng 3', value: 20),
                      LineCharData(title: 'Tháng 4', value: 8),
                      LineCharData(title: 'Tháng 5', value: 8),
                      LineCharData(title: 'Tháng 6', value: 6),
                    ];
                  }
                  break;
                  case 2: {
                    listDataChart=  <LineCharData>[
                      LineCharData(title: 'Tháng 1', value: 32),
                      LineCharData(title: 'Tháng 2', value: 45),
                      LineCharData(title: 'Tháng 3', value: 20),
                      LineCharData(title: 'Tháng 4', value: 8),
                      LineCharData(title: 'Tháng 5', value: 10),
                      LineCharData(title: 'Tháng 6', value: 2),
                    ];
                  }
                  break;
                  case 3: {
                    listDataChart=  <LineCharData>[
                      LineCharData(title: 'Tháng 1', value: 30),
                      LineCharData(title: 'Tháng 2', value: 35),
                      LineCharData(title: 'Tháng 3', value: 40),
                      LineCharData(title: 'Tháng 4', value: 15),
                      LineCharData(title: 'Tháng 5', value: 16),
                      LineCharData(title: 'Tháng 6', value: 20),
                    ];
                  }
                  break;
                }

              });

            },
            child: const Text("ĐV ban hành")));
  }

  SfCartesianChart _buildDefaultSplineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 1),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 80,
          axisLine: const AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          labelFormat: '{value}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getDefaultSplineSeries(),
      // tooltipBehavior: TooltipBehavior(enable: false),
    );
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<LineCharData, String>> _getDefaultSplineSeries() {
    return <SplineSeries<LineCharData, String>>[
      SplineSeries<LineCharData, String>(
        dataSource: listDataChart!,
        name: 'Low',
        markerSettings: const MarkerSettings(isVisible: true, color: kRedChart),
        xValueMapper: (LineCharData sales, _) => sales.title,
        yValueMapper: (LineCharData sales, _) => sales.value,
        color: kRedChart,
      )
    ];
  }

}