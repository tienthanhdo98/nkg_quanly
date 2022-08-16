import 'package:flutter/material.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart2 extends StatefulWidget {
  const ColumnChart2({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ColumnChart2State();


  // final TooltipBehavior? _tooltipBehavior =
  //     TooltipBehavior(enable: true, header: '', canShowMarker: false);


}
class ColumnChart2State extends State<ColumnChart2>{
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
      child: borderItem(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerChartTable2(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Row(children: [
              const Expanded(child: Text("Biểu đồ theo dõi",style:  CustomTextStyle.secondTextStyle)),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                        color: kDLine, style: BorderStyle.solid, width: 0.80),
                  ),
                  child: DropdownButton<String>(
                    style: CustomTextStyle.secondTextStyle,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    underline: DropdownButtonHideUnderline(child: Container()),
                    onChanged: (String? newValue,) {
                      setState(() {
                        if(newValue == "Mức độ")
                        {
                          listCharData = <ChartSampleData>[
                            ChartSampleData(x: 'Thấp', y: 760, color: kViolet),
                            ChartSampleData(x: 'Trung bình', y: 1240, color: kBlueChart),
                            ChartSampleData(x: 'Cao', y: 1369, color: kOrange),
                          ];
                        }
                        else
                        {
                          listCharData = <ChartSampleData>[
                            ChartSampleData(x: 'Thấp', y: 560, color: kViolet),
                            ChartSampleData(x: 'Trung bình', y: 1540, color: kBlueChart),
                            ChartSampleData(x: 'Cao', y: 9369, color: kOrange),
                          ];
                        }

                      });
                      dropdownValue = newValue!;
                    },
                    items: <String>['Trạng thái', 'Mức độ']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],),
          ),
          _buildDefaultColumnChart()
        ],
      ),context),
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