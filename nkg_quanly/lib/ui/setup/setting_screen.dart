import 'package:flutter/material.dart';

import '../../const.dart';
import 'package:provider/provider.dart';

import '../theme/theme_data.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              color: Theme.of(context).cardColor,
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
            Row(
              children: [
                Text("Chế độ ban đêm"),
                SizedBox(
                  width: 100,
                  child: Consumer<ThemeProvider>(
                    builder: (context, ThemeProvider themdeProvider , child){
                      return SwitchListTile(value: themdeProvider.darkTheme!, onChanged: (value){
                        themdeProvider.toggleTheme(value);
                      });
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SettingItem {
  SettingItem({this.img = "", this.title = ""});

  String img;
  String title;
}
