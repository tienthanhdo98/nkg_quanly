import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/ui/search_screen.dart';

import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/birthday_model/birthday_model.dart';

import 'birthday_viewmodel.dart';

class BirthDayScreen extends GetView {

  final birthDayViewModel = Get.put(BirthDayViewModel());

  BirthDayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    birthDayViewModel.postBirthDayDefault();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            headerWidgetSearch('Sinh nhật', SearchScreen(hintText: 'Nhập tên cán bộ, chức vụ',typeScreen: type_birthDay,), context),
            //date table
            headerTableDatePicker(context, birthDayViewModel),
            //
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tổng sinh nhật',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      (birthDayViewModel.rxBirthDayModel.value.totalRecords !=
                              null)
                          ? Text(
                              birthDayViewModel
                                  .rxBirthDayModel.value.totalRecords
                                  .toString(),
                              style: Theme.of(context).textTheme.headline1,
                            )
                          : Text(
                              "0",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                    ],
                  )),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Divider(
                  thickness: 1,
                )),
            Expanded(
                child: Obx(() => ListView.builder(
                  controller: birthDayViewModel.controller,
                    itemCount: birthDayViewModel.rxBirthDayListItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            // Get.to(() => DocumentInDetail(
                            //     id: snapshot.data!.items![index].id!));
                          },
                          child: BirthDayItem(index,
                              birthDayViewModel.rxBirthDayListItems[index]));
                    }))),
            //list work
            Obx(() => Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border(
                          top: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            menuController.rxSelectedDay.value = DateTime.now();
                            birthDayViewModel.onSelectDay(DateTime.now());
                            birthDayViewModel.swtichBottomButton(0);
                          },
                          child: bottomDateButton("Ngày",
                              birthDayViewModel.selectedBottomButton.value, 0),
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
                            birthDayViewModel.postBirthDayByWeek(
                                strdateFrom, strdateTo);
                            birthDayViewModel.swtichBottomButton(1);
                          },
                          child: bottomDateButton("Tuần",
                              birthDayViewModel.selectedBottomButton.value, 1),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            birthDayViewModel.postBirthDayByMonth();
                            birthDayViewModel.swtichBottomButton(2);
                          },
                          child: bottomDateButton("Tháng",
                              birthDayViewModel.selectedBottomButton.value, 2),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class BirthDayItem extends StatelessWidget {
  BirthDayItem(this.index, this.docModel);

  final int? index;
  final BirthDayListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                docModel!.employeeName!,
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/icons/ic_round_birthday.png',
                        width: 24,
                        height: 24,
                      ))),
            ],
          ),
          SizedBox(
            height: 80,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 20,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày sinh',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.dateOfBirth!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chức vụ',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.position!,
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đơn vị',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.organizationName!,
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
