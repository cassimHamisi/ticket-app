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
                      tag: 'ticket-icon-${currentTicket.id}',
                      child: CircleAvatar(
                        backgroundColor: currentTicket.isResolved
                            ? Colors.green
                            : Theme.of(context).colorScheme.primary,
                        child: Icon(
                          currentTicket.isResolved
                              ? Icons.check_circle
                              : Icons.access_time,
                          size: 16,
                          color: Colors.white,
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
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstChild: FilledButton.icon(
                        onPressed: currentTicket.isResolved
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
                        icon: const Icon(Icons.check),
                        label: Text('Mark as Resolved'),
                      ),
                      secondChild: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha((0.08 * 255).round()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '✅ This ticket has been resolved',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      crossFadeState: currentTicket.isResolved
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      layoutBuilder:
                          (topChild, topKey, bottomChild, bottomKey) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                  key: bottomKey,
                                  child: bottomChild,
                                ),
                                Positioned.fill(key: topKey, child: topChild),
                              ],
                            );
                          },
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
