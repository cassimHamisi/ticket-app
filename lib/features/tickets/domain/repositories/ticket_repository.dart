import 'package:dartz/dartz.dart';
import 'package:ticket_app/core/error/failures.dart';
import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<Ticket>>> getTickets();
}
