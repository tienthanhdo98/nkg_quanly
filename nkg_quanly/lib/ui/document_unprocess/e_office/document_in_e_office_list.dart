import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../../model/document/document_model.dart';
import '../../document_nonapproved/document_nonapproved_detail.dart';
import '../../document_nonapproved/document_nonapproved_search.dart';
import '../../theme/theme_data.dart';
import '../document_unprocess_viewmodel.dart';
import 'filter_doc_in_screen.dart';

class DocumentInEOfficeList extends GetView {
  final String? header;

  final documentUnprocessViewModel = Get.put(DocumentUnprocessViewModel());

  DocumentInEOfficeList({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidgetSearch(
                  header!,
                  DocumentnonapprovedSearch(
                    isApprove: true,
                  ),
                  context),
              //date table
              headerTableDatePicker(context, documentUnprocessViewModel),
              //list
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tất cả văn bản đến',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline5,
                            ),
                            InkWell(
                              onTap: () {
                                if (menuController.rxShowStatistic.value ==
                                    true) {
                                  menuController.changeStateShowStatistic(
                                      false);
                                } else {
                                  menuController.changeStateShowStatistic(true);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Row(children: [
                                  Obx(() =>
                                  (documentUnprocessViewModel
                                      .rxDocumentInStatistic.value.tong !=
                                      null)
                                      ? Text(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic.value.tong
                                          .toString(),
                                      style: textBlueCountTotalStyle)
                                      : const Text("")),
                                  const Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: kBlueButton,
                                      ))
                                ]),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: elevetedButtonWhite,
                              onPressed: () {
                                Get.to(() =>
                                    FilterDocInScreen(
                                        documentUnprocessViewModel));
                              },
                              child: const Text(
                                'Bộ lọc',
                                style: TextStyle(color: kVioletButton),
                              ),
                            ))
                      ],
                    ),
                    Obx(() =>
                    (menuController.rxShowStatistic.value == true)
                        ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: SizedBox(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 0,
                          crossAxisCount: 3,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Chưa xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                    checkingStringNull(
                                        documentUnprocessViewModel
                                            .rxDocumentInStatistic
                                            .value
                                            .chuaXuLy
                                            .toString()),
                                    style: textBlackCountEofficeStyle)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Đang xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .dangXuLy
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Đã xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic.value.daXuLy
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Đã bút phê',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .daButPhe
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Chưa bút phê',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .chuaButPhe
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Trong hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .trongHan
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Quá hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic.value.quaHan
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('HT trước hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .hoanThanhTruocHan
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Hoàn thành trong hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .hoanThanhTrongHan
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Hoàn thành quá hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .hoanThanhQuaHan
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Chưa HT trong hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .chuaHoanThanhTrongHan
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Text('Chưa HT quá hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                ),
                                Text(
                                  checkingStringNull(
                                      documentUnprocessViewModel
                                          .rxDocumentInStatistic
                                          .value
                                          .chuaHoanThanhQuaHan
                                          .toString()),
                                  style: textBlackCountEofficeStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink())
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Divider(
                    thickness: 1,
                  )),
              Expanded(
                  child: Obx(() =>
                  (documentUnprocessViewModel.rxItems.isNotEmpty)
                      ? ListView.builder(
                      controller: documentUnprocessViewModel.controller,
                      itemCount: documentUnprocessViewModel.rxItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
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
                                      child: DetailDocInBottomSheet(
                                          index,
                                          documentUnprocessViewModel
                                              .rxItems[index]));
                                },
                              );
                            },
                            child: DocumentNonProcessListItem(index,
                                documentUnprocessViewModel.rxItems[index]));
                      })
                      : noData())),
              //bottom
              Obx(() =>
                  Container(
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .cardColor,
                        border: Border(
                            top:
                            BorderSide(color: Theme
                                .of(context)
                                .dividerColor))),
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              menuController.rxSelectedDay.value = DateTime
                                  .now();
                              documentUnprocessViewModel
                                  .onSelectDay(DateTime.now());
                              documentUnprocessViewModel.swtichBottomButton(0);
                            },
                            child: bottomDateButton(
                                "Ngày",
                                documentUnprocessViewModel
                                    .selectedBottomButton.value,
                                0),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                              String strdateFrom = formatDateToString(dateNow);
                              String strdateTo = formatDateToString(dateTo);
                              print(strdateFrom);
                              print(strdateTo);
                              documentUnprocessViewModel.getDocumentByWeek(
                                  strdateFrom, strdateTo);
                              documentUnprocessViewModel.swtichBottomButton(1);
                            },
                            child: bottomDateButton(
                                "Tuần",
                                documentUnprocessViewModel
                                    .selectedBottomButton.value,
                                1),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              documentUnprocessViewModel.getDocumentByMonth();
                              documentUnprocessViewModel.swtichBottomButton(2);
                            },
                            child: bottomDateButton(
                                "Tháng",
                                documentUnprocessViewModel
                                    .selectedBottomButton.value,
                                2),
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

class DocumentNonProcessListItem extends StatelessWidget {
  const DocumentNonProcessListItem(this.index, this.docModel, {Key? key})
      : super(key: key);

  final int? index;
  final DocumentInListItems? docModel;

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
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline3,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: textCodeStyle(docModel!.code!)),
          signWidget(docModel!),
          SizedBox(
            height: 60,
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.toDate!),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.endDate!),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
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

class DetailDocInBottomSheet extends StatelessWidget {
  const DetailDocInBottomSheet(this.index, this.docModel, {Key? key})
      : super(key: key);
  final int? index;
  final DocumentInListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin văn bản đến',
            style: TextStyle(
                color: kBlueButton,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 16),
          ),
          const Divider(
            thickness: 1,
            color: kBlueButton,
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.name}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline3,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: textCodeStyle(docModel!.code!)),
          signWidget(docModel!),
          SizedBox(
            height: 120,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              childAspectRatio: 3.5 / 2,
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.toDate!),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.endDate!),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.endDate!),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tình trạng HT',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.status!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tình trạng VB',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.state!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5))
                  ],
                ),
              ],
            ),
          ),
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
                      onPressed: () async {
                        var urlFile =
                            "http://123.31.31.237:6002/api/documentin/download-document?id=${docModel!.id}";
                        if (await canLaunchUrl(Uri.parse(urlFile))) {
                          launchUrl(
                            Uri.parse(urlFile),
                            webViewConfiguration: const WebViewConfiguration(
                                enableJavaScript: true, enableDomStorage: true),
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      style: buttonFilterBlue,
                      child: const Text('Xem chi tiết')),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget signWidget(DocumentInListItems docModel) {
  if (docModel.status == "Đã xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          "Đã xử lý",
          style: TextStyle(color: kGreenSign, fontSize: 12),
        )
      ],
    );
  } else if (docModel.status == "Đang xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          "Đang xử lý",
          style: TextStyle(color: kOrangeSign, fontSize: 12),
        )
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          "Chưa xử lý",
          style: TextStyle(color: Colors.black, fontSize: 12),
        )
      ],
    );
  }
}

class FilterDocUnprocessBottomSheet extends StatelessWidget {
  const FilterDocUnprocessBottomSheet(this.reportViewModel,
      {Key? key})
      : super(key: key);
  final DocumentUnprocessViewModel? reportViewModel;

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
                      'Tất cả văn bản chưa xử lý',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() =>
                  (menuController.listPriorityStatus.containsKey(0))
                      ? InkWell(
                      onTap: () {
                        menuController.checkboxPriorityState(false, 0, "");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController.checkboxPriorityState(true, 0, "");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            // tat ca muc do
            const Divider(
              thickness: 1,
              color: kBlueButton,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả mức độ',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listPriorityStatus.containsKey(1))
                      ? InkWell(
                      onTap: () {
                        menuController.checkboxPriorityState(
                            false, 1, "Cao;Trung bình;Thấp;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController.checkboxPriorityState(
                            true, 1, "Cao;Trung bình;Thấp;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //cao
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Cao',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listPriorityStatus.containsKey(2))
                      ? InkWell(
                      onTap: () {
                        menuController
                            .checkboxPriorityState(false, 2, "Cao;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController
                            .checkboxPriorityState(true, 2, "Cao;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //trung binf
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Trung bình',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listPriorityStatus.containsKey(3))
                      ? InkWell(
                      onTap: () {
                        menuController
                            .checkboxPriorityState(false, 3, "Trung bình;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController
                            .checkboxPriorityState(true, 3, "Trung bình;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //thap
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Thấp',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listPriorityStatus.containsKey(4))
                      ? InkWell(
                      onTap: () {
                        menuController
                            .checkboxPriorityState(false, 4, "Thấp;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController
                            .checkboxPriorityState(true, 4, "Thấp;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //
            // Tất cả trạng thái
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả trạng thái',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listStateStatus.containsKey(0))
                      ? InkWell(
                      onTap: () {
                        menuController.checkboxStatusState(
                            false, 0, "Chưa xử lý;Đang xử lý;Đã xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController.checkboxStatusState(
                            true, 0, "Chưa xử lý;Đang xử lý;Đã xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //chưa xử lý
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Chưa xử lý',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listStateStatus.containsKey(1))
                      ? InkWell(
                      onTap: () {
                        menuController
                            .checkboxStatusState(false, 1, "Chưa xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController
                            .checkboxStatusState(true, 1, "Chưa xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //đang xử lý
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Đang xử lý',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listStateStatus.containsKey(2))
                      ? InkWell(
                      onTap: () {
                        menuController
                            .checkboxStatusState(false, 2, "Đang xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController
                            .checkboxStatusState(true, 2, "Đang xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //đã xử lý
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Đã xử lý',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listStateStatus.containsKey(3))
                      ? InkWell(
                      onTap: () {
                        menuController
                            .checkboxStatusState(false, 3, "Đã xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController
                            .checkboxStatusState(true, 3, "Đã xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            // Tất cả don vi ban hanh
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả đơn vị ban hành',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listDepartmentStatus.containsKey(0))
                      ? InkWell(
                      onTap: () {
                        menuController.checkboxDepartmentState(
                            false, 0, "Bộ;Sở;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController.checkboxDepartmentState(
                            true, 0, "Chưa xử lý;Đang xử lý;Đã xử lý;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //bo
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Bộ',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listDepartmentStatus.containsKey(1))
                      ? InkWell(
                      onTap: () {
                        menuController
                            .checkboxDepartmentState(false, 1, "Bộ;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController
                            .checkboxDepartmentState(true, 1, "Bộ;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //so
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Sở',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                  (menuController.listDepartmentStatus.containsKey(2))
                      ? InkWell(
                      onTap: () {
                        menuController
                            .checkboxDepartmentState(false, 2, "Sở;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_active.png',
                        width: 30,
                        height: 30,
                      ))
                      : InkWell(
                      onTap: () {
                        menuController
                            .checkboxDepartmentState(true, 2, "Sở;");
                      },
                      child: Image.asset(
                        'assets/icons/ic_checkbox_unactive.png',
                        width: 30,
                        height: 30,
                      )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //
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
                            Get.back();
                            var status = "";
                            var level = "";
                            var department = "";
                            if (menuController.listPriorityStatus
                                .containsKey(0)) {
                              reportViewModel!.getDocumentByFilter(
                                  status, level, department);
                            } else {
                              menuController.listPriorityStatus
                                  .forEach((key, value) {
                                level += value;
                              });
                              menuController.listStateStatus
                                  .forEach((key, value) {
                                status += value;
                              });
                              menuController.listDepartmentStatus
                                  .forEach((key, value) {
                                department += value;
                              });
                            }
                            print(status);
                            print(level);
                            print(department);
                            reportViewModel!
                                .getDocumentByFilter(status, level, department);
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
