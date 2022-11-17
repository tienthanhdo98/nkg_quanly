import 'package:flutter/material.dart';

import 'const.dart';

final buttonFilterBlue = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return kBlueButton;
        } else {
          return kBlueButton;
        } // Use the component's default.
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    )));
final buttonFilterWhite = ElevatedButton.styleFrom(
  primary: kWhite, //change background color of button
  onPrimary: kBlueButton, //change text color of button
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
      side: const BorderSide(color: kVioletButton)),
);
const textBlueCountTotalStyle = TextStyle(
    color: kBlueButton,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: "Roboto");
const textBlackCountEofficeStyle =
    TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Roboto', fontSize: 24);

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
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static const robotow400s14TextStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static const roboto400s16TextStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static const roboto700TextStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static const robotow700s24TextStyle = TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static const robotow700s12TextStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);

}

final kUnActiveButtonStyle =
ElevatedButton.styleFrom(primary: kWhite, onPrimary: Colors.black);
final kActiveButtonStyle = ElevatedButton.styleFrom(primary: kBlueButton);
