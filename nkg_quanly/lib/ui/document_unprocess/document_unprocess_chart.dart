import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/model/document_unprocess/document_filter.dart';
import 'package:nkg_quanly/viewmodel/home_viewmodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const.dart';
import '../../const/api.dart';
import '../theme/theme_data.dart';

class DocumentUnChart extends StatefulWidget {
  DocumentUnChart({this.homeViewModel,this.listBaseChart});

  final HomeViewModel? homeViewModel;
  final List<FilterItems>? listBaseChart;

  @override
  State<StatefulWidget> createState() => DocumentUnChartState();
}

class DocumentUnChartState extends State<DocumentUnChart> {
  var selected = 0;
  List<FilterItems>? listData = [];

  Future<void> getdata(String url ) async {
    DocumentFilterModel res = await widget.homeViewModel!.getQuantityDocumentBuUrl(url);
    listData = res.items!;
  }


  @override
  void initState() {
    selected = 0;
    getdata(apitGetUnProcess0);
    listData = widget.listBaseChart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  style:
                      selected == 0 ? activeButtonStyle : unActiveButtonStyle,
                  onPressed: () {
                    setState(() {
                      selected = 0;
                      getdata(apitGetUnProcess0);
                    });
                  },
                  child: const Text("Đơn vị BH"),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  style:
                      selected == 1 ? activeButtonStyle : unActiveButtonStyle,
                  onPressed: () {
                    setState(() {
                      selected = 1;
                      getdata(apitGetUnProcess1);
                    });
                  },
                  child: const Text("Mức độ"),
                ),
              ))
            ],
          ),
          SizedBox(height: 280, child: _buildDefaultColumnChart()),
          const Text('Biểu đồ minh họa')
        ],
      ),
    );
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

  List<ColumnSeries<FilterItems, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<FilterItems, String>>[
      ColumnSeries<FilterItems, String>(
        dataSource: listData!,
        width: 0.2,
        xValueMapper: (FilterItems sales, _) => sales.name,
        yValueMapper: (FilterItems sales, _) => sales.quantity,
        pointColorMapper: ((FilterItems sales, _) => kRedChart),
        dataLabelSettings: const DataLabelSettings(
            isVisible: false, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}
