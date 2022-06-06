// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class Climas {
  Climas({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  String cod;
  int message;
  int cnt;
  List<ListElement> list;
  City city;

  factory Climas.fromJson(String str) => Climas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Climas.fromMap(Map<String, dynamic> json) => Climas(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromMap(x))),
    city: City.fromMap(json["city"]),
  );

  Map<String, dynamic> toMap() => {
    "cod": cod,
    "message": message,
    "cnt": cnt,
    "list": List<dynamic>.from(list.map((x) => x.toMap())),
    "city": city.toMap(),
  };
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    coord: Coord.fromMap(json["coord"]),
    country: json["country"],
    population: json["population"],
    timezone: json["timezone"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "coord": coord.toMap(),
    "country": country,
    "population": population,
    "timezone": timezone,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  double lat;
  double lon;

  factory Coord.fromJson(String str) => Coord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "lat": lat,
    "lon": lon,
  };
}

class ListElement {
  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  int dt;
  MainClass main;
  List<Clima> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Sys sys;
  DateTime dtTxt;

  factory ListElement.fromJson(String str) => ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
    dt: json["dt"],
    main: MainClass.fromMap(json["main"]),
    weather: List<Clima>.from(json["weather"].map((x) => Clima.fromMap(x))),
    clouds: Clouds.fromMap(json["clouds"]),
    wind: Wind.fromMap(json["wind"]),
    visibility: json["visibility"],
    pop: json["pop"].toDouble(),
    sys: Sys.fromMap(json["sys"]),
    dtTxt: DateTime.parse(json["dt_txt"]),
  );

  Map<String, dynamic> toMap() => {
    "dt": dt,
    "main": main.toMap(),
    "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
    "clouds": clouds.toMap(),
    "wind": wind.toMap(),
    "visibility": visibility,
    "pop": pop,
    "sys": sys.toMap(),
    "dt_txt": dtTxt.toIso8601String(),
  };
}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(String str) => Clouds.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toMap() => {
    "all": all,
  };
}

class MainClass {
  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  factory MainClass.fromJson(String str) => MainClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MainClass.fromMap(Map<String, dynamic> json) => MainClass(
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    tempMin: json["temp_min"].toDouble(),
    tempMax: json["temp_max"].toDouble(),
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class Sys {
  Sys({
    required this.pod,
  });

  Pod? pod;

  factory Sys.fromJson(String str) => Sys.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
    pod: podValues.map[json["pod"]],
  );

  Map<String, dynamic> toMap() => {
    "pod": podValues.reverse[pod],
  };
}

enum Pod { N, D }

final podValues = EnumValues({
  "d": Pod.D,
  "n": Pod.N
});

class Clima {
  Clima({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  MainEnum? main;
  Description? description;
  String icon;

  factory Clima.fromJson(String str) => Clima.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Clima.fromMap(Map<String, dynamic> json) => Clima(
    id: json["id"],
    main: mainEnumValues.map[json["main"]],
    description: descriptionValues.map[json["description"]],
    icon: json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "main": mainEnumValues.reverse[main],
    "description": descriptionValues.reverse[description],
    "icon": icon,
  };
}

enum Description { FEW_CLOUDS, CLEAR_SKY, SCATTERED_CLOUDS, BROKEN_CLOUDS, OVERCAST_CLOUDS }

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "few clouds": Description.FEW_CLOUDS,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS
});

enum MainEnum { CLOUDS, CLEAR }

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS
});

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  double speed;
  int deg;
  double gust;

  factory Wind.fromJson(String str) => Wind.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
    speed: json["speed"].toDouble(),
    deg: json["deg"],
    gust: json["gust"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
