import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/src/features/home/domain/use_cases/get_upcoming_movies_usecase.dart';
import 'package:test_app/src/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;

  HomeCubit({required this.getUpcomingMoviesUseCase}) : super(HomeInitial());

  void changeTab(int index) {
    final current = state;
    if (current is HomeLoaded) {
      emit(HomeLoaded(movies: current.movies, currentIndex: index));
    } else if (current is HomeError) {
      emit(HomeError(message: current.message, currentIndex: index));
    } else if (current is HomeLoading) {
      emit(HomeLoading(currentIndex: index));
    } else {
      emit(HomeInitial(currentIndex: index));
    }
  }

  Future<void> fetchUpcomingMovies() async {
    emit(HomeLoading(currentIndex: state.currentIndex));
    final result = await getUpcomingMoviesUseCase.call();
    result.fold(
      (failure) => emit(HomeError(
          message: failure.message ?? 'Something went wrong',
          currentIndex: state.currentIndex)),
      (movies) =>
          emit(HomeLoaded(movies: movies, currentIndex: state.currentIndex)),
    );
  }

  Future<void> fetchMoviesByGenre(String genre) async {
    emit(HomeLoading(currentIndex: state.currentIndex));
    final result = await getUpcomingMoviesUseCase.call(genre: genre);
    result.fold(
      (failure) => emit(HomeError(
          message: failure.message ?? 'Something went wrong',
          currentIndex: state.currentIndex)),
      (movies) =>
          emit(HomeLoaded(movies: movies, currentIndex: state.currentIndex)),
    );
  }
}
