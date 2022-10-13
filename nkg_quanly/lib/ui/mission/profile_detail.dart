import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../../model/document/document_model.dart';
import '../document_nonapproved/document_nonapproved_viewmodel.dart';

class ProfileDetail extends GetView {
  int? id;

  final documentNonApproveViewModel = Get.put(DocumentNonApproveViewModel());

  ProfileDetail({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: documentNonApproveViewModel.getDocumentDetail(id!),
          builder: (context, AsyncSnapshot<DocumentInListItems> snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                headerWidget('Chi tiết VB01-Văn Bản 01', context),

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
