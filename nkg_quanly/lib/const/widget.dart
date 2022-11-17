import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/style.dart';
import 'package:nkg_quanly/const/utils.dart';

import 'const.dart';

Widget priorityWidget(dynamic docModel) {
  if (docModel.level == "Thấp") {
    return Container(
        decoration: BoxDecoration(
          color: kGrayPriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text('Thấp', style: TextStyle(color: kWhite,fontSize: 14))));
  } else if (docModel.level == 'Trung Bình') {
    return Container(
        decoration: BoxDecoration(
          color: kBluePriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Trung bình',
              style: TextStyle(color: kWhite,fontSize: 14),
            )));
  } else {
    return Container(
        decoration: BoxDecoration(
          color: kRedPriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text('Cao', style: TextStyle(color: kWhite,fontSize: 14))));
  }
}

Widget bottomDateButton(String title, int value, int valueOfButton) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Container(
        decoration: (value == valueOfButton)
            ? BoxDecoration(
                color: kLightBlue,
                borderRadius: BorderRadius.circular(50),
              )
            : const BoxDecoration(),
        height: 40,
        width: 40,
        child: Center(
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (value == valueOfButton) ? kWhite : Colors.black)))),
  );
}

Widget buttonPmis(String title, int value, int valueOfButton) {
  return Container(
      decoration: (value == valueOfButton)
          ? BoxDecoration(
        color: kLightBlue,
        borderRadius: BorderRadius.circular(10),
      )
          : BoxDecoration(
          color: kDarkGray,
          borderRadius: BorderRadius.circular(10),
      ),
      height: 40,
      width: 40,
      child: Center(
          child: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (value == valueOfButton) ? kWhite : Colors.black))));
}

Widget buttonShowListScreen(String value) {
  return Padding(
      padding: const EdgeInsets.all(11),
      child: Text(value, style: const TextStyle(fontSize: 16)));
}

Widget buttonLineInBottonSheet() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
    child: Center(
        child: InkWell(
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        "assets/icons/ic_showmore.png",
        height: 15,
        width: 80,
      ),
    )),
  );
}

Widget borderTextFilterEOffice(String? value, BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: kDarkGray),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value!,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
          Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/icons/ic_arrow_down.png',
                width: 14,
                height: 14,
              ))
        ],
      ),
    ),
  );
}
Widget loadingIcon()
{
  return const Center(child: CircularProgressIndicator());
}
Widget noData(){
  return const Text("Không có bản ghi nào");
}
Widget textCodeStyle(String code) {
  return Row(
    children: [
      Container(
        width: 5,
        height: 5,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kDarkGray,
        ),
      ),
      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
      Text(
        code,
        style: CustomTextStyle.grayColorTextStyle,
      )
    ],
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
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 15,
        width: 30,
        color: color,
      ),
      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
      Text(value)
    ],
  );
}
Widget legendChartCircleHozi(String value, Color color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50)
          ),
          height: 10,
          width: 10,

        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
        Text(value,style: const TextStyle(fontSize: 12),)
      ],
    ),
  );
}
Widget legendChartCircleVerti(String value, Color color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: color,
            borderRadius: BorderRadius.circular(50)
          ),
          height: 10,
          width: 10,

        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
        Expanded(child: Text(value,style: const TextStyle(fontSize: 12),))
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
        padding: const EdgeInsets.all(15),
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
Widget infoDetailWidget(String title,String value,BuildContext context)
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 25,
        child: Text(title,
            style: CustomTextStyle.grayColorTextStyle),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Text(value,
              style: Theme.of(context).textTheme.headline5,maxLines: 2,overflow: TextOverflow.ellipsis,))
    ],
  );
}
Widget sheetDetailBottemItem(String title, String value, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: CustomTextStyle.grayColorTextStyle),
      const Padding(padding: EdgeInsets.only(top: 5)),
      Text(value, style: Theme.of(context).textTheme.headline5)
    ],
  );
}