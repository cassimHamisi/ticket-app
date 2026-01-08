import 'package:flutter_test/flutter_test.dart';
import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';

void main() {
  group('Ticket Entity Tests', () {
    test('Ticket should be created with correct properties', () {
      const ticket = Ticket(
        id: 1,
        title: 'Test Ticket',
        description: 'Test Description',
        isResolved: false,
      );

      expect(ticket.id, 1);
      expect(ticket.title, 'Test Ticket');
      expect(ticket.description, 'Test Description');
      expect(ticket.isResolved, false);
    });

    test('Ticket copyWith should create new instance with updated properties', () {
      const ticket = Ticket(
        id: 1,
        title: 'Test Ticket',
        description: 'Test Description',
        isResolved: false,
      );

      final updatedTicket = ticket.copyWith(isResolved: true);

      expect(updatedTicket.id, 1);
      expect(updatedTicket.title, 'Test Ticket');
      expect(updatedTicket.description, 'Test Description');
      expect(updatedTicket.isResolved, true);
    });

    test('Tickets with same properties should be equal', () {
      const ticket1 = Ticket(
        id: 1,
        title: 'Test Ticket',
        description: 'Test Description',
        isResolved: false,
      );

      const ticket2 = Ticket(
        id: 1,
        title: 'Test Ticket',
        description: 'Test Description',
        isResolved: false,
      );

      expect(ticket1, ticket2);
    });
  });
}
