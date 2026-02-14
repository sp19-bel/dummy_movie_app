import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:test_app/src/core/config/theme/app_theme.dart';
import 'package:test_app/src/core/routes/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  final ValueNotifier<bool> _isOnline = ValueNotifier<bool>(true);

  late StreamSubscription<List<ConnectivityResult>> _sub;

  @override
  void initState() {
    super.initState();
    
 
    Connectivity().checkConnectivity().then((results) {
      _updateStatus(results);
    });

   
    _sub = Connectivity().onConnectivityChanged.listen((results) {
      _updateStatus(results);
    });
  }


  void _updateStatus(List<ConnectivityResult> results) {
  
    bool isOffline = results.contains(ConnectivityResult.none) || results.isEmpty;
    _isOnline.value = !isOffline;
  }

  @override
  void dispose() {
    _sub.cancel();
    _isOnline.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.home,
     
      builder: (context, child) {
        return Stack(
          children: [
           
            if (child != null) child,
            
           
            ValueListenableBuilder<bool>(
              valueListenable: _isOnline,
              builder: (context, online, _) {
                if (online) return const SizedBox.shrink(); 
                
                return Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: SafeArea(
                    child: Material(
                      
                      color: const Color(0xFFE26CA5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        width: double.infinity,
                        child: const Text(
                          'No internet connection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}