import 'package:flutter/material.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartState();




}
class PieChartState extends State<PieChart>{
  // final TooltipBehavior? _tooltipBehavior =
  //     TooltipBehavior(enable: true, format: 'point.x : point.y%');
  var selected = 0;

  List<PieCharData> listChartData =  [];
  @override
  void initState() {
    listChartData = <PieCharData>[
      PieCharData(title: "44%", value: 44, color: kOrange),
      PieCharData(title: "56%", value: 56, color: kBlueChart),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(Column(
        children: [
          headerChartTable("Văn bản đến chưa bút phê", "5.987",context),
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
                          listChartData =  <PieCharData>[
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
                      style: selected == 1 ? kActiveButtonStyle : kUnActiveButtonStyle,
                      onPressed: () {
                        setState(() {
                          selected = 1;
                          listChartData =  <PieCharData>[
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
          IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(
                    height: 200, width: 200, child: _buildGroupingPieChart()),
                Expanded(
                  child: Column(
                    children: [
                      legendChart("Đã bút phê",kBlueChart),
                      legendChart("Đã bút phê",kOrange),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),context),
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