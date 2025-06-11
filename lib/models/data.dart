import 'package:the_weather_app/models/sys.dart';
import 'package:the_weather_app/models/weather.dart';
import 'package:the_weather_app/models/wind.dart';

import 'cloud.dart';
import 'coord.dart';
import 'main.dart';

class Data {
  Coord coord;
  Weather weather;
  String base;
  Mymain myMain;
  int visibility;
  Wind wind;
  Clouds cloud;
  dynamic dt;
  MySys mySys;
  int timezone;
  dynamic id;
  String name;
  dynamic cod;


  Data({
    required this.coord,
    required this.weather,
    required this.base,
    required this.myMain,
    required this.visibility,
    required this.wind,
    required this.cloud,
    required this.dt,
    required this.mySys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      coord: Coord.fromJson(json["coord"]),
      weather: Weather.fromJson(json["weather"][0]),
      base: json["base"],
      myMain: Mymain.fromJson(json["main"]),
      visibility: json["visibility"],
      wind: Wind.fromJson(json["wind"]),
      cloud: Clouds.fromJson(json["clouds"]),
      dt: json["dt"],
      mySys: MySys.fromJon(json["sys"]),
      timezone: json["timezone"],
      id: json["id"],
      name: json["name"],
      cod: json["cod"]
    );
  }


}