# test_app — Flutter Clean Architecture

## Architecture
- Clean Architecture with Feature-First folder structure
- State Management: BLoC (Cubit)
- Dependency Injection: GetIt
- Networking: Dio
- Local Storage: Hive
- Form Handling: Reactive Forms

## Rules
- Every feature has 3 layers: data → domain → presentation
- Every folder has a barrel .dart export file
- One Cubit + State pair per feature inside cubit/
- One UseCase class per business action
- One API service class per endpoint
- DI registrations go in injection.dart
- Navigation uses named routes via onGenerateRoute
- FlavorConfig singleton for multi-environment support

## Adding a New Feature
1. Duplicate features/feature_name/ folder
2. Rename to your feature name
3. Register data sources, repositories, and use cases in injection.dart
4. Add routes in core/routes/
