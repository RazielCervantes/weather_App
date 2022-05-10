import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_application/change_city.dart';
import 'package:weather_application/controllers/my%20controllers.dart';
import 'package:weather_application/testiing.dart';
import 'package:weather_application/util/constants.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final myGlbControllers _myGlbControllers = Get.put(myGlbControllers());

  late String iconWeather = _myGlbControllers.currentWeathericon.value;

  var apikey = "1de958f41a0208f53bfcd444733d34c3";
  var days = "10";

  @override
  void initState() {
    // findMyLocation();
    // getCurrentWeatherInfo();
    // getforecastWeatherInfo();
    // _myGlbControllers.findMyLocation();
    //iconWeather = _weatherInfo["current"]["weather"][0]["icon"].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[400],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
          child: Column(
            children: [
              Container(
                  // color: Colors.amber,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: Colors.white,
                      ),
                      Obx((() => Text(
                            _myGlbControllers.cityName.value,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )))
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(City());
                    },
                    icon: Icon(Icons.location_city),
                    iconSize: 24.0,
                    color: Colors.white,
                    tooltip: "change city",
                  )
                ],
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 140,
                        width: 140,
                        child: Image.network(
                          constans().weathericon + iconWeather + "@2x.png",
                          // "https://cdn.weatherapi.com/weather/64x64/day/116.png",

                          // constans().weathericon +
                          //     _weatherInfo["current"]["weather"][0]["icon"]
                          //         .toString() +
                          //     "@2x.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Obx((() => Text(
                            _myGlbControllers.currentDescription.value,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ))),
                      Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Obx(
                            () => Text(
                              _myGlbControllers.currentTemp.value + '°',
                              style: TextStyle(
                                  fontSize: 44, fontWeight: FontWeight.w800),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.air),
                                  Obx((() => Text(
                                      _myGlbControllers.currentWindSpeed.value +
                                          " m/s")))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.water_drop_outlined),
                                  Obx((() => Text(
                                      _myGlbControllers.currentHumidity.value +
                                          " g.m-3")))
                                ],
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx((() => Text("feels like: " +
                              _myGlbControllers.currentFeelslike.value +
                              "°")))),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx((() => Text("Pressure: " +
                              _myGlbControllers.currentPressure.value +
                              " Pa")))),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx((() => Text("Dew point: " +
                              _myGlbControllers.currentDewPoint.value +
                              "°")))),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx((() => Text("Wind gust: " +
                              _myGlbControllers.currentWinddeg.value +
                              " m sec")))),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  )
                ],
              ),
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5,
                    crossAxisCount: 1,
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildforecastWeather());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildforecastWeather() {
    return Container(
      child: Card(
        color: Colors.white.withOpacity(0.5),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "date",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Image.network(
              constans().weathericon + iconWeather + "@2x.png",
            ),
            ListTile(
              title: Text("MAX:    33°"),
              leading: Icon(Icons.thermostat),
              minLeadingWidth: 24,
            ),
            ListTile(
              title: Text("MIN:    33°"),
              leading: Icon(Icons.thermostat),
              minLeadingWidth: 24,
            ),
          ],
        ),
      ),
    );
  }
}
