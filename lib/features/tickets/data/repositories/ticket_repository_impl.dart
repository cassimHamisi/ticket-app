import 'package:dartz/dartz.dart';
import 'package:ticket_app/core/error/exceptions.dart';
import 'package:ticket_app/core/error/failures.dart';
import 'package:ticket_app/features/tickets/data/datasources/ticket_remote_data_source.dart';
import 'package:ticket_app/features/tickets/data/models/ticket_model.dart';
import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';
import 'package:ticket_app/features/tickets/domain/repositories/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource;

  TicketRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Ticket>>> getTickets() async {
    try {
      final List<TicketModel> tickets = await remoteDataSource.getTickets();
      return Right(tickets.map((e) => e.toEntity()).toList());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Unknown error'));
    }
  }
}
