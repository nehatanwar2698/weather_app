import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/model/weather_model/weather_model.dart';
import 'package:weather_app/data/repository/weather_repository/weather_repository.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/utilities/execeptions.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/// weather bloc
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = WeatherRepository();

  ///constructor
  WeatherBloc() : super(NotSearchYet()) {
    on<GetWeather>(_handleGetWeather);
    on<AlterTempUnit>(_handleAlterTempUnit);
    add(GetWeather(city: 'meerut'));
  }

  FutureOr<void> _handleGetWeather(
    GetWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      if (event.city.isEmpty) {
        emit(Error(message: 'Please Enter City name'));
      } else if (event.city.length < 2) {
        emit(Error(message: 'Please Enter valid city name'));
      } else {
        final weatherModel = await weatherRepository.getWeatherData(event.city);
        emit(WeatherData(weatherModel: weatherModel, isTempUnitInC: true));
      }
    } catch (e) {
      log.info('e type is ${e.runtimeType}'
          ' and message : ${(e as CustomException).message}');
      emit(Error(message: e.message));
    }
  }

  FutureOr<void> _handleAlterTempUnit(
    AlterTempUnit event,
    Emitter<WeatherState> emit,
  ) {
    emit(
      WeatherData(
        weatherModel: (state as WeatherData).weatherModel,
        isTempUnitInC: !(state as WeatherData).isTempUnitInC,
      ),
    );
  }
}
