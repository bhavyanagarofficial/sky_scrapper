class HomeModel {
  Location location;
  Current current;
  ForecastModel forecastModel;

  HomeModel(
      {required this.location,
      required this.current,
      required this.forecastModel});

  factory HomeModel.fromJson(Map json) => HomeModel(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
        forecastModel: ForecastModel.fromJson(json['forecast']),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
      };
}

class Current {
  dynamic lastUpdatedEpoch;
  String lastUpdated;
  double tempC;
  double tempF;
  dynamic isDay;
  Condition condition;
  double windMph;
  double windKph;
  dynamic windDegree;
  String windDir;
  dynamic pressureMb;
  double pressureIn;
  double precipMm;
  double precipIn;
  dynamic humidity;
  dynamic cloud;
  double feelslikeC;
  double feelslikeF;
  double windchillC;
  double windchillF;
  double heatindexC;
  double heatindexF;
  double dewpointC;
  double dewpointF;
  dynamic visKm;
  dynamic visMiles;
  dynamic uv;
  double gustMph;
  dynamic gustKph;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory Current.fromJson(Map json) => Current(
        lastUpdatedEpoch: json["last_updated_epoch"],
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"]?.toDouble(),
        tempF: json["temp_f"]?.toDouble(),
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"]?.toDouble(),
        windKph: json["wind_kph"]?.toDouble(),
        windDegree: json["wind_degree"],
        windDir: json["wind_dir"],
        pressureMb: json["pressure_mb"],
        pressureIn: json["pressure_in"]?.toDouble(),
        precipMm: json["precip_mm"]?.toDouble(),
        precipIn: json["precip_in"]?.toDouble(),
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"]?.toDouble(),
        feelslikeF: json["feelslike_f"]?.toDouble(),
        windchillC: json["windchill_c"]?.toDouble(),
        windchillF: json["windchill_f"]?.toDouble(),
        heatindexC: json["heatindex_c"]?.toDouble(),
        heatindexF: json["heatindex_f"]?.toDouble(),
        dewpointC: json["dewpoint_c"]?.toDouble(),
        dewpointF: json["dewpoint_f"]?.toDouble(),
        visKm: json["vis_km"],
        visMiles: json["vis_miles"],
        uv: json["uv"],
        gustMph: json["gust_mph"]?.toDouble(),
        gustKph: json["gust_kph"],
      );

  Map<String, dynamic> toJson() => {
        "last_updated_epoch": lastUpdatedEpoch,
        "last_updated": lastUpdated,
        "temp_c": tempC,
        "temp_f": tempF,
        "is_day": isDay,
        "condition": condition.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "wind_degree": windDegree,
        "wind_dir": windDir,
        "pressure_mb": pressureMb,
        "pressure_in": pressureIn,
        "precip_mm": precipMm,
        "precip_in": precipIn,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "feelslike_f": feelslikeF,
        "windchill_c": windchillC,
        "windchill_f": windchillF,
        "heatindex_c": heatindexC,
        "heatindex_f": heatindexF,
        "dewpoint_c": dewpointC,
        "dewpoint_f": dewpointF,
        "vis_km": visKm,
        "vis_miles": visMiles,
        "uv": uv,
        "gust_mph": gustMph,
        "gust_kph": gustKph,
      };
}

class Condition {
  String text;
  String icon;
  dynamic code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}

class Location {
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  dynamic localtimeEpoch;
  String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        tzId: json["tz_id"],
        localtimeEpoch: json["localtime_epoch"],
        localtime: json["localtime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
        "localtime_epoch": localtimeEpoch,
        "localtime": localtime,
      };
}

class ForecastModel {
  late List<ForecastDay> forecastDay = [];

  ForecastModel(this.forecastDay);

  factory ForecastModel.fromJson(Map m1) {
    return ForecastModel((m1['forecastday'] as List)
            .map(
              (e) => ForecastDay.fromJson(e),
            )
            .toList() ??
        []);
  }
}

class ForecastDay {
  late String date;
  late DayModal day;
  late List<HourModal> hour = [];
  late AstroModal astro;

  ForecastDay(this.date, this.day, this.hour,this.astro);

  factory ForecastDay.fromJson(Map m1) {
    return ForecastDay(
        m1['date'],
        DayModal.fromJson(m1['day']),
        (m1['hour'] as List).map((e) => HourModal.fromJson(e),).toList(),
        AstroModal.fromJson(m1['astro'])
    );
  }
}

class AstroModal{
  late String sunrise,sunset,moonrise,moonset,moon_phase;

  AstroModal(
      this.sunrise, this.sunset, this.moonrise, this.moonset, this.moon_phase);

  factory AstroModal.fromJson(Map m1){
      return AstroModal(m1['sunrise'], m1['sunset'], m1['moonrise'], m1['moonset'], m1['moon_phase']);
  }
}

class DayModal {
  late double maxtemp_c, mintemp_c;
  late DayConditionModal dayConditionModal;

  DayModal(this.maxtemp_c, this.mintemp_c, this.dayConditionModal);

  factory DayModal.fromJson(Map m1) {
    return DayModal(m1['maxtemp_c'].toDouble(), m1['mintemp_c'].toDouble(),
        DayConditionModal.fromJson(m1['condition']));
  }
}

class DayConditionModal {
  late String text, icon;

  DayConditionModal(this.text, this.icon);

  factory DayConditionModal.fromJson(Map m1) {
    return DayConditionModal(m1['text'], m1['icon']);
  }
}

class HourModal {
  late String time;
  late double temp_c, feelslike_c, wind_kph, dewpoint_c, precip_mm;
  late int is_day, chance_of_rain;
  late dynamic vis_miles, humidity;
  late HourConditionModal hourConditionModal;

  HourModal(
      this.time,
      this.temp_c,
      this.is_day,
      this.hourConditionModal,
      this.chance_of_rain,
      this.feelslike_c,
      this.wind_kph,
      this.vis_miles,
      this.dewpoint_c,
      this.humidity,
      this.precip_mm);

  factory HourModal.fromJson(Map m1) {
    return HourModal(
        m1['time'],
        m1['temp_c'].toDouble(),
        m1['is_day'],
        HourConditionModal.fromJson(m1['condition']),
        m1['chance_of_rain'],
        m1['feelslike_c'],
        m1['wind_kph'],
        m1['vis_miles'],
        m1['dewpoint_c'],
        m1['humidity'],
        m1['precip_mm']);
  }
}

class HourConditionModal {
  late String text, icon;

  HourConditionModal(this.text, this.icon);

  factory HourConditionModal.fromJson(Map m1) {
    return HourConditionModal(m1['text'], m1['icon']);
  }
}
