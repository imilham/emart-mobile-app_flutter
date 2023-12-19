import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // we are using getX so we have to change this material app in to get material app
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            // to set app bar icons colors in the entire application
            iconTheme: IconThemeData(color: darkFontGrey)),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
