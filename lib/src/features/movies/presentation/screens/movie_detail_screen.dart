import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:test_app/src/features/movies/presentation/cubit/movie_detail_cubit.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_detail_state.dart';
import 'package:test_app/src/features/movies/presentation/screens/trailer_screen.dart';
import 'package:test_app/src/injection.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<MovieDetailCubit>()..fetchMovieDetail(movieId: movieId),
      child: Scaffold(
        body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieDetailError) {
              return Center(child: Text(state.message));
            }
            if (state is MovieDetailLoaded) {
              final movie = state.movie;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        movie.title,
                        style: const TextStyle(
                          shadows: [Shadow(blurRadius: 8)],
                        ),
                      ),
                      background: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) =>
                            Container(color: Colors.grey[900]),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (movie.tagline.isNotEmpty) ...[
                            Text(
                              movie.tagline,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.access_time, size: 20),
                              const SizedBox(width: 4),
                              Text('${movie.runtime} min'),
                              const SizedBox(width: 16),
                              Text(movie.releaseDate),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: movie.genres
                                .map((g) => Chip(label: Text(g.name)))
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.overview,
                            style: const TextStyle(fontSize: 15, height: 1.5),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                final trailer = state.videos.where(
                                  (v) =>
                                      v.site == 'YouTube' &&
                                      v.type == 'Trailer',
                                );
                                if (trailer.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TrailerScreen(
                                        videoKey: trailer.first.key,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('No trailer available'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Watch Trailer'),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/seat-mapping'),
                              icon: const Icon(Icons.event_seat),
                              label: const Text('Book Tickets'),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
