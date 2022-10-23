import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../../model/booking_car/booking_car_model;.dart';
import '../../document_nonapproved/document_nonapproved_search.dart';
import '../booking_car_list.dart';
import '../booking_car_search.dart';
import '../booking_car_viewmodel.dart';

class BookingEOfficeCarList extends GetView {
  String? header;

  final bookCarViewModel = Get.put(BookingCarViewModel());

  BookingEOfficeCarList({this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              header!,
              BookingCarSearch(
                  bookCarViewModel
              ),
              context),
          //date table
          headerTableDatePicker(context, bookCarViewModel),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tất cả danh sách ô tô',
                  style: Theme.of(context).textTheme.headline5,
                ),
                InkWell(
                  onTap: () {
                    if (menuController.rxShowStatistic.value == true) {
                      menuController.changeStateShowStatistic(false);
                    } else {
                      menuController.changeStateShowStatistic(true);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(children: [
                      Obx(() => (bookCarViewModel
                                  .rxBookingCarStatistic.value.total !=
                              null)
                          ? Text(
                              bookCarViewModel.rxBookingCarStatistic.value.total
                                  .toString(),
                              style: textBlueCountTotalStyle)
                          : const SizedBox.shrink()),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: kBlueButton,
                          ))
                    ]),
                  ),
                ),
                Obx(() => (menuController.rxShowStatistic.value == true)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Còn trống'),
                                  Text(
                                      bookCarViewModel
                                          .rxBookingCarStatistic.value.vacancy
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã đặt'),
                                  Text(
                                    bookCarViewModel
                                        .rxBookingCarStatistic.value.booked
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink())
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Divider(
              thickness: 1,
            ),
          ),
          Expanded(
            child: Obx(() => (bookCarViewModel.rxBookingCarItems.isNotEmpty)
                ? ListView.builder(
                    itemCount: bookCarViewModel.rxBookingCarItems.length,
                    shrinkWrap: true,
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
                                  height: 320,
                                  child: DetailBookingCarsBottomSheet(
                                      index,
                                      bookCarViewModel
                                          .rxBookingCarItems[index]));
                            },
                          );
                        },
                        child: BookCarEOfficeItem(
                            index, bookCarViewModel.rxBookingCarItems[index]),
                      );
                    })
                : const SizedBox.shrink()),
          ),
          //bottom button
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
                          bookCarViewModel.onSelectDay(DateTime.now());
                          bookCarViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            bookCarViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          bookCarViewModel.postookingCarByWeek(
                              strdateFrom, strdateTo);
                          bookCarViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            bookCarViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          bookCarViewModel.postBookingCarByMonth();
                          bookCarViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            bookCarViewModel.selectedBottomButton.value, 2),
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

class BookCarEOfficeItem extends StatelessWidget {
  BookCarEOfficeItem(this.index, this.docModel);

  final int? index;
  final BookingCarListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${index! + 1}. ${docModel!.code}",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: priorityCarWidget(docModel!)),
                  ],
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                signWidget(docModel!),
                SizedBox(
                  height: 50,
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
                          const Text('Người đăng ký',
                              style: CustomTextStyle.grayColorTextStyle),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text(
                                  checkingStringNull(docModel!.registerUser),
                                  style: Theme.of(context).textTheme.headline5))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ngày đăng ký',
                              style: CustomTextStyle.grayColorTextStyle),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text(
                                  formatDate(checkingStringNull(
                                      docModel!.registrationDate)),
                                  style: Theme.of(context).textTheme.headline5))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Thời gian đăng ký',
                              style: CustomTextStyle.grayColorTextStyle),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text(
                                checkingStringNull(docModel!.registrationTime),
                                style: Theme.of(context).textTheme.headline5,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Divider(
                      thickness: 1,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBookingCarsBottomSheet extends StatelessWidget {
  const DetailBookingCarsBottomSheet(this.index, this.docModel, {Key? key})
      : super(key: key);
  final int? index;
  final BookingCarListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin bố trí ô tô',
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
          signWidget(docModel!),
          SizedBox(
            height: 135,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Người đăng ký',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(checkingStringNull(docModel!.registerUser),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đăng ký',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                            formatDate(
                                checkingStringNull(docModel!.registrationDate)),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời gian đăng ký',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          checkingStringNull(docModel!.registrationTime),
                          style: Theme.of(context).textTheme.headline5,
                        ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày khởi tạo',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          formatDate(
                              checkingStringNull(docModel!.innitiatedDate)),
                          style: Theme.of(context).textTheme.headline5,
                        ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nội dung',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          checkingStringNull(docModel!.content),
                          style: Theme.of(context).textTheme.headline5,
                        ))
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
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
                        child: const Padding(
                            padding: EdgeInsets.all(12), child: Text('Đóng'))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
