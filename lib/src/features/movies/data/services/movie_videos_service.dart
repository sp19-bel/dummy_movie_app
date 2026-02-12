import 'package:test_app/src/data_sources/api_client.dart';
import 'package:test_app/src/data_sources/network/dio_request_protocol.dart';
import 'package:test_app/src/injection.dart';

class MovieVideosService extends DioRequestProtocol {
  final int movieId;

  MovieVideosService({required this.movieId});

  @override
  String get baseUrl => di<ApiClient>().baseUrl;

  @override
  String get endpoint =>
      di<ApiClient>().endpoint(Api.movieVideos, movieId: movieId);

  @override
  String get method => di<ApiClient>().method(Api.movieVideos);

  @override
  Map<String, String> get headers => di<ApiClient>().headers();
}
