import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ticket_app/features/theme/presentation/cubit/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    context.read<AuthCubit>().logout();
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDark = themeCubit.state == ThemeMode.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Avatar & Info Card
              Card.filled(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: colorScheme.primary,
                        child: Text(
                          'DU',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Demo User',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'demo@example.com',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Settings Section
              Text(
                'Settings',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: colorScheme.outline),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isDark ? Icons.dark_mode : Icons.light_mode,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Text('Dark Mode'),
                        ],
                      ),
                      Switch.adaptive(
                        value: isDark,
                        onChanged: (value) => themeCubit.toggleTheme(value),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // About Section
              Text(
                'About',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: colorScheme.outline),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ticket Resolution App',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Version 1.0.0',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'State management: Flutter BLoC with Hydrated persistence',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
