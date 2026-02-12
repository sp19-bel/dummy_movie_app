enum Flavor {
  development('Development'),
  staging('Staging'),
  production('Production');

  final String value;
  const Flavor(this.value);
}

class FlavorValues {
  final String name;
  FlavorValues({required this.name});
}

class FlavorConfig {
  late Flavor flavor;
  late FlavorValues values;

  FlavorConfig._();
  static final FlavorConfig _shared = FlavorConfig._();
  static FlavorConfig get shared => _shared;

  void set({required Flavor flavor, required FlavorValues values}) {
    _shared.flavor = flavor;
    _shared.values = values;
  }
}

