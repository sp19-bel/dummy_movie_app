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
              final screenHeight = MediaQuery.of(context).size.height;

              String formattedReleaseDate = movie.releaseDate;
              final parsedDate = DateTime.tryParse(movie.releaseDate);
              if (parsedDate != null) {
                const months = [
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December',
                ];
                formattedReleaseDate =
                    '${months[parsedDate.month - 1]} ${parsedDate.day}, ${parsedDate.year}';
              }

              Color genreColor(String genre) {
                switch (genre.toLowerCase()) {
                  case 'action':
                    return const Color(0xFF15D2BC);
                  case 'thriller':
                    return const Color(0xFFE26CA5);
                  case 'science fiction':
                  case 'sci-fi':
                    return const Color(0xFFCD9D0F);
                  case 'drama':
                    return const Color(0xFF3B82F6);
                  case 'comedy':
                    return const Color(0xFFF59E0B);
                  case 'horror':
                    return const Color(0xFFEF4444);
                  default:
                    return const Color(0xFF6B7280);
                }
              }

              final trailer = state.videos.where(
                (v) => v.site == 'YouTube' && v.type == 'Trailer',
              );

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: screenHeight * 0.65,
                    pinned: true,
                    backgroundColor: Colors.black,
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          Positioned.fill(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) =>
                                  Container(color: Colors.grey[900]),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Color(0xCC111827),
                                    Color(0xFF111827),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 24,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  movie.title.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFE8C366),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'In Theaters $formattedReleaseDate',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      '/date-time-selection',
                                      arguments: {
                                        'movieTitle': movie.title,
                                        'releaseDate': formattedReleaseDate,
                                      },
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF61C3F2),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Get Tickets',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
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
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'No trailer available',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Watch Trailer',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.4,
                                      ),
                                      backgroundColor: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Genres',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF202C43),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: movie.genres
                                .map(
                                  (g) => Chip(
                                    label: Text(
                                      g.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    backgroundColor: genreColor(g.name),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(color: Color(0xff000000), height: 0),
                          ),
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
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Color(0xFF8F8F8F),
                            ),
                          ),
                          const SizedBox(height: 24),
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
