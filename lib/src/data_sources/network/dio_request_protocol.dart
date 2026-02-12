abstract class DioRequestProtocol {
  String get method;
  String get baseUrl;
  String get endpoint;
  Map<String, String> get headers => {};
  Map<String, dynamic> get data => {};
  Map<String, dynamic> get formData => {};
  Map<String, dynamic> get queryParameters => {};

  @override
  String toString() =>
      'DioRequestProtocol(method: $method, baseUrl: $baseUrl, endpoint: $endpoint, headers: $headers, data: $data, formData: $formData, queryParameters: $queryParameters)';
}
