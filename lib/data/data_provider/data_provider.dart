import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:weather_app/data/data_provider/interceptor/weather_interceptor.dart';
import 'package:weather_app/utilities/api_urls.dart';
import 'package:weather_app/utilities/constants.dart';

import 'package:weather_app/utilities/enums.dart';
import 'package:weather_app/utilities/execeptions.dart';

/// data provider class
class DataProvider {
  /// dio instance
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      headers: {
        'X-RapidAPI-Key': '291c85b1fdmshfc905f70295c260p1b6a4cjsn1e2f118acadc',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com',
      },
    ),
  );

  /// Initialize the Dio instance with interceptors
  static void initializeDio() {
    dio.interceptors.add(
      WeatherInterceptor(),
    );
  }

  /// generic method for api call
  static Future<String> genericApiCall({
    required ApiRequestType requestType,
    required String apiLink,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      log.info('request start in data provider');
      final getRaw = requestType == ApiRequestType.get
          ? await dio
              .get<String>(
                apiLink,
                options: Options(headers: headers),
              )
              .timeout(Duration(seconds: 720))
          : requestType == ApiRequestType.post
              ? await dio
                  .post<String>(
                    apiLink,
                    options: Options(
                      headers: headers,
                    ),
                    data: body == null ? null : json.encode(body),
                  )
                  .timeout(Duration(seconds: 120))
              : await dio
                  .put<String>(
                    apiLink,
                    options: Options(headers: headers),
                    data: body == null ? null : json.encode(body),
                  )
                  .timeout(Duration(seconds: 120));
      log.info('request complete in data provider');
      if (getRaw.statusCode == 200 && getRaw.data != null) {
        log
          ..info('response : ${getRaw.data}')
          ..info('response type : ${getRaw.data.runtimeType}');
        return getRaw.data!;
      } else {
        throw CustomException(message: 'data not found');
      }
    } on SocketException {
      throw CustomException(message: 'no internet !');
    } on TimeoutException {
      throw CustomException(message: 'Request Timeout try again !');
    } on DioException catch (e) {
      log.info("exception -- ${e.toString()}");
      final exceptionMessage = switch (e.type) {
        DioExceptionType.badCertificate => 'Bad Certificate',
        DioExceptionType.badResponse => 'City Not Found',
        DioExceptionType.cancel => 'Request Cancel',
        DioExceptionType.connectionError => 'Connection Error',
        DioExceptionType.connectionTimeout => 'Connection Timeout',
        DioExceptionType.receiveTimeout => 'Response Timeout',
        DioExceptionType.sendTimeout => 'Request Timeout',
        _ => 'Some thing went wrong $e!',
      };
      throw CustomException(message: exceptionMessage);
    } catch (e) {
      if (e is CustomException) {
        rethrow;
      }
      throw CustomException(message: 'something went wrong $e');
    }
  }
}
