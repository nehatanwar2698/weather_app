part of 'weather_bloc.dart';

/// weather bloc state
@immutable
sealed class WeatherState {}

/// weather loading state class
final class WeatherLoading extends WeatherState {}

/// weather fetched data class
final class WeatherData extends WeatherState {
  /// constructor
  WeatherData({required this.weatherModel, required this.isTempUnitInC});

  /// temp unit
  final bool isTempUnitInC;

  /// hold weather data
  final WeatherModel weatherModel;
}

/// weather fetched data class
final class NotSearchYet extends WeatherState {}

/// error state
final class Error extends WeatherState {
  /// constructor
  Error({required this.message});

  /// hold error message
  final String message;
}
