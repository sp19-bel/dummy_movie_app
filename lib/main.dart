import 'package:flutter/material.dart';

import 'package:test_app/src/app.dart';
import 'package:test_app/src/injection.dart';

export 'src/src.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
