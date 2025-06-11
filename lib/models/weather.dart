class Weather {
  dynamic id;
  String main;
  String description;
  String icon;



  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
      return Weather(
          id: json["id"],
          main: json["main"],
          description: json["description"],
          icon: json["icon"]
      );
    }



  // Weather({required this.cityName, required this.temperature, required this.condition,});
  //
  // factory Weather.fromJson(Map<String, dynamic> json) {
  //   return Weather(
  //       cityName: json["name"],
  //       temperature: json["main"]["temp"].toDouble(),
  //       condition: json["weather"][0]["main"]
  //   );
  // }
}