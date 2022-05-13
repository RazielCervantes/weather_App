import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_application/weather_information.dart';
import 'package:weather_application/controllers/my%20controllers.dart';

class City extends StatefulWidget {
  const City({
    Key? key,
  }) : super(key: key);

  @override
  State<City> createState() => _CitySelectionState();
}

class _CitySelectionState extends State<City> {
  final MyGlbControllers _myGlbControllers = Get.put(MyGlbControllers());
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  var code = "";

  @override
  Widget build(BuildContext context) {
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    return GestureDetector(
      onTap: () {},
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue[400],
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 28),
                    height: 320,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Select a city",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w800),
                          ),
                        ),

                        ///Adding CSC Picker Widget in app

                        CSCPicker(
                          ///Enable disable state dropdown [OPTIONAL PARAMETER]
                          showStates: true,

                          /// Enable disable city drop down [OPTIONAL PARAMETER]
                          showCities: true,

                          ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                          flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                          ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.blueGrey[300],
                              border: Border.all(
                                  color: Colors.blueGrey.shade300, width: 1)),

                          // ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                          // disabledDropdownDecoration: BoxDecoration(
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //     color: Colors.grey.shade300,
                          //     border: Border.all(
                          //         color: Colors.grey.shade300, width: 1)),

                          ///placeholders for dropdown search field
                          countrySearchPlaceholder: "Country",
                          stateSearchPlaceholder: "State",
                          citySearchPlaceholder: "City",

                          ///labels for dropdown
                          countryDropdownLabel: "*Country",
                          stateDropdownLabel: "*State",
                          cityDropdownLabel: "*City",

                          ///Default Country
                          // defaultCountry: DefaultCountry.Mexico,

                          ///Disable country dropdown (Note: use it with default country)
                          // disableCountry: true,

                          ///selected item style [OPTIONAL PARAMETER]
                          selectedItemStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),

                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                          dropdownHeadingStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),

                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          dropdownItemStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),

                          ///Dialog box radius [OPTIONAL PARAMETER]
                          dropdownDialogRadius: 10.0,

                          ///Search bar radius [OPTIONAL PARAMETER]
                          // searchBarRadius: 10.0,

                          ///triggers once country selected in dropdown
                          onCountryChanged: (value) {
                            setState(() {
                              ///store value in country variable
                              countryValue = value;
                            });
                          },

                          ///triggers once state selected in dropdown
                          onStateChanged: (value) {
                            setState(() {
                              ///store value in state variable
                              stateValue = value.toString();
                            });
                          },

                          ///triggers once city selected in dropdown
                          onCityChanged: (value) {
                            setState(() {
                              ///store value in city variable
                              cityValue = value.toString();
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: SizedBox(
                            height: 50,
                            width: 280,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (cityValue == null) {
                                  address = "$stateValue , $countryValue ";
                                } else if (stateValue == " ") {
                                  address = "$countryValue";
                                } else {
                                  address =
                                      "$cityValue, $stateValue, $countryValue";
                                }

                                _myGlbControllers.cityName.value =
                                    address.toString();

                                _myGlbControllers.city.value =
                                    cityValue.toString();
                                _myGlbControllers.stateName.value =
                                    stateValue.toString();
                                _myGlbControllers.contryName.value =
                                    countryValue.toString();

                                await _myGlbControllers.findMyLocation();
                                await _myGlbControllers
                                    .getCityCurrentWeatherInfo();
                                Get.offAll(const Weather());
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white.withOpacity(0.7)),
                              child: const Text(
                                "Show Weather",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Or",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                ),
                GestureDetector(
                  onTap: (() async {
                    await _myGlbControllers.findMyLocation();
                    await _myGlbControllers.getMyCurrentWeatherInfo();
                    Get.off(const Weather());
                  }),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.location_on,
                        size: 120,
                        color: Colors.white,
                      ),
                      Text(
                        "get weather of my location",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
