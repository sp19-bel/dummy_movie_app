// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:test_app/src/core/config/flavors/flavor_config.dart';

// enum Api {
//   upcomingMovies,
//   movieDetails,
//   movieImages,
//   movieVideos,
//   searchMovies,
// }

// enum HttpMethods {
//   get('GET'),
//   post('POST'),
//   patch('PATCH'),
//   put('PUT'),
//   delete('DELETE');

//   final String value;
//   const HttpMethods(this.value);
// }

// class ApiClient {
//   final Flavor flavor;

//   ApiClient({required this.flavor});

//   static String get apiKey => dotenv.env['API_KEY'] ?? '';
//   static String get apiReadToken => dotenv.env['API_READ_TOKEN'] ?? '';

//   static const String _developmentBaseUrl = 'https://api.themoviedb.org/3';
//   static const String _stagingBaseUrl = 'https://api.themoviedb.org/3';
//   static const String _productionBaseUrl = 'https://api.themoviedb.org/3';

//   static const String _movie = '/movie';
//   static const String _search = '/search';

//   late final _upcomingMovies = '$_movie/upcoming';
//   late final _searchMovies = '$_search/movie';

//   String get baseUrl {
//     switch (flavor) {
//       case Flavor.development:
//         return _developmentBaseUrl;
//       case Flavor.staging:
//         return _stagingBaseUrl;
//       case Flavor.production:
//         return _productionBaseUrl;
//     }
//   }

//   String endpoint(Api type, {int? movieId}) {
//     switch (type) {
//       case Api.upcomingMovies:
//         return _upcomingMovies;
//       case Api.movieDetails:
//         return '$_movie/$movieId';
//       case Api.movieImages:
//         return '$_movie/$movieId/images';
//       case Api.movieVideos:
//         return '$_movie/$movieId/videos';
//       case Api.searchMovies:
//         return _searchMovies;
//     }
//   }

//   String method(Api type) {
//     switch (type) {
//       case Api.upcomingMovies:
//         return HttpMethods.get.value;
//       case Api.movieDetails:
//         return HttpMethods.get.value;
//       case Api.movieImages:
//         return HttpMethods.get.value;
//       case Api.movieVideos:
//         return HttpMethods.get.value;
//       case Api.searchMovies:
//         return HttpMethods.get.value;
//     }
//   }

//   Map<String, String> headers() {
//     return {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $apiReadToken',
//     };
//   }
// }



import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_app/src/core/config/flavors/flavor_config.dart';

enum Api {
  upcomingMovies,
  movieDetails,
  movieImages,
  movieVideos,
  searchMovies,
}

enum HttpMethods {
  get('GET'),
  post('POST'),
  patch('PATCH'),
  put('PUT'),
  delete('DELETE');

  final String value;
  const HttpMethods(this.value);
}

class ApiClient {
  final Flavor flavor;

  ApiClient({required this.flavor});

  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get apiReadToken => dotenv.env['API_READ_TOKEN'] ?? '';

  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _movie = '/movie';
  static const String _search = '/search';

  String get baseUrl => _baseUrl;

  String endpoint(Api type, {int? movieId}) {
    switch (type) {
      case Api.upcomingMovies:
        return '$_movie/upcoming';
      case Api.movieDetails:
        return '$_movie/$movieId';
      case Api.movieImages:
        return '$_movie/$movieId/images';
      case Api.movieVideos:
        return '$_movie/$movieId/videos';
      case Api.searchMovies:
        return '$_search/movie';
    }
  }

  String method(Api type) => HttpMethods.get.value;

  Map<String, String> headers() {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiReadToken',
    };
  }

  Map<String, dynamic> queryParameters() {
    return {
      'api_key': apiKey,
    };
  }
}
