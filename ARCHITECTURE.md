# App Architecture Documentation

## Overview
This Flutter application follows Clean Architecture principles with clear separation of concerns across three main layers.

## Architecture Layers

### 1. Domain Layer (Business Logic)
- **Location**: `lib/features/*/domain/`
- **Purpose**: Contains business entities and repository interfaces
- **Components**:
  - `entities/`: Pure Dart classes representing business objects (Ticket, User)
  - `repositories/`: Abstract interfaces defining data operations

### 2. Data Layer (Data Management)
- **Location**: `lib/features/*/data/`
- **Purpose**: Handles data operations, API calls, and data transformation
- **Components**:
  - `models/`: Data models with JSON serialization (extends entities)
  - `datasources/`: API clients using Dio for HTTP requests
  - `repositories/`: Concrete implementations of domain repository interfaces

### 3. Presentation Layer (UI & State)
- **Location**: `lib/features/*/presentation/`
- **Purpose**: User interface and state management
- **Components**:
  - `cubits/`: State management using Bloc/Cubit pattern
  - `pages/`: Full-screen UI components
  - `widgets/`: Reusable UI components

## Core Modules

### Core Layer
- **Location**: `lib/core/`
- **Purpose**: Shared utilities and configurations
- **Components**:
  - `constants/`: API endpoints and app constants
  - `themes/`: Material 3 theme configurations
  - `utils/`: Router configuration with GoRouter

## Features

### 1. Authentication Feature
**Path**: `lib/features/auth/`

**Flow**:
1. User enters credentials in LoginPage
2. AuthCubit calls AuthRepository.login()
3. AuthRemoteDataSource makes API call
4. User model returned and state updated
5. HydratedBloc persists authentication state

**Key Files**:
- `presentation/pages/login_page.dart`: Login UI
- `presentation/cubits/auth_cubit.dart`: Auth state management
- `domain/entities/user.dart`: User entity
- `data/models/user_model.dart`: User data model
- `data/repositories/auth_repository_impl.dart`: Auth repository implementation

### 2. Tickets Feature
**Path**: `lib/features/tickets/`

**Flow**:
1. TicketsPage loads tickets via TicketsCubit
2. TicketsCubit calls TicketRepository.getTickets()
3. TicketRemoteDataSource fetches data from API
4. Tickets displayed in responsive grid
5. Users can toggle resolved status (persisted via HydratedBloc)
6. Clicking a ticket navigates to TicketDetailPage

**Key Files**:
- `presentation/pages/tickets_page.dart`: Main tickets list
- `presentation/pages/ticket_detail_page.dart`: Individual ticket view
- `presentation/widgets/ticket_card.dart`: Reusable ticket card
- `presentation/cubits/tickets_cubit.dart`: Tickets state management
- `presentation/cubits/theme_cubit.dart`: Theme switching
- `domain/entities/ticket.dart`: Ticket entity
- `data/models/ticket_model.dart`: Ticket data model
- `data/repositories/ticket_repository_impl.dart`: Ticket repository

## State Management

### Hydrated Bloc Implementation
Hydrated Bloc automatically persists and restores state:

1. **AuthCubit**: Saves authenticated user data
   - Restored on app restart to maintain login session

2. **TicketsCubit**: Saves resolved ticket IDs
   - Preserves which tickets user marked as resolved

3. **ThemeCubit**: Saves theme preference
   - Remembers light/dark mode selection

### Storage Location
- Uses `path_provider` to get app documents directory
- State stored as JSON in local storage
- Automatically hydrated on app launch

## Navigation

### GoRouter Configuration
**File**: `lib/core/utils/router.dart`

**Routes**:
- `/login`: Authentication page (initial route)
- `/tickets`: Main tickets list
- `/tickets/:id`: Individual ticket details

**Navigation Examples**:
```dart
// Navigate to tickets
context.go('/tickets');

// Navigate to ticket detail
context.go('/tickets/123');

// Navigate back
context.pop();
```

## Material 3 Themes

### Theme Configuration
**File**: `lib/core/themes/app_theme.dart`

**Features**:
- Dynamic color schemes from seed color (blue)
- Consistent component styling (cards, buttons, inputs)
- Automatic color adaptation for light/dark modes
- Material 3 design tokens

### Responsive Design
- Grid layout adjusts based on screen width
- 1 column on mobile (< 600px)
- 2 columns on tablet/desktop (>= 600px)
- Adaptive spacing and sizing

## Data Flow Example: Loading Tickets

```
1. User opens app
   ↓
2. TicketsPage calls TicketsCubit.loadTickets()
   ↓
3. TicketsCubit emits TicketsLoading state
   ↓
4. TicketRepository.getTickets() called
   ↓
5. TicketRemoteDataSource makes HTTP GET request
   ↓
6. JSON response converted to TicketModel list
   ↓
7. Models converted to Ticket entities
   ↓
8. Resolved states merged from HydratedBloc storage
   ↓
9. TicketsCubit emits TicketsLoaded state
   ↓
10. UI rebuilds with ticket list
```

## API Integration

### Base Configuration
**File**: `lib/core/constants/api_constants.dart`

**Endpoints**:
- Base URL: `https://jsonplaceholder.typicode.com`
- Tickets: `/todos`
- Login: `/users/1`

### HTTP Client
- **Library**: Dio
- **Features**: 
  - Automatic JSON parsing
  - Error handling
  - Base URL configuration
  - RESTful operations (GET, POST, PUT, DELETE)

## Testing

### Test Coverage
**Location**: `test/`

**Tests Included**:
1. `ticket_entity_test.dart`: Ticket entity behavior
2. `ticket_model_test.dart`: JSON serialization/deserialization

**Running Tests**:
```bash
flutter test
```

## Dependencies

### Production Dependencies
- `flutter_bloc`: ^8.1.3 - State management
- `hydrated_bloc`: ^9.1.2 - State persistence
- `equatable`: ^2.0.5 - Value equality
- `go_router`: ^12.1.3 - Declarative routing
- `dio`: ^5.4.0 - HTTP client
- `path_provider`: ^2.1.1 - File system paths

### Dev Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: ^3.0.0 - Linting rules

## Getting Started

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the App**:
   ```bash
   flutter run
   ```

3. **Run Tests**:
   ```bash
   flutter test
   ```

4. **Build for Production**:
   ```bash
   flutter build apk  # Android
   flutter build ios  # iOS
   flutter build web  # Web
   ```

## Key Design Decisions

1. **Clean Architecture**: Ensures testability, maintainability, and scalability
2. **Hydrated Bloc**: Automatic state persistence without boilerplate
3. **GoRouter**: Type-safe, declarative routing
4. **Material 3**: Modern, accessible design system
5. **Responsive Layout**: Works across all screen sizes
6. **Repository Pattern**: Abstraction over data sources for flexibility
