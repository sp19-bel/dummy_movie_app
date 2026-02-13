import 'package:test_app/src/features/home/domain/entities/upcoming_movie_entity.dart';

abstract class HomeState {
  final int currentIndex;
  HomeState({this.currentIndex = 0});
}

class HomeInitial extends HomeState {
  HomeInitial({super.currentIndex});
}

class HomeLoading extends HomeState {
  HomeLoading({super.currentIndex});
}

class HomeLoaded extends HomeState {
  final List<UpcomingMovieEntity> movies;
  HomeLoaded({required this.movies, super.currentIndex});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message, super.currentIndex});
}
