import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';
import 'package:ticket_app/features/tickets/presentation/cubit/ticket_cubit.dart';

class TicketsListScreen extends StatefulWidget {
  const TicketsListScreen({super.key});

  @override
  State<TicketsListScreen> createState() => _TicketsListScreenState();
}

class _TicketsListScreenState extends State<TicketsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TicketCubit>().loadTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service Tickets'), centerTitle: false),
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          switch (state.status) {
            case TicketStatus.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case TicketStatus.failure:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.errorMessage ?? 'Failed to load tickets',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        icon: const Icon(Icons.refresh),
                        onPressed: () =>
                            context.read<TicketCubit>().loadTickets(),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            case TicketStatus.success:
              if (state.tickets.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      const Text('No tickets found'),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => context.read<TicketCubit>().loadTickets(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = state.tickets[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TicketCard(ticket: ticket),
                    );
                  },
                ),
              );
            case TicketStatus.initial:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isResolved = ticket.isResolved;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: isResolved
          ? colorScheme.surfaceContainerHighest.withAlpha((0.5 * 255).round())
          : colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isResolved ? Colors.transparent : colorScheme.outlineVariant,
        ),
      ),
      child: InkWell(
        onTap: () => context.push('/tickets/details', extra: ticket),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'ticket-icon-${ticket.id}',
                child: CircleAvatar(
                  backgroundColor: isResolved
                      ? Colors.green
                      : colorScheme.primary,
                  child: Icon(
                    isResolved
                        ? Icons.check_circle
                        : Icons.confirmation_number_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: isResolved
                            ? TextDecoration.lineThrough
                            : null,
                        color: isResolved ? colorScheme.onSurfaceVariant : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if (isResolved) ...[
                const SizedBox(width: 8),
                Badge(
                  label: const Text('Resolved'),
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
