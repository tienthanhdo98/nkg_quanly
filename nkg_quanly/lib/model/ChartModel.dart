import 'dart:ui';

import 'package:flutter/material.dart';

class ChartSampleData {
  ChartSampleData({this.x = "", this.y = 0, this.color = Colors.white});

  String x;
  int y;
  Color color;
}

class PieCharData {
  PieCharData({this.title = "", this.value = 0, this.color = Colors.white});

  String title;
  int value;
  Color color;
}

class LineCharData {
  LineCharData({this.title = "", this.value = 0});

  String title;
  double value;
}

class ChartCollumTwoValueModel {
  ChartCollumTwoValueModel({this.title = "", this.value1 = 0, this.value2 = 0, this.color = Colors.white});

  String title;
  int value1;
  int value2;
  Color color;
}

class StackedChartModel {
  StackedChartModel(this.title, this.value1, this.value2, this.value3);
  final String title;
  final num value1;
  final num value2;
  final num value3;
}
