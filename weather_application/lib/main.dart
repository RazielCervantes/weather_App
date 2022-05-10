import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_application/weather_information.dart';
import 'package:weather_application/change_city.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Material APP",
      debugShowCheckedModeBanner: false,
      home: (SafeArea(child: City())),
    );
  }
}
