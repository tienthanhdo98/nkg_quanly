import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/report/report_viewmodel.dart';
import 'package:nkg_quanly/ui/workbook/update_work_screen.dart';
import 'package:nkg_quanly/ui/workbook/workbook_viewmodel.dart';

import '../../const.dart';
import '../../model/report_model/report_model.dart';
import '../../model/workbook/workbook_model.dart';

class WorkBookDetail extends GetView{
  final String? id;

  final workBookViewModel = Get.put(WorkBookViewModel());

  WorkBookDetail({Key? key,this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: FutureBuilder(
        future: workBookViewModel.getWorkbookModelDetail(id!),
        builder: (context,AsyncSnapshot<WorkBookListItems> snapshot)
        {
          if(snapshot.hasData)
            {
              var item = snapshot.data;
              return  SingleChildScrollView(
                child: Column(
                  children: [
                    //header
                    headerWidget("Chi tiết công việc ${item!.workName!}", context),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //ten cv
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Tên công việc:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          borderText(item.workName!,context),
                          //nhom cong viec
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Tên nhóm công việc:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          borderText(item.groupWorkName!,context),
                          //mota
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Mô tả:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          borderText(item.description!,context),
                          //nguoi thuc hien
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Người thực hiện:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          borderText(item.worker!,context),
                          //nguoi thuc hien
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Trạng thái:",
                              style: CustomTextStyle.grayColorTextStyle,
                            ),
                          ),
                          //trangthai
                          borderText((item.status! == true) ? "Có" : "Không",context),
                          //quan trong
                          Row(
                            children: [
                              Text(
                                'Quan trọng',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: StatefulBuilder(
                                        builder:
                                            (BuildContext context, StateSetter setState) {
                                          return Switch(
                                              value: item.important!,
                                              onChanged: (value) {

                                              });
                                        },
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          //
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                            ),
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: kWhite,
                                          //change background color of button
                                          onPrimary: kBlueButton,
                                          //change text color of button
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              side:
                                              const BorderSide(color: kVioletButton)),
                                        ),
                                        child: const Text('Đóng')),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => UpdateWorkBookScreen(item));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                if (states
                                                    .contains(MaterialState.pressed)) {
                                                  return kBlueButton;
                                                } else {
                                                  return kBlueButton;
                                                } // Use the component's default.
                                              },
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                ))),
                                        child: const Text('Chỉnh sửa')),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                    //date table
                  ],
                ),
              );
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