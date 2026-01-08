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
      appBar: AppBar(title: const Text('Tickets')),
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          switch (state.status) {
            case TicketStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case TicketStatus.failure:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.errorMessage ?? 'Failed to load tickets'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<TicketCubit>().loadTickets(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            case TicketStatus.success:
              if (state.tickets.isEmpty) {
                return const Center(child: Text('No tickets found'));
              }
              return RefreshIndicator(
                onRefresh: () => context.read<TicketCubit>().loadTickets(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.tickets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final ticket = state.tickets[index];
                    return _TicketCard(ticket: ticket);
                  },
                ),
              );
            case TicketStatus.initial:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final isResolved = ticket.isResolved;
    return Card(
      child: ListTile(
        title: Text(ticket.title),
        subtitle: Text(
          ticket.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: isResolved
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.chevron_right),
        onTap: () => context.push('/tickets/details', extra: ticket),
      ),
    );
  }
}
