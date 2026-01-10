# Ticket Resolution App

A modern, responsive Flutter application built as a technical assessment for the Flutter Developer role. This app allows users to manage service tickets, track their resolution status, and manage their profile with persistent local storage.

## 🚀 Main Highlights & Achievements

### ✅ Clean Architecture

Implemented a strict separation of concerns using **Data**, **Domain**, and **Presentation** layers:

- **Data Layer**: Remote API calls via Dio, local data models, repository implementations
- **Domain Layer**: Business logic entities, use cases, and abstract repository contracts
- **Presentation Layer**: UI widgets, Cubits for state management, responsive screens

This architecture ensures scalability, testability, and maintainability across the codebase.

### ✅ State Management with Cubit (BLoC Pattern)

- **AuthCubit**: Handles login/logout and persists authentication state
- **TicketCubit**: Manages ticket fetching, filtering, and resolved status tracking
- **ThemeCubit**: Toggles between light and dark modes

All Cubits extend `HydratedCubit` for automatic persistence.

### ✅ Persistent Local State via Hydrated BLoC

- **Authentication**: Login state persists across app restarts
- **Ticket Resolution**: "Marked as Resolved" status is saved locally and survives app closure
- **Theme Preference**: Dark mode selection is remembered

Platform-aware: Gracefully handles both mobile and web platforms without native plugin conflicts.

### ✅ Material 3 & Dark Mode Support

- Full Material 3 design implementation with dynamic color theming
- Semantic color usage (primary, surface, error, outline)
- Responsive layouts using Material widgets (Cards, Chips, Badges, FilledButtons)
- Seamless dark/light mode toggle on Profile screen

### ✅ Declarative Routing with GoRouter

- **ShellRoute** for bottom navigation (Tickets & Profile tabs)
- **Sub-routes** for ticket detail screen with parameter passing
- **Auth-aware redirects** to automatically route to login if not authenticated
- Deep linking support ready for future expansion

---

## 🛠️ Technical Stack

| Layer                      | Technology                                   |
| -------------------------- | -------------------------------------------- |
| **Framework**              | Flutter (Latest Stable)                      |
| **Language**               | Dart 3.10.4+                                 |
| **State Management**       | flutter_bloc (8.1.6) + hydrated_bloc (9.1.5) |
| **Navigation**             | go_router (14.6.2)                           |
| **Local Storage**          | hydrated_bloc (automatic JSON serialization) |
| **Networking**             | dio (5.7.0)                                  |
| **Dependency Injection**   | get_it (8.0.2)                               |
| **Functional Programming** | dartz (0.10.1) - Either/Or pattern           |
| **Design**                 | Material 3 with cupertino_icons              |

---

## 📋 Features Implemented

### 1️⃣ Mocked Authentication

- **Login Screen** with Material 3 form design
- Email and password validation
- Loading indicator during login
- Error message display
- Persistent session state via Hydrated BLoC
- Auto-redirect to tickets when authenticated

### 2️⃣ Ticket Management

- **Fetch Real-time Data**: Connects to [JSONPlaceholder API](https://jsonplaceholder.typicode.com/posts)
- **Creative Material 3 Card UI**:
  - Dynamic background color based on resolved status
  - Circular status indicator (icon + color)
  - Strikethrough title for resolved tickets
  - Green "Resolved" badge for marked tickets
  - Ripple effect on tap (InkWell)
- **Detailed View**:

  - Full ticket title and description
  - Status chip showing OPEN/RESOLVED
  - AppBar icon indicator for resolved status
  - Responsive padding and scrolling

- **Mark as Resolved**:
  - Material 3 FilledButton with icon
  - Immediate UI update via BLoC rebuild
  - Persisted locally via Hydrated storage
  - Button disables once resolved
  - SnackBar confirmation

### 3️⃣ Profile Management

- **User Information Card**: Avatar + name/email
- **Settings Section**: Dark mode toggle (persisted)
- **About Section**: App version and tech stack info
- **Logout Button**: Clears auth state and navigates to login
- Material 3 card-based layout

### 4️⃣ Responsive Design

- Optimized for mobile, tablet, and desktop
- Adaptive widgets (CircularProgressIndicator.adaptive, Switch.adaptive)
- Proper padding and spacing using EdgeInsets
- ConstrainedBox for max-width on login screen
- SingleChildScrollView for overflow prevention

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── di/
│   │   └── injection_container.dart        # Dependency injection setup
│   ├── error/
│   │   ├── failures.dart                   # Failure models
│   │   └── exceptions.dart                 # Custom exceptions
│   ├── network/
│   │   └── dio_client.dart                 # Dio HTTP client config
│   └── router/
│       └── app_router.dart                 # GoRouter configuration
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── auth_cubit.dart
│   │       │   └── auth_state.dart
│   │       └── screens/
│   │           └── login_screen.dart
│   │
│   ├── tickets/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── ticket_remote_data_source.dart
│   │   │   ├── models/
│   │   │   │   └── ticket_model.dart
│   │   │   └── repositories/
│   │   │       └── ticket_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── ticket.dart
│   │   │   ├── repositories/
│   │   │   │   └── ticket_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_tickets.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── ticket_cubit.dart
│   │       │   └── ticket_state.dart
│   │       ├── screens/
│   │       │   ├── tickets_list_screen.dart
│   │       │   └── ticket_detail_screen.dart
│   │       └── widgets/
│   │           └── main_scaffold.dart
│   │
│   ├── profile/
│   │   └── presentation/
│   │       └── screens/
│   │           └── profile_screen.dart
│   │
│   └── theme/
│       └── presentation/
│           └── cubit/
│               └── theme_cubit.dart
│
├── app.dart                                # App widget & bootstrap
└── main.dart                               # Entry point
```

---

## 🔄 State Persistence & Navigation Flow

### Authentication Flow

1. User taps "Login" → `AuthCubit.login()` is called
2. After mock delay, `isAuthenticated` state changes to `true`
3. Hydrated BLoC persists this to local storage
4. GoRouter redirect detects authentication and navigates to `/tickets`
5. On app restart, Hydrated restores the auth state automatically

### Ticket Resolution Flow

1. User navigates to ticket detail screen
2. Taps "Mark as Resolved" → `TicketCubit.markResolved(ticketId)` is called
3. Ticket state updates immediately, UI rebuilds with strikethrough title
4. Hydrated BLoC persists the resolved set to local storage
5. On app restart, the resolved status is restored

### Platform Support

- **Mobile (Android/iOS)**: Full persistence via Hydrated BLoC with file system storage
- **Web**: Graceful fallback (skips file system, uses default browser storage)

---

## 🚀 How to Run

### Prerequisites

- Flutter SDK (latest stable)
- Dart 3.10.4 or higher
- An IDE (VS Code, Android Studio, or Xcode)

### Steps

1. **Clone the repository**:

   ```bash
   git clone https://github.com/YOUR_USERNAME/ticket_app.git
   cd ticket_app
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Run the app** (on mobile/emulator):

   ```bash
   flutter run
   ```

4. **Run on web**:

   ```bash
   flutter run -d web
   ```

5. **Build release APK** (Android):

   ```bash
   flutter build apk --release
   ```

   The APK will be generated at `build/app/outputs/flutter-app-release.apk`

6. **Build release iOS** (macOS only):
   ```bash
   flutter build ios --release
   ```

---

## ✨ Testing Persistence

### How to Verify Hydrated BLoC Works

1. Login to the app
2. Navigate to Tickets, mark a ticket as resolved (green checkmark appears)
3. **Force close** the app or use `flutter run` to restart
4. **Expected**: Login state is restored, ticket status is still marked as resolved
5. Navigate to Profile and toggle dark mode
6. **Restart** the app
7. **Expected**: Dark mode preference is remembered

---

## 📦 Build Output

The built APK is available in:

- **Mobile**: `build/app/outputs/flutter-app-release.apk`
- **Web**: `build/web/` (serve with a static server)

---

## 🎯 Key Design Decisions

### 1. Hydrated BLoC Over SharedPreferences

- Automatically handles serialization/deserialization
- Reduces boilerplate code
- Type-safe state management
- Seamless integration with Cubit

### 2. Either/Or Pattern (Dartz)

- Clear separation between success (Right) and failure (Left)
- Functional approach to error handling
- Repository pattern returns `Either<Failure, T>`

### 3. Material 3 Design

- Future-proof design system
- Dynamic color theming support
- Semantic color usage for accessibility
- Brand consistency across light and dark modes

### 4. GoRouter for Navigation

- Declarative routing (easier to understand flow)
- Support for deep linking
- Auth-aware redirects
- ShellRoute for persistent bottom nav

---

## 📝 Technical Debt & Future Enhancements

- [ ] Add unit tests for Cubits and repositories
- [ ] Implement widget tests for UI screens
- [ ] Add animations (Hero widgets for ticket transitions)
- [ ] Support real authentication backend (Firebase, JWT)
- [ ] Add search/filter functionality for tickets
- [ ] Implement pagination for large ticket lists
- [ ] Add export/share ticket functionality
- [ ] Localization support (multiple languages)

## 📄 License

This project is submitted as a technical assessment for InterIntel.

---

**Built with ❤️ using Flutter & Dart**
