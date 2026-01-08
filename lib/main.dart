import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'core/themes/app_theme.dart';
import 'core/constants/api_constants.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';
import 'features/tickets/presentation/cubits/tickets_cubit.dart';
import 'features/tickets/presentation/cubits/theme_cubit.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/tickets/data/repositories/ticket_repository_impl.dart';
import 'core/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(AuthRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => TicketsCubit(TicketRepositoryImpl()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Ticket App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
