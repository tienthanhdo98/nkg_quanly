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
  final String? header;

  final helpdeskViewModel = Get.put(HelpdeskViewModel());

  HelpDeskList({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              header!,
              HelpdeskSearch(
                  helpdeskViewModel
              ),
              context),
          //date table
          headerTableDatePicker(context, helpdeskViewModel),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Text(
                  'Tổng số câu hỏi',
                  style: Theme.of(context).textTheme.headline3,
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
                                  height: 450,
                                  child: FilterHelpDeskBottomSheet(helpdeskViewModel));
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
              child: Obx(() => (helpdeskViewModel.rxHelpdeskListItems.isNotEmpty)
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
                                index, helpdeskViewModel.rxHelpdeskListItems[index],helpdeskViewModel));
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
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateNow);
                          helpdeskViewModel.posHelpdeskListByWeek(
                              strdateFrom, strdateTo);
                          helpdeskViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            helpdeskViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                              dateNow.subtract(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateTo);
                          String strdateTo = formatDateToString(dateNow);
                          helpdeskViewModel.posHelpdeskListByWeek(
                              strdateFrom, strdateTo);
                          helpdeskViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            helpdeskViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                          dateNow.subtract(const Duration(days: 30));
                          String strdateFrom = formatDateToString(dateTo);
                          String strdateTo = formatDateToString(dateNow);
                          helpdeskViewModel.posHelpdeskListByWeek(
                              strdateFrom, strdateTo);
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
  HelpDeskListItem(this.index, this.docModel,this.helpdeskViewModel);

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
          signWidget(docModel!,helpdeskViewModel!.rxHelpdeskFilterList),
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
                    Text(checkingStringNull(docModel!.organizationUnitName),maxLines: 3,overflow: TextOverflow.ellipsis,)
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
  const FilterHelpDeskBottomSheet( this.helpdeskViewModel,
      {Key? key})
      : super(key: key);
  final HelpdeskViewModel? helpdeskViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            // Tất cả trang thai state
            FilterAllItem( "Tất cả trạng thái", 1,helpdeskViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            Obx(()=>SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: helpdeskViewModel!.rxHelpdeskFilterList.length,
                  itemBuilder: (context, index) {
                    var item = helpdeskViewModel!.rxHelpdeskFilterList[index];
                    return
                      FilterItem(item.name!,item.status.toString(),index,
                          helpdeskViewModel!.mapStatusFilter);
                  }),
            )),

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
                            Get.back();
                            var status = "";
                              if(helpdeskViewModel!.mapAllFilter.containsKey(1))
                                {
                                  helpdeskViewModel!
                                      .postHelpdeskListByFilter(status);
                                }
                              else
                                {
                                  helpdeskViewModel!.mapStatusFilter
                                      .forEach((key, value) {
                                    status += value;
                                  });
                                  if(status.isNotEmpty)
                                    {
                                      helpdeskViewModel!
                                          .postHelpdeskListByFilter(status.substring(0,status.length-1));
                                    }
                                  else{
                                    helpdeskViewModel!
                                        .postHelpdeskListByFilter("");
                                  }

                                }

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

Widget signWidget(HelpDeskListItems docModel, RxList<HelpdeskFilterModel> rxListStatusFilter) {

  var status = "";
  for (var element in rxListStatusFilter) {
      if(docModel.problemStatus == element.status.toString())
        {
            status = element.name!;
        }
  }
  if(status == "Hoàn thành")
    {
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
            style: TextStyle(color: kGreenSign),
          )
        ],
      );
    }
  else if(status =="Đang xử lý"){
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
          style: TextStyle(color: kGreenSign),
        )
      ],
    );
  }
  else if(status == "Chờ tiếp nhận"){
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
          style: TextStyle(color: kOrangeSign),
        )
      ],
    );
  }
  else {
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
          style: TextStyle(color: kRedChart),
        )
      ],
    );
  }

  }

