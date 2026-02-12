# test_app

A Flutter project using Clean Architecture with Feature-First folder structure.

## Tech Stack

| Concern            | Package          |
|--------------------|------------------|
| State Management   | flutter_bloc (Cubit) |
| Dependency Injection | get_it         |
| Networking         | dio              |
| Local Storage      | hive / hive_flutter |
| Form Handling      | reactive_forms   |

## Getting Started

```bash
flutter pub get
flutter run
```

## Adding a New Feature

1. Copy `lib/src/features/feature_name/` to `lib/src/features/<your_feature>/`
2. Rename barrel files to match the new feature name
3. Export the new feature in `lib/src/features/features.dart`
4. Register data sources, repositories, and use cases in `lib/src/injection.dart`
5. Add routes in `lib/src/core/routes/`
