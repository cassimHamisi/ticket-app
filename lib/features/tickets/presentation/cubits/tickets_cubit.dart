import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';

part 'tickets_state.dart';

class TicketsCubit extends HydratedCubit<TicketsState> {
  final TicketRepository ticketRepository;

  TicketsCubit(this.ticketRepository) : super(TicketsInitial());

  Future<void> loadTickets() async {
    emit(TicketsLoading());
    try {
      final tickets = await ticketRepository.getTickets();
      final mergedTickets = _mergeResolvedStates(tickets);
      emit(mergedTickets);
    } catch (e) {
      emit(TicketsError(e.toString()));
    }
  }

  TicketsLoaded _mergeResolvedStates(List<Ticket> tickets) {
    final currentState = state;
    if (currentState is TicketsLoaded) {
      final resolvedIds = currentState.resolvedTicketIds;
      final updatedTickets = tickets.map((ticket) {
        if (resolvedIds.contains(ticket.id)) {
          return ticket.copyWith(isResolved: true);
        }
        return ticket;
      }).toList();
      return TicketsLoaded(updatedTickets, resolvedIds);
    }
    return TicketsLoaded(tickets, {});
  }

  void toggleTicketResolved(int ticketId) {
    final currentState = state;
    if (currentState is TicketsLoaded) {
      final tickets = currentState.tickets.map((ticket) {
        if (ticket.id == ticketId) {
          return ticket.copyWith(isResolved: !ticket.isResolved);
        }
        return ticket;
      }).toList();

      final resolvedIds = Set<int>.from(currentState.resolvedTicketIds);
      final ticket = tickets.firstWhere((t) => t.id == ticketId);
      if (ticket.isResolved) {
        resolvedIds.add(ticketId);
      } else {
        resolvedIds.remove(ticketId);
      }

      emit(TicketsLoaded(tickets, resolvedIds));
    }
  }

  @override
  TicketsState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['type'] == 'loaded') {
        final ticketsJson = json['tickets'] as List<dynamic>;
        final tickets = ticketsJson.map((t) => Ticket(
          id: t['id'] as int,
          title: t['title'] as String,
          description: t['description'] as String,
          isResolved: t['isResolved'] as bool,
        )).toList();
        
        final resolvedIds = (json['resolvedTicketIds'] as List<dynamic>)
            .map((id) => id as int)
            .toSet();
        
        return TicketsLoaded(tickets, resolvedIds);
      }
    } catch (e) {
      // Log deserialization error for debugging
      print('Error deserializing tickets state: $e');
    }
    return TicketsInitial();
  }

  @override
  Map<String, dynamic>? toJson(TicketsState state) {
    if (state is TicketsLoaded) {
      return {
        'type': 'loaded',
        'tickets': state.tickets.map((t) => {
          'id': t.id,
          'title': t.title,
          'description': t.description,
          'isResolved': t.isResolved,
        }).toList(),
        'resolvedTicketIds': state.resolvedTicketIds.toList(),
      };
    }
    return null;
  }
}
