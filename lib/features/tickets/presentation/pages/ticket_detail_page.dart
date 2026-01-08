import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/tickets_cubit.dart';
import '../../domain/entities/ticket.dart';

class TicketDetailPage extends StatelessWidget {
  final String ticketId;

  const TicketDetailPage({
    super.key,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
      ),
      body: BlocBuilder<TicketsCubit, TicketsState>(
        builder: (context, state) {
          if (state is TicketsLoaded) {
            final ticket = state.tickets.firstWhere(
              (t) => t.id.toString() == ticketId,
              orElse: () => const Ticket(
                id: 0,
                title: 'Not Found',
                description: 'Ticket not found',
                isResolved: false,
              ),
            );

            if (ticket.id == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ticket not found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Card
                  Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Ticket #${ticket.id}',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                ),
                              ),
                              Chip(
                                label: Text(
                                  ticket.isResolved ? 'Resolved' : 'Open',
                                  style: TextStyle(
                                    color: ticket.isResolved
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ),
                                side: BorderSide(
                                  color: ticket.isResolved
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Title Card
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ticket.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Description Card
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ticket.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Action Button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilledButton.icon(
                      onPressed: () {
                        context.read<TicketsCubit>().toggleTicketResolved(ticket.id);
                      },
                      icon: Icon(
                        ticket.isResolved ? Icons.restart_alt : Icons.check_circle,
                      ),
                      label: Text(
                        ticket.isResolved ? 'Reopen Ticket' : 'Mark as Resolved',
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
