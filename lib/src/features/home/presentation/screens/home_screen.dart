import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/src/core/config/theme/app_colors.dart';
import 'package:test_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:test_app/src/features/home/presentation/cubit/home_state.dart';
import 'package:test_app/src/features/home/presentation/screens/dashboard_screen.dart';
import 'package:test_app/src/features/home/presentation/screens/watch_screen.dart';
import 'package:test_app/src/features/home/presentation/screens/media_library_screen.dart';
import 'package:test_app/src/features/home/presentation/screens/more_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Widget> _screens = [
    DashboardScreen(),
    WatchScreen(),
    MediaLibraryScreen(),
    MoreScreen(),
  ];

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
          body: IndexedStack(
            index: state.currentIndex,
            children: _screens,
          ),
          bottomNavigationBar:ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(27),
            topRight: Radius.circular(27)),
            child: BottomNavigationBar(
              
              currentIndex: state.currentIndex,
              onTap: (index) => context.read<HomeCubit>().changeTab(index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.backgroundDark,
              selectedItemColor: AppColors.white,
              unselectedItemColor: AppColors.textGrey,
              selectedLabelStyle: const TextStyle(fontSize: 12),
              unselectedLabelStyle: const TextStyle(fontSize: 12),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  activeIcon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.play_circle_outline),
                  activeIcon: Icon(Icons.play_circle),
                  label: 'Watch',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.video_library_outlined),
                  activeIcon: Icon(Icons.video_library),
                  label: 'Media Library',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  activeIcon: Icon(Icons.menu_open),
                  label: 'More',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}