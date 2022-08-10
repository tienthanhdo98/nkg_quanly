import 'package:flutter/material.dart';

const kBackGround = Color(0xFFf0f2f5);
const kLightGray = Color(0xFFfafafa);
const kLightGray2 = Color(0xFFdedede);
const kSecondText = Color(0xFFa4a4a4);
const kWhite = Color(0xFFffffff);
const kOrange = Color(0xFFf3722c);
const kViolet = Color(0xFFa155b9);
const kLoginButton = Color(0xFF5149ef);
const kBlueChart = Color(0xFF16bfd6);
const kRedChart = Color(0xFFf94144);
const kBlueButton = Color(0xFF0060ff);
const kLightBlueButton = Color(0xFF3797fb);

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

Widget headerChartTable(String header, String value) {
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
                      style: CustomTextStyle.header1TextStyle,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3)),
                    const Text(
                      "Tổng văn bản",
                      style: CustomTextStyle.secondTextStyle,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3)),
                    Text(
                      value,
                      style: CustomTextStyle.header1TextStyle,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "assets/icons/ic_more.png",
                      width: 20,
                      height: 20,
                    )),
              ))
            ],
          ),
        ),
      ),
      const Divider(
        color: kBackGround,
        thickness: 2,
      ),
    ],
  );
}

Widget borderItem(Widget widget) {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
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

class CustomTextStyle {
  static const header1TextStyle =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
  static const header2TextStyle =
      TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
  static const secondTextStyle = TextStyle(
    color: kSecondText,
    fontSize: 15,
  );
  static const textStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );
}
