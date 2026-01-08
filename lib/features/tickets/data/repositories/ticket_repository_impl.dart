import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../datasources/ticket_remote_datasource.dart';
import '../models/ticket_model.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource;

  TicketRepositoryImpl({TicketRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? TicketRemoteDataSource();

  @override
  Future<List<Ticket>> getTickets() async {
    final ticketModels = await remoteDataSource.getTickets();
    return ticketModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Ticket> getTicketById(int id) async {
    final ticketModel = await remoteDataSource.getTicketById(id);
    return ticketModel.toEntity();
  }

  @override
  Future<Ticket> updateTicket(Ticket ticket) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    final updatedModel = await remoteDataSource.updateTicket(ticketModel);
    return updatedModel.toEntity();
  }
}
