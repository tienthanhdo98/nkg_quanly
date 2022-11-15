import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/ChartModel.dart';
import '../../model/helpdesk_model/helpdesk_model.dart';

class HelpHeskChartWidget extends StatefulWidget {
  HelpHeskChartWidget(
      {UniqueKey? key, this.listHelpDeskStatistic, this.helpdeskModel})
      : super(key: key);

  final List<HelpDeskStatistic>? listHelpDeskStatistic;
  final HelpdeskModel? helpdeskModel;

  @override
  State<StatefulWidget> createState() => HelpHeskChartWidgetState();
}

class HelpHeskChartWidgetState extends State<HelpHeskChartWidget> {
  List<PieCharData> listChartData = [];
  List<HelpDeskStatistic>? listHelpDeskStatistic;

  @override
  void initState() {
    var total = widget.helpdeskModel!.totalRecords!;
    listHelpDeskStatistic = widget.listHelpDeskStatistic!;
    for (int i = 0; i < listHelpDeskStatistic!.length; i++) {
      listChartData.add(PieCharData(
          title: calcuPercen(listHelpDeskStatistic![i].total!, total),
          value: listHelpDeskStatistic![i].total!,
          color: listColorChart[i]));
      print(calcuPercen(listHelpDeskStatistic![i].total!, total));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Column(
        children: [
          SizedBox(height: 200, width: 220, child: _buildGroupingPieChart()),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 30,
                ),
                itemCount: listHelpDeskStatistic!.length,
                itemBuilder: (context, index) {
                  var item = listHelpDeskStatistic![index];
                  return legendChart(item.name!, listColorChart[index]);
                }),
          ),
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
          dataLabelMapper: (PieCharData data, _) =>(data.title != "0%") ?  data.title : " ",
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          dataSource: listChartData,
          startAngle: 100,
          endAngle: 100,
          /// To enable and specify the group mode for pie chart.
          pointColorMapper: (PieCharData data, _) => data.color,
          xValueMapper: (PieCharData data, _) => data.title,
          yValueMapper: (PieCharData data, _) =>  data.value )
    ];
  }
}
