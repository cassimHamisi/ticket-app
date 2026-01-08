import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/ticket_model.dart';

class TicketRemoteDataSource {
  final Dio dio;

  TicketRemoteDataSource({Dio? dio}) 
      : dio = dio ?? Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<List<TicketModel>> getTickets() async {
    try {
      final response = await dio.get(ApiConstants.ticketsEndpoint);
      final List<dynamic> data = response.data;
      return data.map((json) => TicketModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load tickets: $e');
    }
  }

  Future<TicketModel> getTicketById(int id) async {
    try {
      final response = await dio.get('${ApiConstants.ticketsEndpoint}/$id');
      return TicketModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load ticket: $e');
    }
  }

  Future<TicketModel> updateTicket(TicketModel ticket) async {
    try {
      final response = await dio.put(
        '${ApiConstants.ticketsEndpoint}/${ticket.id}',
        data: ticket.toJson(),
      );
      return TicketModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update ticket: $e');
    }
  }
}
