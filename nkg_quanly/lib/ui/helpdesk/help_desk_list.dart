import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/helpdesk_model/helpdesk_filter_model.dart';
import '../../model/helpdesk_model/helpdesk_model.dart';
import '../theme/theme_data.dart';
import 'helpdesk_search.dart';
import 'helpdesk_viewmodel.dart';

class HelpDeskList extends GetView {
  final helpdeskViewModel = Get.put(HelpdeskViewModel());

  HelpDeskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          headerWidgetSearch(
              "Helpdesk", HelpdeskSearch(helpdeskViewModel), context),
          //date table
          Obx(() => (helpdeskViewModel.rxStatusSelected.value != "") ?  Padding(
              padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: kDarkGray, style: BorderStyle.solid, width: 1),
                ),
                child: Padding(
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
                            const Text('Trạng thái',
                                style: CustomTextStyle.grayColorTextStyle),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Obx(() => Text(
                                    helpdeskViewModel.rxStatusSelected.value,
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
              ),
            ) : SizedBox.shrink(),
          ),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tổng số câu hỏi',
                      style: Theme.of(context).textTheme.headline3,
                    ),
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
                                    height: 400,
                                    child: FilterHelpDeskBottomSheet(
                                        helpdeskViewModel));
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
                fromDateToDateWidget(helpdeskViewModel,(){
                  String strdateFrom =
                      menuController.rxFromDateWithoutWeekDayToApi.value;
                  String strdateTo =
                      menuController.rxToDateWithoutWeekDayToApi.value;
                  if(strdateFrom != "" && strdateTo != "") {
                    helpdeskViewModel.getHelpdeskListByDiffDate(
                        strdateFrom, strdateTo);
                  }
                  else
                  {
                    helpdeskViewModel.postHelpdeskListAndStatistic();
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
              child: Obx(() => (helpdeskViewModel
                      .rxHelpdeskListItems.isNotEmpty)
                  ? ListView.builder(
                      controller: helpdeskViewModel.controller,
                      itemCount: helpdeskViewModel.rxHelpdeskListItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              // Get.to(() => DocumentnonapprovedDetail(
                              //     id: helpdeskViewModel
                              //         .rxHelpdeskListItems[index].id!));
                            },
                            child: HelpDeskListItem(
                                index,
                                helpdeskViewModel.rxHelpdeskListItems[index],
                                helpdeskViewModel));
                      })
                  : Align(alignment: Alignment.topCenter, child: noData()))),
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
                          helpdeskViewModel.getHelpdeskListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          helpdeskViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            helpdeskViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String strDateFrom = formatDateToString(findFirstDateOfTheWeek(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheWeek(dateNow));

                          helpdeskViewModel.getHelpdeskListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          helpdeskViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            helpdeskViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          String strDateFrom = formatDateToString(findFirstDateOfTheMonth(dateNow));
                          String strDateTo = formatDateToString(findLastDateOfTheMonth(dateNow));

                          helpdeskViewModel.getHelpdeskListByDiffDate(
                              strDateFrom, strDateTo);
                          menuController.rxFromDateWithoutWeekDayToApi.value = strDateFrom;
                          menuController.rxToDateWithoutWeekDayToApi.value = strDateTo;
                          helpdeskViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            helpdeskViewModel.selectedBottomButton.value, 2),
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

class HelpDeskListItem extends StatelessWidget {
  HelpDeskListItem(this.index, this.docModel, this.helpdeskViewModel,
      {Key? key})
      : super(key: key);

  final int? index;
  final HelpDeskListItems? docModel;
  HelpdeskViewModel? helpdeskViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${index! + 1}. ${docModel!.subject}",
            style: Theme.of(context).textTheme.headline2,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: textCodeStyle(checkingStringNull(docModel!.code))),
          signWidget(docModel!, helpdeskViewModel!.rxHelpdeskFilterList),
          SizedBox(
            height: 80,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Người xử lý',
                        style: CustomTextStyle.secondTextStyle),
                    Text(
                      checkingStringNull(docModel!.organizationUnitName),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.secondTextStyle),
                    Text(formatDate(docModel!.dateCreated!))
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

//filter by ui
class FilterHelpDeskBottomSheet extends StatelessWidget {
  const FilterHelpDeskBottomSheet(this.helpdeskViewModel, {Key? key})
      : super(key: key);
  final HelpdeskViewModel? helpdeskViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          // Tất cả trang thai state
          FilterAllItem(
              "Tất cả trạng thái",
              1,
              helpdeskViewModel!.mapAllFilter,
              helpdeskViewModel!.mapStatusFilter,
              helpdeskViewModel!.rxHelpdeskFilterList,
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          Obx(() => SizedBox(
                height: 210,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: helpdeskViewModel!.rxHelpdeskFilterList.length,
                    itemBuilder: (context, index) {
                      var item = helpdeskViewModel!.rxHelpdeskFilterList[index];
                      return FilterItem(item.name!, item.status.toString(),
                          index, helpdeskViewModel!.mapStatusFilter);
                    }),
              )),

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
                        var status = "";
                        var statusName = "";
                        if (helpdeskViewModel!.mapAllFilter.containsKey(1)) {
                          changeValueSelectedFilter(
                              helpdeskViewModel!.rxStatusSelected,
                              "Tất cả trạng thái");
                          helpdeskViewModel!.postHelpdeskListByFilter(
                              "");
                        } else {
                          helpdeskViewModel!.mapStatusFilter
                              .forEach((key, value) {
                            status += value;
                          });
                          var listId = status.split(";");
                          for (var id in listId) {
                            for (var item
                                in helpdeskViewModel!.rxHelpdeskFilterList) {
                              if (item.status.toString() == id) {
                                statusName += "${item.name};";
                              }
                            }
                          }
                          if (statusName != "") {
                            changeValueSelectedFilter(
                                helpdeskViewModel!.rxStatusSelected,
                                statusName.substring(0, statusName.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                helpdeskViewModel!.rxStatusSelected, "");
                          }
                          if(status != "") {
                            helpdeskViewModel!.postHelpdeskListByFilter(
                                status.substring(0, status.length - 1));
                          }

                        }
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

Widget signWidget(HelpDeskListItems docModel,
    RxList<HelpdeskFilterModel> rxListStatusFilter) {
  var status = "";
  for (var element in rxListStatusFilter) {
    if (docModel.problemStatus == element.status.toString()) {
      status = element.name!;
    }
  }
  if (status == "Hoàn thành") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          status,
          style: const TextStyle(color: kGreenSign),
        )
      ],
    );
  } else if (status == "Đang xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          status,
          style: const TextStyle(color: kGreenSign),
        )
      ],
    );
  } else if (status == "Chờ tiếp nhận") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          color: kOrangeSign,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          status,
          style: const TextStyle(color: kOrangeSign),
        )
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(
          status,
          style: const TextStyle(color: kRedChart),
        )
      ],
    );
  }
}
