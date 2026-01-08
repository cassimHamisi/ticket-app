# Quick Start Guide

## 🚀 Get Started in 3 Steps

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the App
```bash
flutter run
```

### 3. Test the App
```bash
flutter test
```

## 📱 Using the App

### Login
1. **Open the app** - You'll see the login screen
2. **Enter credentials**:
   - Username: `any username` (demo uses mock API)
   - Password: `any password`
3. **Click Login** - Navigates to tickets page

### View Tickets
1. **Tickets load automatically** from API
2. **Pull down** to refresh the list
3. **Tap a ticket card** to view details
4. **Toggle checkmark** to mark as resolved/open
5. **Theme icon** (top right) switches light/dark mode
6. **Menu** (three dots) - logout option

### Ticket Details
1. **View full information** about the ticket
2. **Mark as Resolved** button toggles status
3. **Back arrow** returns to tickets list

### Persistence Features
- ✅ Login status saved (stays logged in after restart)
- ✅ Resolved tickets saved (maintains state after restart)
- ✅ Theme preference saved (remembers light/dark choice)

## 🏗️ Project Structure at a Glance

```
lib/
├── main.dart              ← App entry point
├── core/                  ← Shared utilities
│   ├── constants/         ← API config
│   ├── themes/            ← Material 3 themes
│   └── utils/             ← Router config
└── features/              ← Feature modules
    ├── auth/              ← Login/authentication
    │   ├── data/          ← API & models
    │   ├── domain/        ← Entities & interfaces
    │   └── presentation/  ← UI & state
    └── tickets/           ← Ticket management
        ├── data/          ← API & models
        ├── domain/        ← Entities & interfaces
        └── presentation/  ← UI & state
```

## 🎨 Key Features

| Feature | Description |
|---------|-------------|
| **Clean Architecture** | Domain → Data → Presentation layers |
| **State Management** | Bloc/Cubit with HydratedBloc |
| **Navigation** | GoRouter (type-safe) |
| **HTTP Client** | Dio for API calls |
| **Persistence** | HydratedBloc automatic storage |
| **Themes** | Material 3 light/dark modes |
| **Responsive** | Adapts to mobile/tablet/desktop |
| **Testing** | Unit tests included |

## 📚 Documentation

- **README.md** - Project overview
- **ARCHITECTURE.md** - Detailed architecture guide
- **IMPLEMENTATION_SUMMARY.md** - Complete implementation details
- **QUICK_START.md** - This file!

## 🔧 Common Commands

```bash
# Get dependencies
flutter pub get

# Run app (debug mode)
flutter run

# Run app (release mode)
flutter run --release

# Run tests
flutter test

# Run with specific device
flutter run -d chrome          # Web
flutter run -d macos           # macOS
flutter run -d <device-id>     # Specific device

# Build for production
flutter build apk              # Android
flutter build ios              # iOS
flutter build web              # Web

# Clean build
flutter clean
flutter pub get
flutter run

# Analyze code
flutter analyze

# Check outdated packages
flutter pub outdated
```

## 🐛 Troubleshooting

### App won't build
```bash
flutter clean
flutter pub get
flutter run
```

### Dependencies error
```bash
flutter pub cache repair
flutter pub get
```

### HydratedBloc error
Make sure `path_provider` is properly installed:
```bash
flutter pub get
```

### No devices found
```bash
flutter devices          # List available devices
flutter emulators        # List available emulators
flutter emulators --launch <emulator-id>
```

## 🎯 Next Steps

1. **Explore the code** - Start with `lib/main.dart`
2. **Read ARCHITECTURE.md** - Understand the structure
3. **Run tests** - See how testing works
4. **Modify features** - Try changing themes or adding fields
5. **Build for production** - Deploy to your device

## 📱 App Flow

```
┌─────────────┐
│ Login Page  │
└──────┬──────┘
       │ Login Success
       ↓
┌─────────────┐     ┌──────────────┐
│Tickets Page │────→│ Ticket Detail│
└──────┬──────┘     └──────────────┘
       │
       ├─→ Toggle Resolved (persisted)
       ├─→ Toggle Theme (persisted)
       └─→ Logout
```

## 💡 Tips

- **Auto-format**: Use `flutter format .` to format code
- **Hot reload**: Press `r` in terminal during `flutter run`
- **Hot restart**: Press `R` in terminal during `flutter run`
- **DevTools**: Run app, then `flutter pub global run devtools`
- **Logs**: Use `print()` or `debugPrint()` for debugging

## ⚡ Performance

- App uses efficient state management
- Only affected widgets rebuild
- HydratedBloc provides instant state restoration
- Material 3 uses hardware acceleration
- Lazy loading in grid views

## 🔐 Security Notes

- This demo uses mock authentication
- For production:
  - Implement real auth backend
  - Use secure token storage
  - Add API key management
  - Implement proper error handling
  - Add input sanitization

## 📞 Support

For issues or questions:
1. Check ARCHITECTURE.md for detailed explanations
2. Review IMPLEMENTATION_SUMMARY.md for complete overview
3. Check Flutter documentation: https://flutter.dev
4. Check package documentation in pubspec.yaml

---

**Happy Coding! 🎉**
