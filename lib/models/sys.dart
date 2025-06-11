class MySys {
  String country;
  int sunrise;
  int sunset;


  MySys({
    required this.country,
    required this.sunrise,
    required this.sunset
  });

  factory MySys.fromJon(Map<String, dynamic> json) {
    return MySys(
      country: json["country"],
      sunrise: json["sunrise"],
      sunset: json["sunset"]
    );
  }
}