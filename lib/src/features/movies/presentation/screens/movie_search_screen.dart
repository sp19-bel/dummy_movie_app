import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_app/src/features/movies/presentation/cubit/movie_search_cubit.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_search_state.dart';
import 'package:test_app/src/features/movies/presentation/widgets/movie_card.dart';
import 'package:test_app/src/injection.dart';

class MovieSearchScreen extends StatelessWidget {
  const MovieSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<MovieSearchCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search Movies')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Builder(
                builder: (context) {
                  return TextField(
                    decoration: InputDecoration(
                      hintText: 'Search movies...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (query) =>
                        context.read<MovieSearchCubit>().search(query: query),
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<MovieSearchCubit, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is MovieSearchError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is MovieSearchLoaded) {
                    if (state.movies.isEmpty) {
                      return const Center(child: Text('No results found'));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                  return const Center(
                    child: Text('Search for movies above'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
