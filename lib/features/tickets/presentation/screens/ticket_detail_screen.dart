import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';
import 'package:ticket_app/features/tickets/presentation/cubit/ticket_cubit.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({super.key, required this.ticket});

  final Ticket? ticket;

  @override
  Widget build(BuildContext context) {
    if (ticket == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ticket Details')),
        body: const Center(child: Text('Ticket not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket #${ticket!.id}'),
        centerTitle: false,
        actions: [
          if (ticket!.isResolved)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Tooltip(
                message: 'Resolved',
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
            ),
        ],
      ),
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          final currentTicket = state.tickets.firstWhere(
            (t) => t.id == ticket!.id,
            orElse: () => ticket!,
          );

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    currentTicket.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Status Chip
                  Chip(
                    label: Text(
                      currentTicket.isResolved ? 'RESOLVED' : 'OPEN',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    avatar: Hero(
                      tag: 'ticket-hero-${currentTicket.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: CircleAvatar(
                          backgroundColor: currentTicket.isResolved
                              ? Colors.green
                              : Theme.of(context).colorScheme.primary,
                          child: Icon(
                            currentTicket.isResolved
                                ? Icons.check_circle
                                : Icons.confirmation_number_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: currentTicket.isResolved
                        ? Colors.green.withAlpha((0.2 * 255).round())
                        : Colors.orange.withAlpha((0.2 * 255).round()),
                  ),
                  const SizedBox(height: 24),

                  // Body
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentTicket.body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),

                  // Mark as Resolved Button
                  GestureDetector(
                    onTap: currentTicket.isResolved
                        ? null
                        : () {
                            context.read<TicketCubit>().markResolved(
                              currentTicket.id,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ticket marked as resolved'),
                                duration: Duration(milliseconds: 1500),
                              ),
                            );
                          },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: currentTicket.isResolved
                            ? Colors.green.withAlpha((0.15 * 255).round())
                            : Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(
                          currentTicket.isResolved ? 30 : 8,
                        ),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: currentTicket.isResolved
                              ? Row(
                                  key: const ValueKey('resolved'),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green[700],
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Resolved',
                                      style: TextStyle(
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  key: ValueKey('mark-resolved'),
                                  'Mark as Resolved',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
