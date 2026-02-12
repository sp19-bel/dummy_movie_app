import 'package:flutter/material.dart';

import 'package:test_app/src/app.dart';
import 'package:test_app/src/core/config/flavors/flavor_config.dart';
import 'package:test_app/src/shared/services/app_services.dart';

export 'src/src.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Services.shared.init(Flavor.development);
  runApp(const App());
}
