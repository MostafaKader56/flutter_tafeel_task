import 'package:dio/dio.dart';
import '../../main.dart';

class ApiService {
  final _baseUrl = 'https://reqres.in/api/';
  final Dio _dio;

  ApiService(this._dio) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          printLogs(
            message: 'Request: ${options.method} ${options.uri}',
            title: "Back-End Api",
          );
          printLogs(
            message: 'Headers: ${options.headers}',
            title: "Back-End Api",
          );
          if (options.data != null) {
            printLogs(message: 'Body: ${options.data}', title: "Back-End Api");
          }
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          printLogs(
            message:
                'Response: ${response.statusCode} ${response.requestOptions.uri}',
            title: "Back-End Api",
          );
          printLogs(
            message: 'Response Body: ${response.data}',
            title: "Back-End Api",
          );
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          printLogs(
            message:
                'Error: ${error.response?.statusCode} ${error.requestOptions.uri}',
            title: "Back-End Api",
          );
          if (error.response != null) {
            printLogs(
              message: 'Error Response: ${error.response?.data}',
              title: "Back-End Api",
            );
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(headers: {'Accept': 'application/json'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Object? params,
  }) async {
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: params,
      options: Options(headers: {'Accept': 'application/json'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    Object? params,
  }) async {
    var response = await _dio.put(
      '$_baseUrl$endPoint',
      data: params,
      options: Options(headers: {'Accept': 'application/json'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Object? params,
  }) async {
    var response = await _dio.delete(
      '$_baseUrl$endPoint',
      data: params,
      options: Options(headers: {'Accept': 'application/json'}),
    );
    return response.data;
  }
}
