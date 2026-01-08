import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ticket_app/features/auth/presentation/screens/login_screen.dart';
import 'package:ticket_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';
import 'package:ticket_app/features/tickets/presentation/screens/ticket_detail_screen.dart';
import 'package:ticket_app/features/tickets/presentation/screens/tickets_list_screen.dart';
import 'package:ticket_app/features/tickets/presentation/widgets/main_scaffold.dart';

class AppRouter {
  AppRouter({required this.authCubit});

  final AuthCubit authCubit;

  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: RouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      final loggedIn = authCubit.state.isAuthenticated;
      final location = state.uri.toString();
      final loggingIn = location == '/login';

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/tickets';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/tickets',
            builder: (context, state) => const TicketsListScreen(),
            routes: [
              GoRoute(
                path: 'details',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final extra = state.extra;
                  if (extra is Ticket) {
                    return TicketDetailScreen(ticket: extra);
                  }
                  return const TicketDetailScreen(ticket: null);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}

class RouterRefreshStream extends ChangeNotifier {
  RouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
