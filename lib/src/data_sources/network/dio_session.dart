import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:test_app/src/data_sources/network/dio_request.dart';
import 'package:test_app/src/data_sources/network/dio_request_protocol.dart';
import 'package:test_app/src/data_sources/network/dio_session_protocol.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class DioSession implements DioSessionProtocol {
  final Dio client;

  DioSession({required this.client});

  @override
  Future<T> request<T>({
    required DioRequestProtocol service,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw NoInternetException();
    }

    final interceptor = DioRequest(service: service);
    client.interceptors.add(interceptor);

    final requestHeaders = {
      ...service.headers,
    };

    if (service.method.toUpperCase() == 'GET') {
      requestHeaders.remove('Content-Type');
      requestHeaders.remove('content-type');
    }

    print('================= REQUEST: ${service.method} ${service.endpoint}');
    print('====================== FINAL HEADERS: $requestHeaders');
    print('==================== QUERY PARAMS: ${service.queryParameters}');

    try {
      final response = await client.request(
        service.endpoint,
        queryParameters: service.queryParameters,
        options: Options(
          method: service.method,
          headers: requestHeaders,
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        dynamic decoded = response.data;

        if (decoded is String) {
          decoded = jsonDecode(decoded);
        }

        if (decoded is! Map<String, dynamic>) {
          throw GeneralException(
            statusCode: response.statusCode,
            message:
                'Invalid response format: expected Map but got ${decoded.runtimeType}',
          );
        }

        return fromJson(decoded);
      }

      throw GeneralException(
        statusCode: response.statusCode,
        message: 'Unexpected response',
      );
    } on DioException catch (e) {
      print('%%%%%%%%%%%%%%%%%%%%%% DIO ERROR: ${e.response?.statusCode}');
      print('%%%%%%%%%%%%%%%%%%%%%%%% ERROR DATA: ${e.response?.data}');

      final message = switch (e.type) {
        DioExceptionType.connectionTimeout => 'Connection timed out',
        DioExceptionType.sendTimeout => 'Request send timed out',
        DioExceptionType.receiveTimeout => 'Response timed out',
        DioExceptionType.badCertificate => 'Invalid certificate',
        DioExceptionType.badResponse =>
          (e.response?.data is Map
                  ? e.response?.data['status_message']
                  : null)
              ?.toString() ??
          'Server error (${e.response?.statusCode})',
        DioExceptionType.cancel => 'Request was cancelled',
        DioExceptionType.connectionError => 'Connection error',
        DioExceptionType.unknown => 'An unexpected error occurred',
      };

      throw GeneralException(
        statusCode: e.response?.statusCode,
        message: message,
      );
    } on SocketException {
      throw NoInternetException();
    } finally {
      client.interceptors.remove(interceptor);
    }
  }
}
