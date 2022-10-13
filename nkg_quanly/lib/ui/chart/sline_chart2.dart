import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';

class SLineChart2 extends StatefulWidget {
  const SLineChart2({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SlineChart2State();
}

class SlineChart2State extends State<SLineChart2> {
  int selected = 0;
  int selectedChart = 0;
  String dropdownValue = 'Mức độ';
  List<_ChartData>? chartData;

  @override
  void initState() {
    chartData = <_ChartData>[
      _ChartData(2005, 21),
      _ChartData(2006, 24),
      _ChartData(2007, 36),
      _ChartData(2008, 38),
      _ChartData(2009, 54),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerChartTable2(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Biểu đồ theo dõi",
                      style: CustomTextStyle.secondTextStyle,
                    )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                              color: kDLine,
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        child: DropdownButton<String>(
                          style: CustomTextStyle.secondTextStyle,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          underline:
                              DropdownButtonHideUnderline(child: Container()),
                          onChanged: (
                            String? newValue,
                          ) {
                            setState(() {
                              if (newValue == "Mức độ") {
                                chartData = <_ChartData>[
                                  _ChartData(2005, 21),
                                  _ChartData(2006, 24),
                                  _ChartData(2007, 36),
                                  _ChartData(2008, 38),
                                  _ChartData(2009, 54),
                                ];
                              } else {
                                chartData = <_ChartData>[
                                  _ChartData(2003, 10),
                                  _ChartData(2004, 24),
                                  _ChartData(2005, 60),
                                  _ChartData(2006, 38),
                                  _ChartData(2007, 70),
                                ];
                              }
                            });
                            dropdownValue = newValue!;
                          },
                          items: <String>['Mức độ', 'Tỉ lệ']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildDefaultLineChart()
            ],
          ),
          context),
    );
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 1)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          color: kBlueLineChart2,
          markerSettings:
              const MarkerSettings(isVisible: true, color: kBlueLineChart2)),
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final double x;
  final double y;
}
