import 'package:flutter/material.dart';
import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../../model/booking_car/booking_car_model;.dart';
import '../../search_screen.dart';
import '../booking_car_search.dart';
import '../booking_car_viewmodel.dart';

class BookingEOfficeCarList extends GetView {


  final bookCarViewModel = Get.put(BookingCarViewModel());

  BookingEOfficeCarList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSearch(
              "Bố trí và điều động xe ô tô",
              SearchScreen(
                  hintText: 'Nhập số xe',
                 typeScreen: type_cars ,
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
                    controller: bookCarViewModel.controller,
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
  const BookCarEOfficeItem(this.index, this.docModel, {Key? key}) : super(key: key);

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
                  height: 60,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                    crossAxisCount: 3,
                    children: <Widget>[
                      sheetDetailBottemItem('Người đăng ký',
                          checkingStringNull(docModel!.registerUser), context),
                      sheetDetailBottemItem('Ngày đăng ký',
                        formatDate(
                            checkingStringNull(docModel!.registrationDate)), context),
                      sheetDetailBottemItem('Thời gian đăng ký',
                          checkingStringNull(docModel!.registrationTime), context),
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
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 10),
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
            height: 120,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              childAspectRatio: 3.5 / 2,
              crossAxisCount: 3,
              children: <Widget>[
                sheetDetailBottemItem('Người đăng ký',
                    checkingStringNull(docModel!.registerUser), context),
                sheetDetailBottemItem('Ngày đăng ký',
                    formatDate(
                        checkingStringNull(docModel!.registrationDate)), context),
                sheetDetailBottemItem('Thời gian đăng ký',
                    checkingStringNull(docModel!.registrationTime), context),
                sheetDetailBottemItem('Ngày khởi tạo',
                    formatDate(
                        checkingStringNull(docModel!.innitiatedDate)), context),
                sheetDetailBottemItem('Nội dung',
                    checkingStringNull(docModel!.content), context),
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
Widget priorityCarWidget(BookingCarListItems docModel) {
  if (docModel.status == "Đã đặt lịch") {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Image.asset(
          'assets/icons/ic_car_green.png',
          height: 18,
          width: 18,
        ));
  } else {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Image.asset(
          'assets/icons/ic_car_yellow.png',
          height: 18,
          width: 18,
        ));
  }
}

Widget signWidget(BookingCarListItems docModel) {
  if (docModel.status == "Đã đặt lịch") {
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
          style: const TextStyle(
              color: kGreenSign,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto'),
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
        Text(
          docModel.status!,
          style: const TextStyle(
              color: kOrangeSign,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto'),
        )
      ],
    );
  }
}
