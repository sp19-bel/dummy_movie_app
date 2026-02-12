import 'package:test_app/src/data_sources/api_client.dart';
import 'package:test_app/src/data_sources/network/dio_request_protocol.dart';
import 'package:test_app/src/injection.dart';

class UpcomingMoviesService extends DioRequestProtocol {
  final int page;

  UpcomingMoviesService({this.page = 1});

  @override
  String get baseUrl => di<ApiClient>().baseUrl;

  @override
  String get endpoint => di<ApiClient>().endpoint(Api.upcomingMovies);

  @override
  String get method => di<ApiClient>().method(Api.upcomingMovies);

  @override
  Map<String, String> get headers => di<ApiClient>().headers();

  @override
  Map<String, dynamic> get queryParameters => {'page': page};
}
