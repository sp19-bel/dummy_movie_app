import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_app/src/core/config/flavors/flavor_config.dart';
import 'package:test_app/src/injection.dart';

class Services {
  Services._();
  static final Services _shared = Services._();
  static Services get shared => _shared;

  Future<void> init(Flavor flavor) async {
    await dotenv.load(fileName: '.env');
    FlavorConfig.shared.set(
      flavor: flavor,
      values: FlavorValues(name: flavor.value),
    );
    await configureDependencies();
  }
}
