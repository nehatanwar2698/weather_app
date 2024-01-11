import 'package:dio/dio.dart';
import 'package:weather_app/utilities/constants.dart';

class WeatherInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log
      ..info('INTERCEPTOR : ONREQUEST')
      ..info('request URL : ${options.path}')
      ..info('request Body : ${options.data}')
      ..info('request headers : ${options.headers}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log
      ..info('INTERCEPTOR : ONRESPONSE')
      ..info('status code : ${response.statusCode}')
      ..info('response Body : ${response.data}')
      ..info('status code : ${response.statusCode}');

    super.onResponse(response, handler);
  }
}
