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
      return const Scaffold(body: Center(child: Text('Ticket not found')));
    }

    final isResolved = ticket!.isResolved;

    return Scaffold(
      appBar: AppBar(title: Text('Ticket #${ticket!.id}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ticket!.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(ticket!.body),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isResolved
                    ? null
                    : () {
                        context.read<TicketCubit>().markResolved(ticket!.id);
                        Navigator.of(context).pop();
                      },
                icon: const Icon(Icons.check_circle_outline),
                label: Text(isResolved ? 'Resolved' : 'Mark as Resolved'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
