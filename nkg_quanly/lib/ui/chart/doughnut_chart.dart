import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const.dart';
import '../../model/ChartModel.dart';

class DoughnutChart extends StatefulWidget{
  const DoughnutChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=> DoughNutChartState();

}
class DoughNutChartState extends State<DoughnutChart>{
  String dropdownValue = 'Trạng thái';
  List<PieCharData> listChartData =  [];
  @override
  void initState() {
    listChartData = <PieCharData>[
      PieCharData(title: "44%", value: 44, color: kViolet),
      PieCharData(title: "56%", value: 56, color: kBlueChart),
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
                child: Row(children: [
                  Expanded(child: Text("Biểu đồ theo dõi", style: CustomTextStyle.secondTextStyle,)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                              listChartData = <PieCharData>[
                                PieCharData(title: "44%", value: 44, color: kViolet),
                                PieCharData(title: "56%", value: 56, color: kBlueChart),
                              ];
                            }
                            else
                            {
                              listChartData = <PieCharData>[
                                PieCharData(title: "20%", value: 20, color: kViolet),
                                PieCharData(title: "80%", value: 80, color: kBlueChart),
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
              IntrinsicHeight(
                child: Row(
                  children: [
                    SizedBox(
                        height: 200, width: 200, child: _buildDefaultDoughnutChart()),
                    Expanded(
                      child: Column(
                        children: [
                          legendChart("Phát hành",kBlueChart),
                          legendChart("Chưa phát hành",kViolet),
                        ],
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
          context),
    );
  }

  /// Return the circular chart with default doughnut series.
  SfCircularChart _buildDefaultDoughnutChart() {
    return SfCircularChart(
      series: _getDefaultDoughnutSeries()
    );
  }

  /// Returns the doughnut series which need to be render.
  List<DoughnutSeries<PieCharData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<PieCharData, String>>[
      DoughnutSeries<PieCharData, String>(
          radius: '100%',
          explode: true,
          explodeOffset: '10%',
          dataSource: listChartData,
          xValueMapper: (PieCharData data, _) => data.title,
          yValueMapper: (PieCharData data, _) => data.value,
          pointColorMapper: (PieCharData data, _) => data.color,
          dataLabelMapper: (PieCharData data, _) => data.title,
          dataLabelSettings: const DataLabelSettings(isVisible: false))
    ];
  }
}