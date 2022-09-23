import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../model/document/document_model.dart';
import 'document_nonapproved_viewmodel.dart';

class DocumentnonapprovedDetail extends GetView{
  int? id;

  final documentNonApproveViewModel = Get.put(DocumentNonApproveViewModel());

  DocumentnonapprovedDetail({Key? key,this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: FutureBuilder(
        future: documentNonApproveViewModel.getDocumentDetail(id!),
        builder: (context,AsyncSnapshot<Items> snapshot)
        {
          if(snapshot.hasData)
            {
              return  Column(children: [
                headerWidget('Chi tiết VB01-Văn Bản 01',context),
                Text(snapshot.data!.name!)
              ]);
            }
          else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());

        },

      ),
    ),);
  }

}