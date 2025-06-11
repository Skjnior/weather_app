import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/data.dart';


class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  late final String myKey;
  // late final String countryName;
  WeatherService(this.myKey);

  Future<Data> getData(String countryName) async {
    final response = await http.get(Uri.parse("$BASE_URL?q=$countryName&appid=$myKey&units=metric"));

    if(response.statusCode == 200) {
      print(response.body);
      return Data.fromJson(jsonDecode(response.body));
        // Weather.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception('Failed to load weather data');
    }
  }



}