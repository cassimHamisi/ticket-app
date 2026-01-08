import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ticket_app/core/di/injection_container.dart';
import 'package:ticket_app/core/router/app_router.dart';
import 'package:ticket_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ticket_app/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:ticket_app/features/tickets/presentation/cubit/ticket_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthCubit _authCubit;
  late final ThemeCubit _themeCubit;
  late final TicketCubit _ticketCubit;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authCubit = AuthCubit();
    _themeCubit = ThemeCubit();
    _ticketCubit = TicketCubit(getTickets: sl());
    _appRouter = AppRouter(authCubit: _authCubit);
  }

  @override
  void dispose() {
    _authCubit.close();
    _themeCubit.close();
    _ticketCubit.close();
    super.dispose();
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      brightness: Brightness.light,
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      brightness: Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: _authCubit),
        BlocProvider<ThemeCubit>.value(value: _themeCubit),
        BlocProvider<TicketCubit>.value(value: _ticketCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: _lightTheme(),
            darkTheme: _darkTheme(),
            themeMode: themeMode,
            routerConfig: _appRouter.router,
          );
        },
      ),
    );
  }
}

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  // Only initialize Hydrated storage on mobile/desktop platforms
  // Web uses default browser storage which is handled automatically
  if (!_isWeb()) {
    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    HydratedBloc.storage = storage;
  }
}

bool _isWeb() {
  try {
    return identical(0, 0.0) == false;
  } catch (_) {
    return true;
  }
}
