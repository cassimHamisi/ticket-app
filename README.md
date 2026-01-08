# Ticket App

A Flutter ticket management application built with Clean Architecture, Material 3, and modern state management.

## Features

- ✅ Clean Architecture (Domain, Data, Presentation layers)
- ✅ State Management with Bloc/Cubit
- ✅ Persistent state using Hydrated_Bloc
- ✅ Navigation with GoRouter
- ✅ HTTP requests with Dio
- ✅ Material 3 Design
- ✅ Responsive layouts
- ✅ Light/Dark theme support
- ✅ Authentication flow
- ✅ Ticket management (view, resolve/reopen)

## Project Structure

```
lib/
├── core/
│   ├── constants/     # API constants
│   ├── themes/        # Material 3 themes
│   └── utils/         # Router configuration
├── features/
│   ├── auth/
│   │   ├── data/      # Models, repositories, data sources
│   │   ├── domain/    # Entities, repository interfaces
│   │   └── presentation/ # Cubits, pages, widgets
│   └── tickets/
│       ├── data/      # Models, repositories, data sources
│       ├── domain/    # Entities, repository interfaces
│       └── presentation/ # Cubits, pages, widgets
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/cassimHamisi/ticket-app.git
cd ticket-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Architecture

This app follows Clean Architecture principles:

- **Domain Layer**: Contains business entities and repository interfaces
- **Data Layer**: Implements repositories, handles API calls, and data models
- **Presentation Layer**: UI components, state management (Cubits), and pages

## State Management

- **Hydrated_Bloc**: Persists authentication state and resolved ticket status
- **Bloc/Cubit**: Manages app state for Auth, Tickets, and Theme
- **Equatable**: Simplifies state comparison

## API

The app uses JSONPlaceholder API for demonstration:
- Base URL: `https://jsonplaceholder.typicode.com`
- Tickets endpoint: `/todos`
- Auth endpoint: `/users/1`

## Key Dependencies

- `flutter_bloc`: ^8.1.3
- `hydrated_bloc`: ^9.1.2
- `go_router`: ^12.1.3
- `dio`: ^5.4.0
- `equatable`: ^2.0.5
- `path_provider`: ^2.1.1

## License

This project is open source and available under the MIT License.