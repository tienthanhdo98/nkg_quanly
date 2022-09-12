import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/document/document_model.dart';
import '../../viewmodel/home_viewmodel.dart';

class DocumentInDetail extends GetView{
  int? id;

  final homeController = Get.put(HomeViewModel());

  DocumentInDetail({Key? key,this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: FutureBuilder(
        future: homeController.getDocumentDetail(id!),
        builder: (context,AsyncSnapshot<Items> snapshot)
        {
          if(snapshot.hasData)
            {
              return  Column(children: [
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