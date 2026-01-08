import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/tickets/presentation/pages/tickets_page.dart';
import '../../features/tickets/presentation/pages/ticket_detail_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/tickets',
        name: 'tickets',
        builder: (context, state) => const TicketsPage(),
      ),
      GoRoute(
        path: '/tickets/:id',
        name: 'ticket-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TicketDetailPage(ticketId: id);
        },
      ),
    ],
  );
}
