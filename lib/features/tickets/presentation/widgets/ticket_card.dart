import 'package:flutter/material.dart';
import '../../domain/entities/ticket.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback onTap;
  final VoidCallback onToggleResolved;

  const TicketCard({
    super.key,
    required this.ticket,
    required this.onTap,
    required this.onToggleResolved,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
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
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      ticket.isResolved
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: ticket.isResolved
                          ? Colors.green
                          : Theme.of(context).colorScheme.outline,
                    ),
                    onPressed: onToggleResolved,
                    tooltip: ticket.isResolved
                        ? 'Mark as Open'
                        : 'Mark as Resolved',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ticket.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Chip(
                  label: Text(
                    ticket.isResolved ? 'Resolved' : 'Open',
                    style: TextStyle(
                      fontSize: 12,
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
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
