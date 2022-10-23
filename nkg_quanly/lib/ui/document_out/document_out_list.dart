import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/viewmodel/date_picker_controller.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/document_out_model/document_out_model.dart';
import '../document_nonapproved/document_nonapproved_detail.dart';
import '../theme/theme_data.dart';
import 'doc_out_viewmodel.dart';
import 'document_out_search.dart';

class DocumentOutList extends GetView {
  final String? header;

  final documentOutViewModel = Get.put(DocumentOutViewModel());

  DocumentOutList({this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              header!,
              DocumenOutSearch(
                header: header,
              ),
              context),
          //date table
          headerTableDatePicker(context, documentOutViewModel),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Text(
                  'Tất cả văn bản đi chờ phát hành',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: elevetedButtonWhite,
                        onPressed: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                  height: 400,
                                  child: FilterDocumentOutBottomSheet(
                                      documentOutViewModel));
                            },
                          );
                        },
                        child: const Text(
                          'Bộ lọc',
                          style: TextStyle(color: kVioletButton),
                        ),
                      )),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
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
                                documentOutViewModel.rxDocumentOutItems[index],
                                false));
                      })
                  : noData())),
          //bottom
          Obx(() => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                        top:
                            BorderSide(color: Theme.of(context).dividerColor))),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          menuController.rxSelectedDay.value = DateTime.now();
                          documentOutViewModel.onSelectDay(DateTime.now());
                          documentOutViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            documentOutViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime datefrom = DateTime.now();
                          DateTime dateTo =
                              datefrom.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(datefrom);
                          String strdateTo = formatDateToString(dateTo);
                          print(strdateFrom);
                          print(strdateTo);
                          documentOutViewModel.getDocumentOutByWeek(
                              strdateFrom, strdateTo);
                          documentOutViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            documentOutViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          documentOutViewModel.getDocumentOutByMonth();
                          documentOutViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            documentOutViewModel.selectedBottomButton.value, 2),
                      ),
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}

class DocOutListItem extends StatelessWidget {
  DocOutListItem(this.index, this.docModel, this.isNonApprove);

  final int? index;
  final DocumentOutItems? docModel;
  final bool? isNonApprove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.name}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          signWidget(docModel!),
          SizedBox(
            height: 80,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đơn vị ban hành',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.departmentPublic!,
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày khởi tạo',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.toDate!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hạn xử lý',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.endDate!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

class FilterDocumentOutBottomSheet extends StatelessWidget {
  const FilterDocumentOutBottomSheet(this.documentOutViewModel, {Key? key})
      : super(key: key);
  final DocumentOutViewModel? documentOutViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tatca
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả văn bản đi chờ phát hành',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() => (documentOutViewModel!.mapAllFilter.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            documentOutViewModel!.checkboxFilterAll(false, 0);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            documentOutViewModel!.checkboxFilterAll(true, 0);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: kBlueButton,
            ),
            // Tất cả trang thai
            FilterAllItem(
                'Tất cả trạng thái', 3, documentOutViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: lisStatus.length,
                  itemBuilder: (context, index) {
                    var item = lisStatus[index];
                    return FilterItem(item, item.toString(), index,
                        documentOutViewModel!.mapStatusFilter);
                  }),
            ),

            //bottom button
            Align(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: buttonFilterWhite,
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            var status = "";
                            if (documentOutViewModel!.mapAllFilter
                                .containsKey(0)) {
                              documentOutViewModel!.postDocOutByFilter(
                                status,
                              );
                            } else {
                              if (documentOutViewModel!.mapAllFilter
                                  .containsKey(3)) {
                                status = "";
                              } else {
                                documentOutViewModel!.mapStatusFilter
                                    .forEach((key, value) {
                                  status += value;
                                });
                              }
                            }
                            print(status);
                            documentOutViewModel!.postDocOutByFilter(
                              status,
                            );
                            Get.back();
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

var lisStatus = ["Chưa xử lý", "Đã xử lý"];

Widget signWidget(DocumentOutItems docModel) {
  if (docModel.status == "Đã xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          docModel.status!,
          style: const TextStyle(color: kGreenSign),
        )
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.status!, style: const TextStyle(color: kOrangeSign))
      ],
    );
  }
}
