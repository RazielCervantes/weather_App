import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/change_city.dart';
import 'package:weather_application/controllers/my%20controllers.dart';
import 'package:weather_application/util/constants.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final MyGlbControllers _myGlbControllers = Get.put(MyGlbControllers());

  late String iconWeather = _myGlbControllers.currentWeathericon.value;

  late double lat = _myGlbControllers.lat.toDouble();
  late double long = _myGlbControllers.lng.toDouble();
  var forescast;

  Future<String> getForecastWeatherInfo() async {
    var resp = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,hourly&appid=1de958f41a0208f53bfcd444733d34c3&units=metric"),
      headers: {
        'Content-type': "application/json; charset=UTF-8",
        'Accept': 'application/json'
      },
    );

    setState(() {
      forescast = jsonDecode(resp.body);
    });

    return "success";
  }

  @override
  void initState() {
    getForecastWeatherInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[400],
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.place,
                          color: Colors.white,
                        ),
                        Obx((() => Container(
                              // color: Colors.amber,
                              height: 60,
                              width: 220,
                              child: Center(
                                child: Text(
                                  _myGlbControllers.cityName.value,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            )))
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(City());
                      },
                      icon: const Icon(Icons.location_city),
                      iconSize: 24.0,
                      color: Colors.white,
                      tooltip: "change city",
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 140,
                          width: 140,
                          child: Image.network(
                            Constans().weathericon + iconWeather + "@2x.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Obx((() => Text(
                              _myGlbControllers.currentDescription.value,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ))),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Obx(
                              () => Text(
                                _myGlbControllers.currentTemp.value + '°',
                                style: const TextStyle(
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
                                    const Icon(Icons.air),
                                    Obx((() => Text(_myGlbControllers
                                            .currentWindSpeed.value +
                                        " m/s")))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.water_drop_outlined),
                                    Obx((() => Text(_myGlbControllers
                                            .currentHumidity.value +
                                        " g.m-3")))
                                  ],
                                ),
                              ]),
                        ),
                        const SizedBox(
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
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 300,
                  width: 360,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.5,
                      crossAxisCount: 1,
                    ),
                    itemCount:
                        forescast == null ? 0 : forescast["daily"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              buildforecastWeather(forescast["daily"][index]));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildforecastWeather(Map forescast) {
    late var date = DateTime.fromMillisecondsSinceEpoch(forescast["dt"] * 1000);

    return Container(
      child: Card(
        color: Colors.white.withOpacity(0.5),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    DateFormat("EEEE").format(date),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Image.network(
              forescast["weather"][0] == null
                  ? Constans().weathericon + "03d" + "@2x.png"
                  : Constans().weathericon +
                      forescast["weather"][0]["icon"] +
                      "@2x.png",
            ),
            ListTile(
              title: Text("MAX: " + forescast["temp"]["max"].toString() + "°"),
              leading: Icon(Icons.thermostat),
              minLeadingWidth: 24,
            ),
            ListTile(
              title: Text("MIN: " + forescast["temp"]["min"].toString() + "°"),
              leading: Icon(Icons.thermostat),
              minLeadingWidth: 24,
            ),
          ],
        ),
      ),
    );
  }
}
