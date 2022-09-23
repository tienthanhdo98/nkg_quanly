
import 'package:flutter/material.dart';

import '../const.dart';

Widget priorityWidget(dynamic docModel) {
  if (docModel.level == "Thấp") {
    return Container(
        decoration: BoxDecoration(
          color: kGrayPriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text('Thấp', style: TextStyle(color: kWhite))));
  } else if (docModel.level == 'Trung bình') {
    return Container(
        decoration: BoxDecoration(
          color: kBluePriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Trung bình',
              style: TextStyle(color: kWhite),
            )));
  } else {
    return Container(
        decoration: BoxDecoration(
          color: kRedPriority,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text('Cao', style: TextStyle(color: kWhite))));
  }
}

Widget bottomDateButton(String title,int value,int valueOfButton){
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Container(
        decoration:
        (value ==
            valueOfButton)
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
                    color: (value ==
                        valueOfButton)
                        ? kWhite
                        : Colors.black)))),
  );
}
Widget buttonShowListScreen(String value){
  return  Padding(padding : const EdgeInsets.all(11),child: Text(value,style: const TextStyle(fontSize: 16)));
}