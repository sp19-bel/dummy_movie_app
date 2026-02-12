import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

import 'package:test_app/src/data_sources/network/dio_request_protocol.dart';

class DioRequest extends Interceptor {
  final DioRequestProtocol service;

  DioRequest({required this.service});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = service.baseUrl;
    options.path = service.endpoint;
    options.method = service.method;
    options.headers.addAll(service.headers);
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);
    options.sendTimeout = const Duration(seconds: 30);

    if (service.formData.isNotEmpty) {
      final Map<String, dynamic> formFields = {};
      service.formData.forEach((key, value) {
        if (value is File) {
          final mimeType = lookupMimeType(value.path) ?? 'application/octet-stream';
          final mimeTypeParts = mimeType.split('/');
          formFields[key] = MultipartFile.fromFileSync(
            value.path,
            contentType: DioMediaType(mimeTypeParts[0], mimeTypeParts[1]),
          );
        } else {
          formFields[key] = value.toString();
        }
      });
      options.data = FormData.fromMap(formFields);
    } else {
      options.data = service.data;
      options.queryParameters = service.queryParameters;
    }

    handler.next(options);
  }
}
