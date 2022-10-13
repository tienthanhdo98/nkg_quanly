import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/report/report_viewmodel.dart';

import '../../const/const.dart';
import '../../model/report_model/report_model.dart';

class ReportDetail extends GetView {
  final int? id;

  final reportController = Get.put(ReportViewModel());

  ReportDetail({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: reportController.getReportDetail(id!),
          builder: (context, AsyncSnapshot<ReportListItems> snapshot) {
            if (snapshot.hasData) {
              var item = snapshot.data;
              return Column(children: [
                headerWidget('Chi tiết ${item!.name!}', context),
                Text(item.name!)
              ]);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
