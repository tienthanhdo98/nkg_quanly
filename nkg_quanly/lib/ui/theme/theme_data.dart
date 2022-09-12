import 'package:flutter/material.dart';
import 'package:nkg_quanly/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences? pref;

  bool? _darkTheme;

  bool? get darkTheme => _darkTheme;

  ThemeProvider() {
    _darkTheme = true;
    _loadFromShareFrefs();
  }

  void toggleTheme(bool isOn) {
    _darkTheme = !_darkTheme!;
    _saveToShareFrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
  }

  _loadFromShareFrefs() async {
    await _initPrefs();
    _darkTheme = pref?.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToShareFrefs() async {
    await _initPrefs();
    pref?.setBool(key, _darkTheme!);
    notifyListeners();
  }
}

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: kWhite,
    colorScheme: const ColorScheme.light(),
    cardColor: kWhite,
    primaryColor: kWhite,
    splashColor: kWhite,
    dividerColor: kBackGround,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: kBlueButton,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
        headline1: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        headline2: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        headline3: TextStyle(
          color: Colors.black,
          fontSize: 15,
        )),
  );

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: kDBackGround,
      colorScheme: const ColorScheme.dark(),
      primaryColor: kDBackGround,
      cardColor: kDBackgroundItem,
      splashColor: kDTable,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(kBlueButton),
        trackColor: MaterialStateProperty.all(kLightBlueButton),
      ),
      dividerColor: kDLine,
      iconTheme: const IconThemeData(color: Colors.white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: kBlueLineChart2,
        unselectedItemColor: kWhite,
        showUnselectedLabels: true,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        headline2: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ));
}

final unActiveButtonStyle = ElevatedButton.styleFrom(
    primary: kWhite, //change background color of button
    onPrimary: Colors.black, //change text color of button
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: kGrayButton)));
final activeButtonStyle = ElevatedButton.styleFrom(
    primary: kVioletBg, //change background color of button
    onPrimary: kBlueButton, //change text color of button
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: kVioletButton)));
final bottomButtonStyle = ButtonStyle(
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
