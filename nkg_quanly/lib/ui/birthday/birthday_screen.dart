import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const.dart';
import 'package:table_calendar/table_calendar.dart';

import '../document_nonapproved/document_nonapproved_search.dart';

class BirthDayScreen extends GetView {
  DateTime dateNow = DateTime.now();
  int selected = 0;
  int selectedButton = 0;
  String? header;
  String? icon;

  BirthDayScreen({Key? key, this.header, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            Container(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_outlined),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Text(
                      header!,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(() => DocumentnonapprovedSearch(
                              header: header,
                            ));
                          },
                          child: const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.search)),
                        ))
                  ],
                ),
              ),
            ),
            //date table
            Container(
              width: double.infinity,
              height: 155,
              color: kgray,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "${dateNow.year} Tháng ${dateNow.month}",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  //date header
                  TableCalendar(
                    calendarStyle: CalendarStyle(
                        todayTextStyle: TextStyle(color: kWhite),
                        todayDecoration: BoxDecoration(
                          color: kBlueButton,
                          borderRadius: BorderRadius.circular(20),
                        )),
                    calendarBuilders: CalendarBuilders(
                        selectedBuilder: (context, day, focusday) {
                          return Container(
                            decoration: BoxDecoration(color: kBlueButton),
                          );
                        }),
                    locale: 'vi_VN',
                    headerVisible: false,
                    calendarFormat: CalendarFormat.week,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                  ),
                  //list work
                ],
              ),
            ),
            //
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Tổng sinh nhật'),
                Text('5',style: Theme.of(context).textTheme.headline1,),
              ],),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Divider(
                  thickness: 1,
                )),
            Flexible(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            // Get.to(() => DocumentInDetail(
                            //     id: snapshot.data!.items![index].id!));
                          },
                          child:
                          BirthDayItem());
                    })),
            //list work
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border:  Border(top: BorderSide(color: Theme.of(context).dividerColor))),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {

                        },
                        child: Container(
                            decoration: (selectedButton == 0)
                                ? BoxDecoration(
                              color: kLightBlue,
                              borderRadius: BorderRadius.circular(50),
                            )
                                : const BoxDecoration(),
                            height: 40,
                            width: 40,
                            child: Center(child: Text("Ngày" , style: TextStyle(fontWeight: FontWeight.bold,color: (selectedButton == 0) ? kBlueButton : Colors.black)))),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {

                        },
                        child: Container(
                            decoration: (selectedButton == 1)
                                ? BoxDecoration(
                              color: kLightBlue,
                              borderRadius: BorderRadius.circular(50),
                            )
                                : const BoxDecoration(),
                            height: 40,
                            width: 40,
                            child: Center(
                                child: Text(
                                  "Tuần",
                                  style: TextStyle(fontWeight: FontWeight.bold,color: (selectedButton == 1) ? kBlueButton : Colors.black),
                                ))),
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: () {
                        },
                        child: Container(
                            decoration: (selectedButton == 2)
                                ? BoxDecoration(
                              color: kLightBlue,
                              borderRadius: BorderRadius.circular(50),
                            )
                                : const BoxDecoration(),
                            height: 40,
                            width: 40,
                            child: Center(child: Text("Tháng",  style: TextStyle(fontWeight: FontWeight.bold,color: (selectedButton == 2) ? kBlueButton : Colors.black)))),
                      ),
                    )
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
class birthDay {
  String? name;

}
class BirthDayItem extends StatelessWidget {
  // BirthDayItem(this.index, this.docModel);
  //
  // int? index;
  // birthDay? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Nguyễn Duy Anh",
                style: Theme.of(context).textTheme.headline2,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset('assets/icons/ic_round_birthday.png',width: 24,height: 24,))),
            ],
          ),
          SizedBox(
            height: 80,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 20,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày sinh',style: CustomTextStyle.secondTextStyle),
                    Text('20/01/2980')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chức vụ',style: CustomTextStyle.secondTextStyle),
                    Text('Trưởng phòng Hành Chính')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đơn vị',style: CustomTextStyle.secondTextStyle),
                    Text('Phòng hành Chính')
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


