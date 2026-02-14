import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/src/core/config/theme/app_colors.dart';
import 'package:test_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:test_app/src/features/home/presentation/cubit/home_state.dart';
import 'package:test_app/src/features/home/domain/entities/upcoming_movie_entity.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Comedy',
      'image':
          'https://image.tmdb.org/t/p/w500/8kOWDBK6XlPUz36hWAw350mopbl.jpg'
    },
    {
      'name': 'Horror',
      'image': 'https://image.tmdb.org/t/p/w500/u3bZgnGQ9TWAZQv92dp3uMwFGL7.jpg'
    },
    {
      'name': 'Adventure',
      'image': 'https://image.tmdb.org/t/p/w500/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg'
    },
    {
      'name': 'Drama',
      'image': 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg'
    },
    {
      'name': 'Action',
      'image': 'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg'
    },
    {
      'name': 'Sci-Fi',
      'image': 'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg'
    },
    {
      'name': 'Romance',
      'image': 'https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg'
    },
    {
      'name': 'Thriller',
      'image': 'https://image.tmdb.org/t/p/w500/vOddBS759082XC6lR4s7k0gDPZt.jpg'
    },
     
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              _buildTopSection(context),
              Expanded(
                child: selectedCategory == null
                    ? _buildCategoryGrid()
                    : _buildMoviesList(state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
      color: Colors.white,
      child: TextField(
        readOnly: true,
        onTap: () => Navigator.pushNamed(context, '/movie-search'),
        decoration: InputDecoration(
          hintText: 'TV Shows, movies and more',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffix: const Icon(Icons.close_sharp, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
         enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide.none,
  ),
   focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide.none,
  ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryCard(category);
      },
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category['name'];
        });
        context.read<HomeCubit>().fetchMoviesByGenre(category['name']);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                category['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey);
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 12,
              child: Text(
                category['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesList(HomeState state) {
    if (state is HomeLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is HomeLoaded) {
      final movies = state.movies;
      
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      selectedCategory = null;
                    });
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  selectedCategory ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${movies.length} movies',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: movies.isEmpty
                ? const Center(
                    child: Text('No movies found in this category'),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return _buildMovieCard(movie);
                    },
                  ),
          ),
        ],
      );
    }

    return const Center(child: Text('Something went wrong'));
  }

  Widget _buildMovieCard(UpcomingMovieEntity movie) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/movie-detail',
        arguments: movie.id,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
                image: movie.posterPath != null && movie.posterPath!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: movie.posterPath == null || movie.posterPath!.isEmpty
                  ? const Center(child: Icon(Icons.movie, size: 40))
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                '${movie.voteAverage}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
