import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

class DioInstance {
  static final dio.Dio dioInstance = dio.Dio();

  static void configureDio() {
    if (kDebugMode) {
      print('Configurando DioInstance con interceptor');
    }

    dioInstance.options = dio.BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      validateStatus: (status) {
        // Consider all status codes as valid (this might not be ideal for production)
        return status != null && status >= 200 && status < 500;
      },
    );

    // Add an interceptor for logging and adding headers if necessary
    dioInstance.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (dio.RequestOptions options,
          dio.RequestInterceptorHandler handler) async {
        // Example of adding a token to the headers
        // if (options.path != '/LoginScreen' && options.path != '/ChangePassScreen') {
        //   options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
        // }
        if (kDebugMode) {
          print(
              'Request[${options.method}] => PATH: ${options.path}, HEADERS: ${options.headers}, DATA: ${options.data}');
        }
        handler.next(options);
      },
      onResponse:
          (dio.Response response, dio.ResponseInterceptorHandler handler) {
        if (kDebugMode) {
          print('Response[${response.statusCode}] => DATA: ${response.data}');
        }
        handler.next(response);
      },
      onError: (dio.DioException e, dio.ErrorInterceptorHandler handler) {
        if (kDebugMode) {
          print('Error[${e.response?.statusCode}] => MESSAGE: ${e.message}');
        }
        handler.next(e);
      },
    ));
  }

  static Future<dio.Response<dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      if (kDebugMode) {
        print(
            'DioInstance GET request: $path, Query Parameters: $queryParameters');
      }
      final response =
          await dioInstance.get(path, queryParameters: queryParameters);
      if (kDebugMode) {
        print('DioInstance GET response: ${response.data}');
      }
      return response;
    } catch (error) {
      // Handle request errors
      if (kDebugMode) {
        print('DioInstance GET error: $error');
      }
      rethrow;
    }
  }

  static Future<dio.Response<dynamic>> post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      if (kDebugMode) {
        print(
            'DioInstance POST request: $path, Data: $data, Query Parameters: $queryParameters');
      }

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final response = await dioInstance.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: dio.Options(headers: headers),
      );

      if (kDebugMode) {
        print('DioInstance POST response: ${response.data}');
      }

      return response;
    } catch (error) {
      // Handle request errors
      if (kDebugMode) {
        print('DioInstance POST error: $error');
      }
      rethrow;
    }
  }
}
