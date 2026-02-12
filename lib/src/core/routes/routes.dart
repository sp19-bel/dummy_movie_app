import 'package:flutter/material.dart';

import 'package:test_app/src/features/movies/presentation/screens/movie_list_screen.dart';
import 'package:test_app/src/features/movies/presentation/screens/movie_detail_screen.dart';
import 'package:test_app/src/features/movies/presentation/screens/movie_search_screen.dart';
import 'package:test_app/src/features/movies/presentation/screens/seat_mapping_screen.dart';

class AppRouter {
  static const String movieList = '/';
  static const String movieDetail = '/movie-detail';
  static const String movieSearch = '/movie-search';
  static const String seatMapping = '/seat-mapping';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case movieList:
        return MaterialPageRoute(builder: (_) => const MovieListScreen());
      case movieDetail:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailScreen(movieId: movieId),
        );
      case movieSearch:
        return MaterialPageRoute(builder: (_) => const MovieSearchScreen());
      case seatMapping:
        return MaterialPageRoute(builder: (_) => const SeatMappingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
