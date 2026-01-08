import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';
import 'package:ticket_app/features/tickets/domain/usecases/get_tickets.dart';

part 'ticket_state.dart';

class TicketCubit extends HydratedCubit<TicketState> {
  TicketCubit({required this.getTickets}) : super(const TicketState());

  final GetTickets getTickets;

  Future<void> loadTickets() async {
    emit(state.copyWith(status: TicketStatus.loading, errorMessage: null));
    final result = await getTickets();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TicketStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (tickets) {
        final updatedTickets = tickets
            .map(
              (ticket) => ticket.copyWith(
                isResolved: state.resolvedIds.contains(ticket.id),
              ),
            )
            .toList();
        emit(
          state.copyWith(
            status: TicketStatus.success,
            tickets: updatedTickets,
            resolvedIds: state.resolvedIds,
          ),
        );
      },
    );
  }

  void markResolved(int ticketId) {
    final updatedResolved = {...state.resolvedIds, ticketId};
    final updatedTickets = state.tickets
        .map(
          (ticket) => ticket.id == ticketId
              ? ticket.copyWith(isResolved: true)
              : ticket,
        )
        .toList();
    emit(state.copyWith(tickets: updatedTickets, resolvedIds: updatedResolved));
  }

  @override
  TicketState? fromJson(Map<String, dynamic> json) {
    final resolved = (json['resolvedIds'] as List<dynamic>? ?? [])
        .map((e) => e as int)
        .toSet();
    final storedTickets = (json['tickets'] as List<dynamic>? ?? [])
        .map(
          (e) => Ticket(
            id: e['id'] as int,
            userId: e['userId'] as int,
            title: e['title'] as String,
            body: e['body'] as String,
            isResolved: e['isResolved'] as bool? ?? false,
          ),
        )
        .toList();
    return TicketState(
      status: TicketStatus.success,
      tickets: storedTickets,
      resolvedIds: resolved,
    );
  }

  @override
  Map<String, dynamic>? toJson(TicketState state) {
    return {
      'resolvedIds': state.resolvedIds.toList(),
      'tickets': state.tickets
          .map(
            (t) => {
              'id': t.id,
              'userId': t.userId,
              'title': t.title,
              'body': t.body,
              'isResolved': t.isResolved,
            },
          )
          .toList(),
    };
  }
}
