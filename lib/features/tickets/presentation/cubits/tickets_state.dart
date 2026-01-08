part of 'tickets_cubit.dart';

abstract class TicketsState extends Equatable {
  const TicketsState();

  @override
  List<Object?> get props => [];
}

class TicketsInitial extends TicketsState {}

class TicketsLoading extends TicketsState {}

class TicketsLoaded extends TicketsState {
  final List<Ticket> tickets;
  final Set<int> resolvedTicketIds;

  const TicketsLoaded(this.tickets, this.resolvedTicketIds);

  @override
  List<Object?> get props => [tickets, resolvedTicketIds];
}

class TicketsError extends TicketsState {
  final String message;

  const TicketsError(this.message);

  @override
  List<Object?> get props => [message];
}
