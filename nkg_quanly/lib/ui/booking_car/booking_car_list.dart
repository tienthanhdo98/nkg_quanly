import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/viewmodel/date_picker_controller.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/booking_car/booking_car_model;.dart';
import '../document_nonapproved/document_nonapproved_search.dart';
import '../theme/theme_data.dart';
import 'booking_car_viewmodel.dart';

class BookingCarList extends GetView {
  String? header;

  final bookCarViewModel = Get.put(BookingCarViewModel());

  BookingCarList({this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSeatch(
              header!,
              DocumentnonapprovedSearch(
                header: header,
              ),
              context),
          //date table
          headerTableDatePicker(context, bookCarViewModel),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Text(
                  'Tất cả danh sách ô tô',
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
                                  height: 300,
                                  child: FilterBookingCarBottomSheet(bookCarViewModel));
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
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              color: Theme.of(context).cardColor,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 40,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              "Cả ngày",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                        const VerticalDivider(width: 1, thickness: 1),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Danh sách lịch làm việc",
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15))
              ]),
            ),
          ),
          Expanded(
            child: Obx(() => (bookCarViewModel.rxBookingCarItems.isNotEmpty)
                ? ListView.builder(
                    itemCount: bookCarViewModel.rxBookingCarItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BookCarItem(
                          index, bookCarViewModel.rxBookingCarItems[index]);
                    })
                : noData()),
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

class BookCarItem extends StatelessWidget {
  BookCarItem(this.index, this.docModel);

  int? index;
  BookingCarListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 0, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: SizedBox(
              width: 90,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(docModel!.registrationTime!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto'))),
                ],
              ),
            ),
          ),
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
                const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                const Text(
                  'Nội dung',
                  style: CustomTextStyle.grayColorTextStyle,
                ),
                Text(docModel!.content!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/ic_user.png',
                      width: 30,
                      height: 30,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Text(docModel!.registerUser!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto'))
                  ],
                ),
              ],
            ),
          ),
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

class FilterBookingCarBottomSheet extends StatelessWidget {
  const FilterBookingCarBottomSheet( this.bookCarViewModel,
      {Key? key})
      : super(key: key);
  final BookingCarViewModel? bookCarViewModel;

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
                      'Tất cả danh sách ô tô',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() => (bookCarViewModel!.mapAllFilter.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            bookCarViewModel!.checkboxFilterAll(false, 0);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            bookCarViewModel!.checkboxFilterAll(true, 0);
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
            // Tất cả muc do
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: lisStatus.length,
                  itemBuilder: (context, index) {
                    var item = lisStatus[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (bookCarViewModel!.mapStatusFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        bookCarViewModel!.checkboxStatus(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        bookCarViewModel!.checkboxStatus(
                                            true, index, "$item;");
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
                      ],
                    );
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
                            if (bookCarViewModel!.mapAllFilter.containsKey(0)) {
                              bookCarViewModel!.getBookingCarByFilter(status);
                            } else {
                              if (bookCarViewModel!.mapAllFilter
                                  .containsKey(3)) {
                                status = "";
                              } else {
                                bookCarViewModel!.mapStatusFilter
                                    .forEach((key, value) {
                                  status += value;
                                });
                              }
                            }
                            print(status);
                            bookCarViewModel!.getBookingCarByFilter(status);
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

var lisStatus = ["Đã đặt lịch", "Còn trống"];
