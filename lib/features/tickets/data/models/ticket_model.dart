import 'package:ticket_app/features/tickets/domain/entities/ticket.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
    super.isResolved = false,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body,
    'isResolved': isResolved,
  };

  Ticket toEntity() => Ticket(
    id: id,
    userId: userId,
    title: title,
    body: body,
    isResolved: isResolved,
  );
}
