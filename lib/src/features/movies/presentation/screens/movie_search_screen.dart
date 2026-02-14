import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_search_cubit.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_search_state.dart';
import 'package:test_app/src/injection.dart';

class MovieSearchScreen extends StatelessWidget {
  const MovieSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<MovieSearchCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: TextField(
                      onChanged: (query) {
                        context.read<MovieSearchCubit>().search(query: query);
                      },

                      decoration: InputDecoration(
                        hintText: 'TV Shows, movies and more',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.close),
                        filled: true,
                        fillColor: Colors.grey.shade200,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  
                  Expanded(
                    child: BlocConsumer<MovieSearchCubit, MovieSearchState>(
                      listener: (context, state) {
                        if (state is MovieSearchError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },

                      builder: (context, state) {
                        /// Loading
                        if (state is MovieSearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        
                        if (state is MovieSearchLoaded &&
                            state.movies.isNotEmpty) {
                          return Column(
                            children: [
                              /// TOP RESULTS
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),

                                child: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          "Top Results",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    Divider(color: Colors.grey.shade300),
                                  ],
                                ),
                              ),

                              /// LIST
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(16),

                                  itemCount: state.movies.length,

                                  itemBuilder: (context, index) {
                                    final movie = state.movies[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),

                                      child: Row(
                                        children: [
                                          
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(
                                                context,
                                                '/movie-detail',
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                              child: movie.posterPath != null &&
                                                      movie.posterPath!.isNotEmpty
                                                  ? Image.network(
                                                      "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                                                      width: 100,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Container(
                                                          width: 100,
                                                          height: 60,
                                                          color: Colors.grey[300],
                                                          child: const Icon(
                                                            Icons.movie,
                                                            size: 30,
                                                            color: Colors.grey,
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(
                                                      width: 100,
                                                      height: 60,
                                                      color: Colors.grey[300],
                                                      child: const Icon(
                                                        Icons.movie,
                                                        size: 30,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            ),
                                          ),

                                          const SizedBox(width: 12),

                                          Expanded(
                                            child: Text(
                                              movie.title,

                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),

                                          const Icon(
                                            Icons.more_horiz,
                                            color: Colors.lightBlue,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }

                        /// Empty
                        if (state is MovieSearchLoaded &&
                            state.movies.isEmpty) {
                          return const Center(child: Text("No results found"));
                        }

                        return const Center(child: Text("Search movies"));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
