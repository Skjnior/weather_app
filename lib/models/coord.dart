class Coord {
  dynamic lon;
  dynamic lat;

  Coord({
    required this.lon,
    required this.lat
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json["lon"],
      lat: json["lat"]
    );
  }
}