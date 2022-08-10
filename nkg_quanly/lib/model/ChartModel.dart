import 'dart:ui';

import 'package:flutter/material.dart';

class ChartSampleData {
  ChartSampleData({this.x = "", this.y = 0, this.color = Colors.white});
  String x;
  double y;
  Color color;
}

class PieCharData {
  PieCharData({this.title = "", this.value = 0, this.color = Colors.white});

  String title;
  double value;
  Color color;
}

class LineCharData {
  LineCharData({this.title = "", this.value = 0});
  String title;
  double value;

}