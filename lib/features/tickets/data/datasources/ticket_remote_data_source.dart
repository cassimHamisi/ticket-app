import 'package:dio/dio.dart';
import 'package:ticket_app/core/error/exceptions.dart';
import 'package:ticket_app/core/network/dio_client.dart';
import 'package:ticket_app/features/tickets/data/models/ticket_model.dart';

abstract class TicketRemoteDataSource {
  Future<List<TicketModel>> getTickets();
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final DioClient client;
  TicketRemoteDataSourceImpl(this.client);

  @override
  Future<List<TicketModel>> getTickets() async {
    try {
      final response = await client.dio.get(ApiConstants.postsEndpoint);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ServerException('Failed to fetch tickets');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      }
      throw ServerException(e.message ?? 'Server error');
    } catch (_) {
      throw ServerException('Unexpected server error');
    }
  }
}
