import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChange extends ChangeNotifier {
  Color _primary = Colors.purple;
  Color _accent = Colors.amber;
  bool _brightness = false;

  Color get primary {
    return _primary;
  }

  Color get accent {
    return _accent;
  }

  bool get brightness {
    return _brightness;
  }

  void changePrimary(Color primary) {
    Color c = Color(primary.value);
    Map<int, Color> color = {
      50: Color.fromRGBO(c.red, c.green, c.blue, .1),
      100: Color.fromRGBO(c.red, c.green, c.blue, .2),
      200: Color.fromRGBO(c.red, c.green, c.blue, .3),
      300: Color.fromRGBO(c.red, c.green, c.blue, .4),
      400: Color.fromRGBO(c.red, c.green, c.blue, .5),
      500: Color.fromRGBO(c.red, c.green, c.blue, .6),
      600: Color.fromRGBO(c.red, c.green, c.blue, .7),
      700: Color.fromRGBO(c.red, c.green, c.blue, .8),
      800: Color.fromRGBO(c.red, c.green, c.blue, .9),
      900: Color.fromRGBO(c.red, c.green, c.blue, 1),
    };
    _primary = MaterialColor(c.value, color);
    notifyListeners();
    saveChanges();
  }

  void changeAccent(Color accent) {
    _accent = accent;
    notifyListeners();
    // saveChanges();
  }

  void changeBrightness() {
    _brightness = !_brightness;
    print(brightness);
    notifyListeners();
    saveChanges();
  }

  Future<void> autoSetTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('primary')) {
      return;
    }

    Color c = Color(prefs.getInt('primary') ?? Colors.purple.value);
    Map<int, Color> color = {
      50: Color.fromRGBO(c.red, c.green, c.blue, .1),
      100: Color.fromRGBO(c.red, c.green, c.blue, .2),
      200: Color.fromRGBO(c.red, c.green, c.blue, .3),
      300: Color.fromRGBO(c.red, c.green, c.blue, .4),
      400: Color.fromRGBO(c.red, c.green, c.blue, .5),
      500: Color.fromRGBO(c.red, c.green, c.blue, .6),
      600: Color.fromRGBO(c.red, c.green, c.blue, .7),
      700: Color.fromRGBO(c.red, c.green, c.blue, .8),
      800: Color.fromRGBO(c.red, c.green, c.blue, .9),
      900: Color.fromRGBO(c.red, c.green, c.blue, 1),
    };
    _primary = MaterialColor(c.value, color);
    _brightness = prefs.getBool('brightness') ?? false;
    notifyListeners();
    return;
  }

  Future<void> saveChanges() async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt('primary', _primary.value);
    pref.setBool('brightness', _brightness);
  }
}
