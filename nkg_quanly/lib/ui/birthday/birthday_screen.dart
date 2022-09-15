import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const/ultils.dart';
import '../../model/birthday_model/birthday_model.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../document_nonapproved/document_nonapproved_search.dart';
import 'birthday_search.dart';

class BirthDayScreen extends GetView {
  DateTime dateNow = DateTime.now();
  int selected = 0;
  int selectedButton = 0;
  String? header;
  String? icon;

  final homeController = Get.put(HomeViewModel());

  BirthDayScreen({Key? key, this.header, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: homeController.postBirthDay(),
          builder: (context, AsyncSnapshot<BirthDayModel> snapshot){
            if(snapshot.hasData) {
              BirthDayModel item = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //header
                  Container(
                    color: Theme
                        .of(context)
                        .cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios_outlined),
                          ),
                          const Padding(padding: EdgeInsets.fromLTRB(
                              10, 0, 0, 0)),
                          Text(
                            header!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline1,
                          ),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() =>
                                      BirthDaySearch(
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline1,
                          ),
                        ),
                        //date header
                        TableCalendar(
                          calendarStyle: CalendarStyle(
                              todayTextStyle: const TextStyle(color: kWhite),
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
                        Text(item.totalRecords!.toString(), style: Theme
                            .of(context)
                            .textTheme
                            .headline1,),
                      ],),
                  ),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Divider(
                        thickness: 1,
                      )),
                  Flexible(
                      child: ListView.builder(
                          itemCount: item.items!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  // Get.to(() => DocumentInDetail(
                                  //     id: snapshot.data!.items![index].id!));
                                },
                                child:
                                BirthDayItem(index,item.items![index]));
                          })),
                  //list work
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .cardColor,
                          border: Border(top: BorderSide(color: Theme
                              .of(context)
                              .dividerColor))),
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
                                  child: Center(child: Text("Ngày",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: (selectedButton == 0)
                                              ? kBlueButton
                                              : Colors.black)))),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: (selectedButton == 1)
                                                ? kBlueButton
                                                : Colors.black),
                                      ))),
                            ),
                          ),

                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  decoration: (selectedButton == 2)
                                      ? BoxDecoration(
                                    color: kLightBlue,
                                    borderRadius: BorderRadius.circular(50),
                                  )
                                      : const BoxDecoration(),
                                  height: 40,
                                  width: 40,
                                  child: Center(child: Text("Tháng",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: (selectedButton == 2)
                                              ? kBlueButton
                                              : Colors.black)))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
class BirthDayItem extends StatelessWidget {
  BirthDayItem(this.index, this.docModel);

  int? index;
  BirthDayListItems? docModel;

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
                    Text(formatDate(docModel!.dateOfBirth!))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chức vụ',style: CustomTextStyle.secondTextStyle),
                    Text(docModel!.position!)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đơn vị',style: CustomTextStyle.secondTextStyle),
                    Text(docModel!.organizationName!)
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


