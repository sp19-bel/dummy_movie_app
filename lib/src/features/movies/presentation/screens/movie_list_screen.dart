import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_app/src/features/movies/presentation/cubit/movie_list_cubit.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_list_state.dart';
import 'package:test_app/src/features/movies/presentation/widgets/movie_card.dart';
import 'package:test_app/src/injection.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<MovieListCubit>()..fetchUpcomingMovies(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upcoming Movies'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () =>
                  Navigator.pushNamed(context, '/movie-search'),
            ),
          ],
        ),
        body: BlocBuilder<MovieListCubit, MovieListState>(
          builder: (context, state) {
            if (state is MovieListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieListError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<MovieListCubit>()
                          .fetchUpcomingMovies(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is MovieListLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(
                    movie: movie,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/movie-detail',
                      arguments: movie.id,
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
