import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_application/change_city.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Material APP",
      debugShowCheckedModeBanner: false,
      home: (SafeArea(child: City())),
    );
  }
}
