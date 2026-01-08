part of 'ticket_cubit.dart';

enum TicketStatus { initial, loading, success, failure }

class TicketState extends Equatable {
  final TicketStatus status;
  final List<Ticket> tickets;
  final Set<int> resolvedIds;
  final String? errorMessage;

  const TicketState({
    this.status = TicketStatus.initial,
    this.tickets = const [],
    this.resolvedIds = const {},
    this.errorMessage,
  });

  TicketState copyWith({
    TicketStatus? status,
    List<Ticket>? tickets,
    Set<int>? resolvedIds,
    String? errorMessage,
  }) {
    return TicketState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      resolvedIds: resolvedIds ?? this.resolvedIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, tickets, resolvedIds, errorMessage];
}
