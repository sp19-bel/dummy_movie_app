import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/src/core/config/theme/app_colors.dart';
import 'package:test_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:test_app/src/features/home/presentation/cubit/home_state.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

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
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeLoaded) {
          return Column(
            children: [
              AppBar(
                title: const Text('Watch'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/movie-search'),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return ListTile(
                      title: Text(movie.title),
                      subtitle: Text(movie.releaseDate),
                      trailing: Text(
                        '${movie.voteAverage}',
                        style: const TextStyle(color: AppColors.textGrey),
                      ),
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/movie-detail',
                        arguments: movie.id,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: Text('Something went wrong'));
      },
    );
  }
}
