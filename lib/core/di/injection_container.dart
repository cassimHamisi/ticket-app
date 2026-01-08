import 'package:get_it/get_it.dart';
import 'package:ticket_app/core/network/dio_client.dart';
import 'package:ticket_app/features/tickets/data/datasources/ticket_remote_data_source.dart';
import 'package:ticket_app/features/tickets/data/repositories/ticket_repository_impl.dart';
import 'package:ticket_app/features/tickets/domain/repositories/ticket_repository.dart';
import 'package:ticket_app/features/tickets/domain/usecases/get_tickets.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Data sources
  sl.registerLazySingleton<TicketRemoteDataSource>(
    () => TicketRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<TicketRepository>(
    () => TicketRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTickets(sl()));
}
