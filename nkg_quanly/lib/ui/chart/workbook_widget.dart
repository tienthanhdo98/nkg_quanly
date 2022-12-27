import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/utils.dart';
import '../../const/widget.dart';
import '../workbook/workbook_list.dart';
import '../workbook/workbook_viewmodel.dart';


class WorkBookWidget extends GetView {

  final workBookViewModel = Get.put(WorkBookViewModel());


  @override
  Widget build(BuildContext context) {
    workBookViewModel.postWorkBookAll();
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
                      "Sổ tay công việc",
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
                                WorkBookList()));
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
              child: Obx(() => (workBookViewModel.rxWorkBookListItems.isNotEmpty) ? ListView.builder(
                  controller: workBookViewModel.controller,
                  itemCount: workBookViewModel.rxWorkBookListItems.length,
                  itemBuilder: (context, index) {
                    return WorkBookItem(
                        index,
                        workBookViewModel.rxWorkBookListItems[index],
                        workBookViewModel, []);
                  }) : loadingIcon())),
        ],
      ), context),
    );
  }
}

