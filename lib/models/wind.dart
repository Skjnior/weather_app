class Wind {
  dynamic speed;
  int deg;
  dynamic gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust
  });


  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json["speed"],
      deg: json["deg"],
      gust: json["gust"]
    );
  }
}