import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/document/document_model.dart';
import '../../viewmodel/home_viewmodel.dart';

class DocumentInSearch extends GetView{

  String? header;
  final homeController = Get.put(HomeViewModel());

  DocumentInSearch({Key? key,this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: FutureBuilder(
        future: homeController.getDocument(),
        builder: (context,AsyncSnapshot<DocumentModel> snapshot)
        {
          if(snapshot.hasData)
          {
            return  Column(children: [
              Container(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_outlined),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                      Text(
                        header!,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
              )
            ],);
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