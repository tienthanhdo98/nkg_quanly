import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/ChartModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: kWhite,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 200,
                    height: 150,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/icons/ic_search.png",
                          width: 25,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const WorkSchedule(),
          ColumnRedChart(),
          PieChart(),
          ColumnChart(),
          SLineChart(),
          const WorkSchedule(),
          ColumnRedChart(),
          PieChart(),
        ],
      ),
    );
  }
}

class WorkSchedule extends StatelessWidget {
  const WorkSchedule({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Lịch làm việc",
                            style: CustomTextStyle.header1TextStyle,
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                          Text("Thứ 5, 28/7/2022",
                              style: CustomTextStyle.header1TextStyle)
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                "assets/icons/ic_more.png",
                                width: 20,
                                height: 20,
                              )))
                    ],
                  ),
                ),
                const Divider(
                  color: kBackGround,
                  thickness: 2,
                ),
                //table
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kLightGray,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: double.infinity,
                    height: 40,
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              "Cả ngày",
                              style: CustomTextStyle.header2TextStyle,
                            ),
                          ),
                        ),
                        VerticalDivider(
                            width: 1, color: kBackGround, thickness: 1),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Lịch làm việc",
                                style: CustomTextStyle.header2TextStyle),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Divider(
                    color: kBackGround,
                    thickness: 2,
                  ),
                ),
                //iteam1
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Center(
                          child: Text("08:00 - 09:00"),
                        ),
                      ),
                      const Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh",
                                style: CustomTextStyle.header2TextStyle,
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                              const Text(
                                "Phòng họp  lớn 01",
                                style: CustomTextStyle.secondTextStyle,
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/ic_camera.png",
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.fill,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                                  const Text("Họp online",
                                      style: CustomTextStyle.secondTextStyle)
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Divider(
                    color: kBackGround,
                    thickness: 2,
                  ),
                ),
                //item2
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Center(
                          child: Text("08:00 - 09:00"),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hội thảo trực tuyến phòng ngừa thuốc lá cho học sinh",
                                style: CustomTextStyle.header2TextStyle,
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                              const Text(
                                "Phòng họp  lớn 01",
                                style: CustomTextStyle.secondTextStyle,
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/ic_camera.png",
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.fill,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                                  const Text("Họp online",
                                      style: CustomTextStyle.secondTextStyle)
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ColumnChart extends StatelessWidget {
  ColumnChart({
    Key? key,
  }) : super(key: key);

  final Color low = kViolet;
  final Color medium = kBlueChart;
  final Color hight = kOrange;

  // final TooltipBehavior? _tooltipBehavior =
  //     TooltipBehavior(enable: true, header: '', canShowMarker: false);

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
                  onPressed: () {},
                  child: const Text("Mức độ"),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kWhite, onPrimary: Colors.black),
                  onPressed: () {},
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
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Thấp', y: 760, color: kViolet),
          ChartSampleData(x: 'Trung bình', y: 1240, color: kBlueChart),
          ChartSampleData(x: 'Cao', y: 1369, color: kOrange),
        ],
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

class ColumnRedChart extends StatelessWidget {
  ColumnRedChart({
    Key? key,
  }) : super(key: key);

  // final TooltipBehavior? _tooltipBehavior =
  //     TooltipBehavior(enable: true, header: '', canShowMarker: false);
  final whitebt =
      ElevatedButton.styleFrom(primary: kWhite, onPrimary: Colors.black);
  final blueBt = ElevatedButton.styleFrom(primary: kBlueButton);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(Column(
        children: [
          headerChartTable("Văn bản đến chưa xử lý", "5.987"),
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                    child: ElevatedButton(
                        style: blueBt,
                        onPressed: () {},
                        child: const Text("ĐV ban hành"))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                    child: ElevatedButton(
                        style: whitebt,
                        onPressed: () {},
                        child: const Text("Mức độ"))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                    child: ElevatedButton(
                        style: whitebt,
                        onPressed: () {},
                        child: const Text("Ngày đến"))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: ElevatedButton(
                        style: whitebt,
                        onPressed: () {},
                        child: const Text("Hạn xử lý"))),
              ],
            ),
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
      series: _getDefaultColumnSeries(),
      // tooltipBehavior: _tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Hải Dương', y: 6000, color: kRedChart),
          ChartSampleData(x: 'Nam Định', y: 4100, color: kRedChart),
          ChartSampleData(x: 'Hải Phòng', y: 8000, color: kRedChart),
          ChartSampleData(x: 'Hà Nội', y: 7000, color: kRedChart),
        ],
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

class PieChart extends StatelessWidget {
  PieChart({
    Key? key,
  }) : super(key: key);

  // final TooltipBehavior? _tooltipBehavior =
  //     TooltipBehavior(enable: true, format: 'point.x : point.y%');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(Column(
        children: [
          headerChartTable("Văn bản đến chưa bút phê", "5.987"),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Mức độ"),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kWhite, onPrimary: Colors.black),
                  onPressed: () {},
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
      )),
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
          dataSource: <PieCharData>[
            PieCharData(title: "44%", value: 44, color: kOrange),
            PieCharData(title: "56%", value: 56, color: kBlueChart),
          ],
          startAngle: 100,
          endAngle: 100,

          /// To enable and specify the group mode for pie chart.
          pointColorMapper: (PieCharData data, _) => data.color,
          xValueMapper: (PieCharData data, _) => data.title,
          yValueMapper: (PieCharData data, _) => data.value)
    ];
  }
}

class SLineChart extends StatelessWidget {
  SLineChart({
    Key? key,
  }) : super(key: key);

  final whitebt =
      ElevatedButton.styleFrom(primary: kWhite, onPrimary: Colors.black);
  final blueBt = ElevatedButton.styleFrom(primary: kBlueButton);

  final List<LineCharData>? chartData = <LineCharData>[
    LineCharData(title: 'Tháng 1', value: 12),
    LineCharData(title: 'Tháng 2', value: 8),
    LineCharData(title: 'Tháng 3', value: 7.5),
    LineCharData(title: 'Tháng 4', value: 8),
    LineCharData(title: 'Tháng 5', value: 10),
    LineCharData(title: 'Tháng 6', value: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(Column(
        children: [
          headerChartTable("Nhiệm vụ", "5.987"),
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                    child: ElevatedButton(
                        style: blueBt,
                        onPressed: () {},
                        child: const Text("ĐV ban hành"))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                    child: ElevatedButton(
                        style: whitebt,
                        onPressed: () {},
                        child: const Text("Mức độ"))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                    child: ElevatedButton(
                        style: whitebt,
                        onPressed: () {},
                        child: const Text("Ngày đến"))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: ElevatedButton(
                        style: whitebt,
                        onPressed: () {},
                        child: const Text("Hạn xử lý"))),
              ],
            ),
          ),
          _buildDefaultSplineChart()
        ],
      )),
    );
  }

  SfCartesianChart _buildDefaultSplineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 1),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 15,
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
        dataSource: chartData!,
        name: 'Low',
        markerSettings: const MarkerSettings(isVisible: true, color: kRedChart),
        xValueMapper: (LineCharData sales, _) => sales.title,
        yValueMapper: (LineCharData sales, _) => sales.value,
        color: kRedChart,
      )
    ];
  }
}
