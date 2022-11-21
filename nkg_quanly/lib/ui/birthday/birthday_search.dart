import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/document_out/search_controller.dart';

import '../../const/const.dart';
import 'birthday_screen.dart';


Widget listBirthDayResultWidget(
    SearchController searchController, List list) {
  return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {},
            child: BirthDayItem(index,
                list[index]));
      });
}