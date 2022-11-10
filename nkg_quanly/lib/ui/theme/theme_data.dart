import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nkg_quanly/const/const.dart';
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
    pref ??= await SharedPreferences.getInstance();
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
      fontFamily: 'Roboto',
      colorScheme: const ColorScheme.light(),
      cardColor: kWhite,
      primaryColor: kBackGround,

      splashColor: kWhite,
      dividerColor: kBackGround,

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: kBlueButton,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: const TextTheme(
        //header screen like so tay, nhien vu
        headline1: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500),
        headline2: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500),
        headline3: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500),
        headline4: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400),
        headline5: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500),
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: kDBackGround,
      colorScheme: const ColorScheme.dark(),
      primaryColor: kDBackGround,
      cardColor: kDBackgroundItem,
      splashColor: kDTable,
      fontFamily: 'Roboto',
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
        //header screen like so tay, nhien vu
        headline1: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500),
        headline2: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500),
        headline3: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500),
        headline4: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400),
        headline5: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500),
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
      borderRadius: BorderRadius.circular(30.0),
    )));
final elevetedButtonBlue = ButtonStyle(
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
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: kVioletButton))));

final elevetedButtonWhite = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return kVioletBg;
        } else {
          return kWhite;
        } // Use the component's default.
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: kVioletButton))));
final decoTextField = InputDecoration(
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kDarkGray, width: 1),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    filled: true,
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kBlueButton, width: 1),
    ),
    hintStyle: const TextStyle(color: Colors.black),
    fillColor: kWhite);

const blueTextStyle = TextStyle(
    color: kBlueButton,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto');
