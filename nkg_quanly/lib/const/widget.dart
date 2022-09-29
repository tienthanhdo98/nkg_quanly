
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


Widget borderTextFilterEOffice(String? value,BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(
          color: kDarkGray
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
          children: [
            Text(value!,style: Theme.of(context).textTheme.headline4,),
            const Spacer(),
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
Widget textCodeStyle(String code){
  return   Row(children: [
    Container(
      width: 5,
      height: 5,
      decoration:const BoxDecoration(
        shape: BoxShape.circle,
        color: kDarkGray,
      ),
    ),
    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
    Text(code,style: CustomTextStyle.grayColorTextStyle,)
  ],);
}