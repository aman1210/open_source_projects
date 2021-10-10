import 'package:MDb/provider/search_provider.dart';
import 'package:MDb/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/detail_page_screen.dart';
import './screens/home_screen.dart';
import './screens/change_theme.dart';
import 'package:MDb/provider/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ThemeChange(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SearchProvider(),
        ),
      ],
      child: Consumer<ThemeChange>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: value.primary,
              accentColor: value.accent,
              brightness: value.brightness ? Brightness.dark : Brightness.light,
              fontFamily: 'Lato',
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: FutureBuilder(
              future: Provider.of<ThemeChange>(context, listen: false)
                  .autoSetTheme(),
              builder: (context, snapshot) => HomeScreen(),
            ),
            routes: {
              ChangeTheme.routerName: (ctx) => ChangeTheme(),
              SearchScreen.routeName: (ctx) => SearchScreen(),
              DetailPageScreen.routeName: (ctx) => DetailPageScreen(null),
            },
          );
        },
      ),
    );
  }
}
