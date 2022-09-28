
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';


import '../../../const.dart';
import '../../../const/style.dart';
import '../../../const/ultils.dart';

import '../../../const/widget.dart';
import '../../../model/booking_car/booking_car_model;.dart';
import '../../document_nonapproved/document_nonapproved_search.dart';

import '../../theme/theme_data.dart';
import '../booking_car_list.dart';
import '../booking_car_viewmodel.dart';


class BookingEOfficeCarList extends GetView {
  String? header;
  final MenuController menuController = Get.put(MenuController());
  final bookCarViewModel = Get.put(BookingCarViewModel());
  int selectedButton = 0;

  BookingEOfficeCarList({this.header});

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              //header
              headerWidgetSeatch(header!,DocumentnonapprovedSearch(
                header: header,
              ),context),
              //date table
              headerTableDate( Obx(() =>  TableCalendar(
                  locale: 'vi_VN',
                  headerVisible: false,
                  calendarFormat:  bookCarViewModel.rxCalendarFormat.value,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: bookCarViewModel.rxSelectedDay.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(
                        bookCarViewModel
                            .rxSelectedDay.value,
                        day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    if (!isSameDay(
                        bookCarViewModel
                            .rxSelectedDay.value,
                        selectedDay)) {
                      bookCarViewModel.onSelectDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (bookCarViewModel.rxCalendarFormat.value != format) {
                      // Call `setState()` when updating calendar format
                      bookCarViewModel.rxCalendarFormat.value = format;
                    }
                  }
              )),
                Center(child: InkWell(
                  onTap: (){
                    if(bookCarViewModel.rxCalendarFormat.value != CalendarFormat.month)
                    {
                      bookCarViewModel.switchFormat(CalendarFormat.month);
                    }
                    else
                    {
                      bookCarViewModel.switchFormat(CalendarFormat.week);
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Image.asset("assets/icons/ic_showmore.png",height: 15,width: 80,)),
                )),context,),
              //list
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tất cả danh sách ô tô',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        InkWell(
                          onTap: (){
                            if( menuController.rxShowStatistic.value == true)
                            {
                              menuController.changeStateShowStatistic(false);
                            }
                            else
                            {
                              menuController.changeStateShowStatistic(true);
                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                                children: [
                                  Obx(() =>(bookCarViewModel.rxBookingCarStatistic.value.total != null) ? Text(bookCarViewModel.rxBookingCarStatistic.value.total.toString(),style: textBlueCountTotalStyle) : const SizedBox.shrink()),
                                  const Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Icon(Icons.keyboard_arrow_down,color: kBlueButton,))
                                ]),
                          ),
                        ),
                        Obx(() => (menuController.rxShowStatistic.value == true) ?
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text('Còn trống'),
                                    Text(
                                        bookCarViewModel.rxBookingCarStatistic.value.vacancy.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text('Đã đặt'),
                                    Text(
                                      bookCarViewModel.rxBookingCarStatistic.value.booked.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ) : const SizedBox.shrink())
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Divider(thickness: 1,),
              ),
              Expanded(
                child: Obx(() => (bookCarViewModel.rxBookingCarItems.isNotEmpty)
                    ?
                ListView.builder(
                    itemCount:  bookCarViewModel.rxBookingCarItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BookCarEOfficeItem(
                          index, bookCarViewModel.rxBookingCarItems[index]);
                    }) : const SizedBox.shrink()),
              ),
              //bottom button
              Obx(() =>  Container(
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
                          bookCarViewModel.rxSelectedDay.value = DateTime.now();
                          bookCarViewModel.onSelectDay(DateTime.now());
                          bookCarViewModel.swtichBottomButton(0);
                        },
                        child:  bottomDateButton("Ngày",bookCarViewModel.selectedBottomButton.value,0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =  dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          bookCarViewModel.postookingCarByWeek(strdateFrom,strdateTo);
                          bookCarViewModel.swtichBottomButton(1);
                        },
                        child:  bottomDateButton("Tuần",bookCarViewModel.selectedBottomButton.value,1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          bookCarViewModel.postBookingCarByMonth();
                          bookCarViewModel.swtichBottomButton(2);
                        },
                        child:  bottomDateButton("Tháng",bookCarViewModel.selectedBottomButton.value,2),
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

  int? index;
  BookingCarListItems? docModel;

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
                          const Text('Người đăng ký',style: CustomTextStyle.grayColorTextStyle),
                          Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: Text(docModel!.registerUser!,style: Theme.of(context).textTheme.headline5))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ngày đăng ký',style: CustomTextStyle.grayColorTextStyle),
                          Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child:   Text(formatDate(docModel!.registrationDate!),style: Theme.of(context).textTheme.headline5))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Thời gian đăng ký',style: CustomTextStyle.grayColorTextStyle),
                          Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child:   Text(docModel!.registrationTime!,style: Theme.of(context).textTheme.headline5,))
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Divider(thickness: 1,))

              ],
            ),
          ),
        ],
      ),
    );
  }
}

