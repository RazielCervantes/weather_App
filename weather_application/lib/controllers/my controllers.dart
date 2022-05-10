import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_application/weather_information.dart';
import 'package:http/http.dart' as http;

class myGlbControllers extends GetxController {
  RxDouble lng = 0.0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble locationaccuracy = 0.0.obs;
  RxString locationtimestp = "".obs;
  RxString currentTemp = "".obs;
  RxString currentFeelslike = "".obs;
  RxString currentDewPoint = "".obs;
  RxString currentWinddeg = "".obs;
  RxString currentPressure = "".obs;
  RxString currentWeathericon = "".obs;
  RxString currentDescription = "".obs;
  RxString currentWindSpeed = "".obs;
  RxString currentHumidity = "".obs;
  RxString cityName = "".obs;
  RxString contryName = "".obs;
  RxString stateName = "".obs;
  RxString city = "".obs;

  findMyLocation() async {
    bool devicePermision;
    devicePermision = await Geolocator.isLocationServiceEnabled();
    if (devicePermision) {
      var appLevel = await Geolocator.checkPermission();
      if (appLevel == LocationPermission.denied) {
        appLevel = await Geolocator.requestPermission();
      } else if (appLevel == LocationPermission.deniedForever) {
        print("Error: App location permission denied forever");
      } else {
        var location = await Geolocator.getCurrentPosition();

        lat.value = location.latitude;
        lng.value = location.longitude;
        locationaccuracy.value = location.accuracy;
        locationtimestp.value = location.timestamp.toString();
        print(lat);
        print(lng);
      }
    } else {
      print("Error: GPS sensor permission issue, device level");
    }
  }

  Future<String> getMyCurrentWeatherInfo() async {
    var response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=daily&appid=8304aea1779e758d5a23406042e8a9c1&units=metric"),
      headers: {
        'Content-type': "application/json; charset=UTF-8",
        'Accept': 'application/json'
      },
    );

    var _weatherInfo = jsonDecode(response.body);
    // print(_weatherInfo["current"]["weather"][0]["description"]);
    currentDescription.value =
        _weatherInfo["current"]["weather"][0]["description"];
    currentTemp.value = _weatherInfo["current"]["temp"].toString();
    currentFeelslike.value = _weatherInfo["current"]["feels_like"].toString();
    currentDewPoint.value = _weatherInfo["current"]["dew_point"].toString();
    currentWinddeg.value = _weatherInfo["current"]["wind_deg"].toString();
    currentWindSpeed.value = _weatherInfo["current"]["wind_speed"].toString();
    currentHumidity.value = _weatherInfo["current"]["humidity"].toString();
    currentPressure.value = _weatherInfo["current"]["pressure"].toString();
    currentWeathericon.value = _weatherInfo["current"]["weather"][0]["icon"];
    cityName.value = _weatherInfo["timezone"];

    // print(currentDescription);
    // print(currentWeathericon);
    // print(currentTemp);
    // print(currentDewPoint);
    // Get.off(Weather());

    return "success";
  }

  Future<String> findCityLocation() async {
    var response = await http.get(
      Uri.parse(
          "http://api.openweathermap.org/geo/1.0/direct?q=$city??,$stateName??,$contryName&limit=1&appid=8304aea1779e758d5a23406042e8a9c1"),
      headers: {
        'Content-type': "application/json; charset=UTF-8",
        'Accept': 'application/json'
      },
    );

    var location = jsonDecode(response.body);
    print(location);

    lat.value = location[0]["lat"];
    lng.value = location[0]["lon"];

    return "success";
  }

  Future<String> getCityCurrentWeatherInfo() async {
    var response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=daily&appid=8304aea1779e758d5a23406042e8a9c1&units=metric"),
      headers: {
        'Content-type': "application/json; charset=UTF-8",
        'Accept': 'application/json'
      },
    );

    var _weatherInfo = jsonDecode(response.body);
    // print(_weatherInfo["current"]["weather"][0]["description"]);
    currentDescription.value =
        _weatherInfo["current"]["weather"][0]["description"];
    currentTemp.value = _weatherInfo["current"]["temp"].toString();
    currentFeelslike.value = _weatherInfo["current"]["feels_like"].toString();
    currentDewPoint.value = _weatherInfo["current"]["dew_point"].toString();
    currentWinddeg.value = _weatherInfo["current"]["wind_deg"].toString();
    currentWindSpeed.value = _weatherInfo["current"]["wind_speed"].toString();
    currentHumidity.value = _weatherInfo["current"]["humidity"].toString();
    currentPressure.value = _weatherInfo["current"]["pressure"].toString();
    currentWeathericon.value = _weatherInfo["current"]["weather"][0]["icon"];

    // print(currentDescription);
    // print(currentWeathericon);
    // print(currentTemp);
    // print(currentDewPoint);
    // Get.off(Weather());

    return "success";
  }
}
