import 'package:flutter/material.dart';

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
const kLightBlue = Color(0xFFdbeafe);
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
const kGrayPriority= Color(0xFFBBBBBB);
const kBluePriority= Color(0xFF3D9DF6);
const kRedPriority= Color(0xFFF63D3D);
const kGreenSign= Color(0xFF30A32E);
const kOrangeSign= Color(0xFFFF9D0B);
const kVioletButton= Color(0xFF3D34FF);
const kVioletBg= Color(0xFFEDECFF);

final kUnActiveButtonStyle =
    ElevatedButton.styleFrom(primary: kWhite, onPrimary: Colors.black);
final kActiveButtonStyle = ElevatedButton.styleFrom(primary: kBlueButton);

Widget borderText(String value, Color color) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(value),
      ),
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

Widget  legendChart(String value, Color color) {
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
          children:  const [
            Text("Nhiệm vụ",style: TextStyle(color: kLightBlueButton),),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("Xem chi tiết",style: CustomTextStyle.secondTextStyle))),
            Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.add))
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
            const Text("Tổng văn bản", style:  CustomTextStyle.secondTextStyle,),
            Text("2,846",style:  Theme.of(context).textTheme.headline1,),
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
  static const secondTextStyle = TextStyle(
    color: kSecondText,
    fontSize: 15,
  );
}
