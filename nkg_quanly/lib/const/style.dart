import 'package:flutter/material.dart';

import '../const.dart';

final buttonFilterBlue = ButtonStyle(
    backgroundColor:
    MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return kBlueButton;
        } else {
          return kBlueButton;
        } // Use the component's default.
      },
    ),
    shape:
    MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )));
final buttonFilterWhite =ElevatedButton.styleFrom(
  primary: kWhite, //change background color of button
  onPrimary: kBlueButton, //change text color of button
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
      side: const BorderSide(color: kVioletButton)),
);