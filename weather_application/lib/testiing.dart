import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

// ignore: prefer_const_constructors
void main() => runApp(Tests());

class Tests extends StatefulWidget {
  const Tests({Key? key}) : super(key: key);

  @override
  State<Tests> createState() => _WeatherState();
}

class _WeatherState extends State<Tests> {
  var lat = 0.0;
  var lng = 0.0;
  var accuracy = 0.0;
  var timestp;

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
        setState(() {
          lat = location.latitude;
          lng = location.longitude;
          accuracy = location.accuracy;
          timestp = location.timestamp;
        });
      }
    } else {
      print("Error: GPS sensor permission issue, device level");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('weather app'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    findMyLocation();
                    print(lng);
                    print(lat);
                  },
                  child: const Text("Get localitation")),
              const SizedBox(
                height: 44.0,
              ),
              Container(
                color: Colors.blue,
                height: 100,
                width: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28.0, 0, 0, 8.0),
                      child: Text("$timestp"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("accuracy $accuracy"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("longitud $lng"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("latitud $lat"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
