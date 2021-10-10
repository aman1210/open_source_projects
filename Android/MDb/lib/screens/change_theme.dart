import 'package:MDb/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatefulWidget {
  static const routerName = '/change-theme';

  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  Color pickerColor = Colors.purple;
  Color accentColor = Colors.amber;

  Color currentColor = Color(0xff443a49);

  void changeColor(Color color, bool isPrimary) {
    if (isPrimary) {
      setState(() => pickerColor = color);
    } else {
      setState(() => accentColor = color);
    }
  }

  void showColorPicker(BuildContext context, bool isPrimary) {
    showDialog(
      builder: (context) => AlertDialog(
        title: Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: isPrimary ? pickerColor : accentColor,
            onColorChanged: (color) {
              return changeColor(color, isPrimary);
            },
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              if (isPrimary) {
                Provider.of<ThemeChange>(context, listen: false)
                    .changePrimary(pickerColor);
              } else {
                Provider.of<ThemeChange>(context, listen: false)
                    .changeAccent(accentColor);
              }
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.check),
            label: Text('Change'),
          )
        ],
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Theme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                showColorPicker(context, true);
              },
              child: Text('Change primary color'),
            ),
            RaisedButton(
              onPressed: () {
                Provider.of<ThemeChange>(context, listen: false)
                    .changeBrightness();
              },
              child: Text('Switch mode'),
            ),
          ],
        ),
      ),
    );
  }
}
