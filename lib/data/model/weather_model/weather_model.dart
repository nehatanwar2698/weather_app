// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

// ignore_for_file: public_member_api_docs

import 'dart:convert';

/// function for convert json to instatnce of Weather class
WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str) as Map<String, dynamic>);

/// fucntion for convert instance of Weather class to json
String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

/// class for store data of weather
class WeatherModel {
  ///constructor
  WeatherModel({
    this.location,
    this.current,
  });

  /// factory constructor which initialize instance feild from map
  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        current: json['current'] == null
            ? null
            : Current.fromJson(json['current'] as Map<String, dynamic>),
      );

  /// location
  Location? location;

  /// current
  Current? current;

  /// to json method
  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'current': current?.toJson(),
      };
}

/// current class
class Current {
  /// constructor
  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });
  factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdatedEpoch: json['last_updated_epoch'] as num?,
        lastUpdated: json['last_updated'] as String?,
        tempC: json['temp_c'] as num?,
        tempF: json['temp_f'] as num?,
        isDay: json['is_day'] as num?,
        condition: json['condition'] == null
            ? null
            : Condition.fromJson(json['condition'] as Map<String, dynamic>),
        windMph: json['wind_mph'] as double?,
        windKph: json['wind_kph'] as double?,
        windDegree: json['wind_degree'] as num?,
        windDir: json['wind_dir'] as String?,
        pressureMb: json['pressure_mb'] as num?,
        pressureIn: json['pressure_in'] as double?,
        precipMm: json['precip_mm'] as num?,
        precipIn: json['precip_in'] as num?,
        humidity: json['humidity'] as num?,
        cloud: json['cloud'] as num?,
        feelslikeC: json['feelslike_c'] as double?,
        feelslikeF: json['feelslike_f'] as double?,
        visKm: json['vis_km'] as double?,
        visMiles: json['vis_miles'] as num?,
        uv: json['uv'] as num?,
        gustMph: json['gust_mph'] as double?,
        gustKph: json['gust_kph'] as double?,
      );

  num? lastUpdatedEpoch;
  String? lastUpdated;
  num? tempC;
  num? tempF;
  num? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  num? windDegree;
  String? windDir;
  num? pressureMb;
  double? pressureIn;
  num? precipMm;
  num? precipIn;
  num? humidity;
  num? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? visKm;
  num? visMiles;
  num? uv;
  double? gustMph;
  double? gustKph;

  Map<String, dynamic> toJson() => {
        'last_updated_epoch': lastUpdatedEpoch,
        'last_updated': lastUpdated,
        'temp_c': tempC,
        'temp_f': tempF,
        'is_day': isDay,
        'condition': condition?.toJson(),
        'wind_mph': windMph,
        'wind_kph': windKph,
        'wind_degree': windDegree,
        'wind_dir': windDir,
        'pressure_mb': pressureMb,
        'pressure_in': pressureIn,
        'precip_mm': precipMm,
        'precip_in': precipIn,
        'humidity': humidity,
        'cloud': cloud,
        'feelslike_c': feelslikeC,
        'feelslike_f': feelslikeF,
        'vis_km': visKm,
        'vis_miles': visMiles,
        'uv': uv,
        'gust_mph': gustMph,
        'gust_kph': gustKph,
      };
}

class Condition {
  Condition({
    this.text,
    this.icon,
    this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json['text'] as String?,
        icon: json['icon'] as String?,
        code: json['code'] as num?,
      );

  String? text;
  String? icon;
  num? code;

  Map<String, dynamic> toJson() => {
        'text': text,
        'icon': icon,
        'code': code,
      };
}

class Location {
  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'] as String?,
        region: json['region'] as String?,
        country: json['country'] as String?,
        lat: json['lat'] as double?,
        lon: json['lon'] as double?,
        tzId: json['tz_id'] as String?,
        localtimeEpoch: json['localtime_epoch'] as num?,
        localtime: json['localtime'] as String?,
      );
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  num? localtimeEpoch;
  String? localtime;

  Map<String, dynamic> toJson() => {
        'name': name,
        'region': region,
        'country': country,
        'lat': lat,
        'lon': lon,
        'tz_id': tzId,
        'localtime_epoch': localtimeEpoch,
        'localtime': localtime,
      };
}
