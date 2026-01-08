import 'package:dartz/dartz.dart';
import 'package:ticket_app/core/error/failures.dart';
import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';
import 'package:ticket_app/features/tickets/domain/repositories/ticket_repository.dart';

class GetTickets {
  final TicketRepository repository;
  GetTickets(this.repository);

  Future<Either<Failure, List<Ticket>>> call() async {
    return repository.getTickets();
  }
}
