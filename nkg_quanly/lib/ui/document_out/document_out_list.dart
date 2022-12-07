import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/search_screen.dart';

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


  final documentOutViewModel = Get.put(DocumentOutViewModel());

  DocumentOutList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    documentOutViewModel. getDocumentOutDefault();
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          headerWidgetSearch(
              "Văn bản đi chờ phát hành",
              SearchScreen(
                hintText: 'Nhập mã văn bản, tên văn bản',
                typeScreen: type_document_out,
              ),
              context),
          //date table
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: kDarkGray, style: BorderStyle.solid, width: 1),
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                            "Thống kê",
                            style: Theme.of(context).textTheme.headline2,
                          )),
                      Align(
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
                                      height: 350,
                                      child: FilterDocumentOutBottomSheet(
                                          documentOutViewModel));
                                },
                              );
                            },
                            child: const Text(
                              'Bộ lọc',
                              style: TextStyle(color: kVioletButton),
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: SizedBox(
                    height: 60,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
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
                                child: Obx(() => Text(
                                    documentOutViewModel.rxDepartmentSelected.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                    Theme.of(context).textTheme.headline5)))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tất cả văn bản đi chờ phát hành',
                  style: Theme.of(context).textTheme.headline5,
                ),
                fromDateToDateWidget(documentOutViewModel,(){
                  String strDateFrom =
                      menuController.rxFromDateWithoutWeekDayToApi.value;
                  String strDateTo =
                      menuController.rxToDateWithoutWeekDayToApi.value;
                  if(strDateFrom != "" && strDateTo != "") {
                    documentOutViewModel.getDocumentOutListByDiffDate(
                        strDateFrom, strDateTo);
                  }
                  else
                  {
                    documentOutViewModel.getDocumentOutDefault();
                  }
                })
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
                                documentOutViewModel.rxDocumentOutItems[index]));
                      })
                  : Align(
                  alignment: Alignment.topCenter,
                  child: noData()))),
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
                          String strDateFrom = formatDateToString(dateNow);
                          String strDateTo = formatDateToString(dateNow);
                          documentOutViewModel.getDocumentOutListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          documentOutViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            documentOutViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String strDateFrom = formatDateToString(findFirstDateOfTheWeek(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheWeek(dateNow));

                          documentOutViewModel.getDocumentOutListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          documentOutViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            documentOutViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String strDateFrom = formatDateToString(findFirstDateOfTheMonth(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheMonth(dateNow));

                          documentOutViewModel.getDocumentOutListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
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
  DocOutListItem(this.index, this.docModel);

  final int? index;
  final DocumentOutItems? docModel;


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
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
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
              'Tất cả đơn vị ban hành', 3, documentOutViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: 120,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: documentOutViewModel!.rxListDepartmentFilter.length,
                itemBuilder: (context, index) {
                  var item = documentOutViewModel!.rxListDepartmentFilter[index];
                  return FilterItem(item, item.toString(), index,
                      documentOutViewModel!.mapDepartmentFilter);
                }),
          ),

          //bottom button
          const Spacer(),
          Row(
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
                        var department = "";
                        if (documentOutViewModel!.mapAllFilter
                            .containsKey(0)) {
                          documentOutViewModel!.postDocOutByFilter(
                            department,
                          );
                          changeValueSelectedFilter(
                              documentOutViewModel!.rxDepartmentSelected,
                              "Tất cả đơn vị ban hành");
                        } else {
                          if (documentOutViewModel!.mapAllFilter
                              .containsKey(3)) {
                            department = "";
                            changeValueSelectedFilter(
                                documentOutViewModel!.rxDepartmentSelected,
                                "Tất cả đơn vị ban hành");
                          } else {
                            documentOutViewModel!.mapDepartmentFilter
                                .forEach((key, value) {
                              department += value;
                            });
                            if(department != "")
                              {
                                changeValueSelectedFilter(
                                    documentOutViewModel!.rxDepartmentSelected,
                                    department.substring(0, department.length - 1));
                              }
                          }
                        }
                        documentOutViewModel!.postDocOutByFilter(
                          department,
                        );
                        Get.back();
                      },
                      style: buttonFilterBlue,
                      child: const Text('Áp dụng')),
                ),
              )
            ],
          )
        ]),
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
