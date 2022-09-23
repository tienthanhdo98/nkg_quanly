import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'const/ultils.dart';

const kBackGround = Color(0xFFf0f2f5);
const kLightGray = Color(0xFFfafafa);
const kLightGray2 = Color(0xFFdedede);
const kSecondText = Color(0xFFa4a4a4);
const kWhite = Color(0xFFffffff);
const kPink = Color(0xFF6510B4);
const kBlueButton = Color(0xFF3D34FF);
const kOrange = Color(0xFFf3722c);
const kViolet = Color(0xFFa155b9);
const kLoginButton = Color(0xFF5149ef);
const kBlueChart = Color(0xFF16bfd6);
const kRedChart = Color(0xFFf94144);
// const kBlueButton = Color(0xFF0060ff);
const kLightBlue = Color(0xFF3D34FF);
// const kLightBlue = Color(0xFFdbeafe);
const kLightBlueButton = Color(0xFF3797fb);

//chart
const kBlueLineChart2 = Color(0xFF61a9f3);

//Dark Mode
const kDBackGround = Color(0xFF1b1c30);
const kDBackgroundItem = Color(0xFF2a2b40);
const kDTable = Color(0xFF5b5c6e);
const kDLine = Color(0xFF727586);

//
const kgray = Color(0xFFF0F2F5);
const kgrayText = Color(0xFFAEAEAE);
const kDarkGray = Color(0xFFD9D9D9);
const kGrayPriority = Color(0xFFBBBBBB);
const kBluePriority = Color(0xFF3D9DF6);
const kRedPriority = Color(0xFFF63D3D);
const kGreenSign = Color(0xFF30A32E);
const kOrangeSign = Color(0xFFFF9D0B);
const kVioletButton = Color(0xFF3D34FF);
const kVioletBg = Color(0xFFEDECFF);
const kGrayButton = Color(0xFFD9D9D9);

var listColorChart = [kRedPriority,kGreenSign,kOrange,kViolet,kBlueChart,kBluePriority];
//string
String jsonGetByMonth = '{"pageIndex":1,"pageSize":10,"isMonth": true,"dateFrom":"${formatDateToString(dateNow)}"}';

final kUnActiveButtonStyle =
    ElevatedButton.styleFrom(primary: kWhite, onPrimary: Colors.black);
final kActiveButtonStyle = ElevatedButton.styleFrom(primary: kBlueButton);

Widget borderText(String value,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kgray,
        border: Border.all(
          color: kDarkGray
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(value,style: Theme.of(context).textTheme.headline4,),
      ),
    ),
  );
}
Widget headerWidget(String header, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(width: 1
        , color: Theme.of(context).dividerColor,
        ))),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              'assets/icons/ic_arrow_back.png',
              width: 18,
              height: 18,
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          Text(
            header,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    ),
  );
}

Widget headerWidgetSeatch(String header, GetView searchScreen, BuildContext context) {
  return Container(
    color: Theme.of(context).cardColor,
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_outlined),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          Text(
            header,
            style: Theme.of(context).textTheme.headline1,
          ),
          Expanded(
              child: InkWell(
                onTap: () {
                  Get.to(() => searchScreen);
                },
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                        decoration:  BoxDecoration(
                          color: kgray,
                          borderRadius:
                          BorderRadius.circular(50),
                        ),
                        child: Image.asset('assets/icons/ic_search.png',width: 20,height: 20,))),
              ))
        ],
      ),
    ),
  );
}

Widget headerTableDate(Widget widget1, Widget widget2,BuildContext context){
  return  Container(
    color: kgray,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            "${dateNow.year} Tháng ${dateNow.month}",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        widget1,
        widget2
      ],
    ),
  );
}

Widget borderInputText(String value) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: TextField(
      autofocus: true,
      cursorColor: kBlueButton,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kSecondText, width: 1)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kLightGray2, width: 1)),
        hintText: value,
      ),
    ),
  );
}

Widget legendChart(String value, Color color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          height: 15,
          width: 30,
          color: color,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
        Text(value)
      ],
    ),
  );
}

Widget headerChartTable(String header, String value, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      header,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3)),
                    const Text(
                      "Tổng văn bản",
                      style: CustomTextStyle.secondTextStyle,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3)),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.headline1,
                    )
                  ],
                ),
              ),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.more_horiz)),
              ))
            ],
          ),
        ),
      ),
      const Divider(
        thickness: 2,
      ),
    ],
  );
}

Widget headerChartTable2(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: const [
            Text(
              "Nhiệm vụ",
              style: TextStyle(color: kLightBlueButton),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("Xem chi tiết",
                        style: CustomTextStyle.secondTextStyle))),
            Align(alignment: Alignment.centerRight, child: Icon(Icons.add))
          ],
        ),
      ),
      const Divider(
        thickness: 2,
      ),
      Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Tổng văn bản",
              style: CustomTextStyle.secondTextStyle,
            ),
            Text(
              "2,846",
              style: Theme.of(context).textTheme.headline1,
            ),
          ])),
    ],
  );
}

Widget borderItem(Widget widget, BuildContext context) {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ]),
      child: widget);
}

Widget border(Widget widget, BuildContext context) {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ]),
      child: widget);
}

class CustomTextStyle {
  static const grayColorTextStyle = TextStyle(
    color: kgrayText,
    fontSize: 12,
  );
  static const secondTextStyle = TextStyle(
    color: kSecondText,
    fontSize: 15,
  );
  static const robotow400s12TextStyle = TextStyle(
      color: Colors.black,
      fontSize:12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400
  );
  static const robotow400s14TextStyle = TextStyle(
      color: Colors.black,
      fontSize:14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400
  );
  static const roboto400s16TextStyle = TextStyle(
      color: Colors.black,
      fontSize:16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400
  );
  static const roboto700TextStyle = TextStyle(
    color: Colors.black,
    fontSize:16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700
  );
  static const robotow700s24TextStyle = TextStyle(
      color: Colors.black,
      fontSize:24,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700
  );
  static const robotow700s12TextStyle = TextStyle(
      color: Colors.black,
      fontSize:12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700
  );
}
String calcuPercen(int first, int total){
  var f = NumberFormat("###.0#", "en_US");
  var res = f.format ((first/total)*100).toString();
  return "$res%";
}