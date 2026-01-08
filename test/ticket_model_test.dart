import 'package:flutter_test/flutter_test.dart';
import 'package:ticket_app/features/tickets/data/models/ticket_model.dart';

void main() {
  group('TicketModel Tests', () {
    test('fromJson should create TicketModel from JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Ticket',
        'body': 'Test Description',
        'completed': true,
      };

      final ticketModel = TicketModel.fromJson(json);

      expect(ticketModel.id, 1);
      expect(ticketModel.title, 'Test Ticket');
      expect(ticketModel.description, 'Test Description');
      expect(ticketModel.isResolved, true);
    });

    test('toJson should convert TicketModel to JSON', () {
      const ticketModel = TicketModel(
        id: 1,
        title: 'Test Ticket',
        description: 'Test Description',
        isResolved: true,
      );

      final json = ticketModel.toJson();

      expect(json['id'], 1);
      expect(json['title'], 'Test Ticket');
      expect(json['body'], 'Test Description');
      expect(json['completed'], true);
    });

    test('fromJson should handle missing fields', () {
      final json = {
        'id': 1,
      };

      final ticketModel = TicketModel.fromJson(json);

      expect(ticketModel.id, 1);
      expect(ticketModel.title, '');
      expect(ticketModel.description, '');
      expect(ticketModel.isResolved, false);
    });
  });
}
