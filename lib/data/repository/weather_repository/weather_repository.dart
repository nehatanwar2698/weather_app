import 'package:weather_app/data/data_provider/data_provider.dart';
import 'package:weather_app/data/model/weather_model/weather_model.dart';
import 'package:weather_app/utilities/enums.dart';

///weather repository
class WeatherRepository {
  /// method for get Weather data
  Future<WeatherModel> getWeatherData(String location) async {
    final rawWeather = await DataProvider.genericApiCall(
      requestType: ApiRequestType.get,
      apiLink: 'https://weatherapi-com.p.rapidapi.com/current.json?q=$location',
      
    );

    final weatherModel = weatherModelFromJson(rawWeather);
    return weatherModel;
  }
}
