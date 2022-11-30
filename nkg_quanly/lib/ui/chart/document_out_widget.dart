import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/utils.dart';
import '../../const/widget.dart';
import '../document_nonapproved/document_nonapproved_detail.dart';
import '../document_out/doc_out_viewmodel.dart';
import '../document_out/document_out_list.dart';


class DocumentOutWidget extends GetView {

  final documentOutViewModel = Get.put(DocumentOutViewModel());

  DocumentOutWidget();

  @override
  Widget build(BuildContext context) {
    documentOutViewModel.getDocumentOutDefault();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: borderItem(Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Văn bản đi chờ phát hành",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DocumentOutList()));
                  },
                  child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_horiz)),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0)),
          SizedBox(
            height: 300,
              child: Obx(() => (documentOutViewModel
                  .rxDocumentOutItems.isNotEmpty)
                  ? ListView.builder(
                  controller: documentOutViewModel.controller,
                  itemCount: documentOutViewModel.rxDocumentOutItems.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Get.to(() => DocumentnonapprovedDetail(
                              id: documentOutViewModel
                                  .rxDocumentOutItems[index].id!));
                        },
                        child: DocOutListItem(
                            index,
                            documentOutViewModel.rxDocumentOutItems[index]));
                  })
                  : noData())),
        ],
      ), context),
    );
  }
}

