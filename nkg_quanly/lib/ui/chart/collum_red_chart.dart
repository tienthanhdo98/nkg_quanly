import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnRedChart extends StatefulWidget {
  const ColumnRedChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ColumnRedChartState();

}
class ColumnRedChartState extends State<ColumnRedChart> {
  List<ChartSampleData> listDataChart = [];
  int selected = 0;

  @override
  void initState() {
    listDataChart = <ChartSampleData>[
      ChartSampleData(x: 'Hải Dương', y: 6000, color: kRedChart),
      ChartSampleData(x: 'Nam Định', y: 4100, color: kRedChart),
      ChartSampleData(x: 'Hải Phòng', y: 8000, color: kRedChart),
      ChartSampleData(x: 'Hà Nội', y: 7000, color: kRedChart),
    ];
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(Column(
        children: [
          headerChartTable("Văn bản đến chưa xử lý", "5.987"),
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
          _buildDefaultColumnChart()
        ],
      )),
    );

  }

  Widget buttonItem(int index){
    return  Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
        child: ElevatedButton(
            style: selected == index ? kActiveButtonStyle : kUnActiveButtonStyle,
            onPressed: () {
              setState(() {
                selected = index;
                switch(index){
                  case 0 : {
                    listDataChart = <ChartSampleData>[
                      ChartSampleData(x: 'Hải Dương', y: 6000, color: kRedChart),
                      ChartSampleData(x: 'Nam Định', y: 4100, color: kRedChart),
                      ChartSampleData(x: 'Hải Phòng', y: 8000, color: kRedChart),
                      ChartSampleData(x: 'Hà Nội', y: 7000, color: kRedChart),
                    ];
                  }
                  break;
                  case 1: {
                    listDataChart = <ChartSampleData>[
                      ChartSampleData(x: 'Tuyên Quang', y: 1000, color: kRedChart),
                      ChartSampleData(x: 'TP.HCM', y: 2100, color: kRedChart),
                      ChartSampleData(x: 'Hải Dương', y: 3000, color: kRedChart),
                      ChartSampleData(x: 'Bình Dương', y: 7000, color: kRedChart),
                    ];
                  }
                  break;
                  case 2: {
                    listDataChart = <ChartSampleData>[
                      ChartSampleData(x: 'Nghệ An', y: 3000, color: kRedChart),
                      ChartSampleData(x: 'Vinh', y: 4100, color: kRedChart),
                      ChartSampleData(x: 'Hải Dương', y: 5000, color: kRedChart),
                      ChartSampleData(x: 'Bình Dương', y: 6000, color: kRedChart),
                    ];
                  }
                  break;
                  case 3: {
                    listDataChart = <ChartSampleData>[
                      ChartSampleData(x: 'Hà Giang', y: 4000, color: kRedChart),
                      ChartSampleData(x: 'Cao Bằng', y: 1100, color: kRedChart),
                      ChartSampleData(x: 'Lạng Sơn', y: 1000, color: kRedChart),
                      ChartSampleData(x: 'Yên Bái', y: 2000, color: kRedChart),
                    ];
                  }
                  break;
                }

              });

            },
            child: const Text("ĐV ban hành")));
  }
  //char
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
      series: _getDefaultColumnSeries(),
      // tooltipBehavior: _tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: listDataChart,
        width: 0.2,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        pointColorMapper: ((ChartSampleData sales, _) => sales.color),
        dataLabelSettings: const DataLabelSettings(
            isVisible: false, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}