import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../model/document/document_model.dart';
import '../../viewmodel/home_viewmodel.dart';

class DocumentnonapprovedSearch extends GetView{

  String? header;
  final homeController = Get.put(HomeViewModel());

  DocumentnonapprovedSearch({Key? key,this.header}) : super(key: key);

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
              headerWidget(header!,context),
              Expanded(
                child: Container(
                  color: kgray,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(children: [
                                Image.asset('assets/icons/ic_history.png',width: 24,height: 24,),
                                Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                                Text('Thủ tục hành chính 000${index+1}')
                              ],),
                            );
                      }),
                    ),
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