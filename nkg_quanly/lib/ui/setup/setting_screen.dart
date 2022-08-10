import 'package:flutter/material.dart';

import '../../const.dart';

class SettingScreen extends StatelessWidget{
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      SafeArea(child: Column(children: [
        Container(
          width: double.infinity,
          height: 80,
          color: kWhite,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/logo.png",
                width: 200,
                height: 150,
              ),
            ),
          ),
        ),

      ],),),);
  }

}