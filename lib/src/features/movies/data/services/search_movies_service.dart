import 'package:test_app/src/data_sources/api_client.dart';
import 'package:test_app/src/data_sources/network/dio_request_protocol.dart';
import 'package:test_app/src/injection.dart';

class SearchMoviesService extends DioRequestProtocol {
  final String query;
  final int page;

  SearchMoviesService({required this.query, this.page = 1});

  @override
  String get baseUrl => di<ApiClient>().baseUrl;

  @override
  String get endpoint => di<ApiClient>().endpoint(Api.searchMovies);

  @override
  String get method => di<ApiClient>().method(Api.searchMovies);

  @override
  Map<String, String> get headers => di<ApiClient>().headers();

  @override
  Map<String, dynamic> get queryParameters => {'query': query, 'page': page};
}
