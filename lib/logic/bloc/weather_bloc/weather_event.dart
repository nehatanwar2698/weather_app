part of 'weather_bloc.dart';

/// weather event class
@immutable
sealed class WeatherEvent {}

/// get weather event class
final class GetWeather extends WeatherEvent {
  ///constructor
  GetWeather({required this.city});

  /// city feild for contain city data
  final String city;
}

/// alter temp celcius unit
final class AlterTempUnit extends WeatherEvent {}
