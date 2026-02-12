import 'package:test_app/src/data_sources/network/dio_request_protocol.dart';

abstract class DioSessionProtocol {
  Future<T> request<T>({
    required DioRequestProtocol service,
    required T Function(Map<String, dynamic>) fromJson,
  });
}
