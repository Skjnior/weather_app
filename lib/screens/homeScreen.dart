import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/data.dart';
import '../services/weater_service.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  final _weatherService = WeatherService('f0bf1653af1d2f75a46bae21d203f729');
  Data? _data;

  late AnimationController _controller;
  late Animation<double> _animation;

  fetchWeather() async {
    try {
      final data = await _weatherService.getData(dropdownValue);
      setState(() {
        _data = data;
      });
    } catch (e) {
      print(e);
    }
  }

  String formatTimestamp(int timestamp) {
    final DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    return DateFormat.Hm().format(date);
  }

  IconData getWeatherIcon(String description) {
    if (description.contains("clear")) {
      return Icons.wb_sunny;
    } else if (description.contains("cloud")) {
      return Icons.cloud;
    } else if (description.contains("rain")) {
      return Icons.beach_access;
    } else if (description.contains("storm")) {
      return Icons.flash_on;
    } else {
      return Icons.wb_cloudy;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    _controller.repeat(reverse: true);
  }

  static const List<String> list = <String>['Guinea', 'Senegal', 'Bamako',];

  String dropdownValue = list.first;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        height: MediaQuery.of(context).size.height,
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              const SizedBox(height: 60,),
              const Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                          "Clique sur la petite fleche a droite",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "pour choisir le pays",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(2, 2)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.deepPurple),
                              iconSize: 25,
                              elevation: 15,
                              style: const TextStyle(
                                  color: Colors.deepPurple, fontSize: 16
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                                fetchWeather();
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: const TextStyle(
                                          fontSize: 16
                                      ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Météo - ${_data?.name ?? ""}",
                  style: const TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FadeTransition(
                opacity: _animation,
                child: Icon(
                    getWeatherIcon(
                      _data?.weather.description ?? "chargement...",
                    ),
                    size: 110,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${_data?.myMain.temp ?? "chargement..."} °C",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Ressenti : ${_data?.myMain.feels_like ?? "chargement..."}°C",
                  style: const TextStyle(fontSize: 18, color: Colors.white70,fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.purple.withOpacity(0.3)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            getWeatherIcon(
                                _data?.weather.description ?? "chargement..."),
                            size: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _data?.weather.description ?? "chargement...",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Humidité : ${_data?.myMain.humidity ?? "chargement..."}%",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Pression : ${_data?.myMain.pressure ?? "chargement..."} hPa",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Vent : ${_data?.wind.speed ?? "chargement..."} m/s",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.wb_sunny,
                          color: Colors.orange, size: 45),
                      const Text(
                        "Lever du soleil",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        _data != null
                            ? formatTimestamp(_data!.mySys.sunrise)
                            : "chargement...",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.nights_stay,
                          color: Colors.blue, size: 45),
                      const Text(
                        "Coucher du soleil",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        _data != null
                            ? formatTimestamp(_data!.mySys.sunset)
                            : "chargement...",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
