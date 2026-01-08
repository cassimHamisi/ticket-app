import '../../domain/entities/ticket.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isResolved,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['body'] as String? ?? json['title'] as String? ?? '',
      isResolved: json['completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': description,
      'completed': isResolved,
    };
  }

  factory TicketModel.fromEntity(Ticket ticket) {
    return TicketModel(
      id: ticket.id,
      title: ticket.title,
      description: ticket.description,
      isResolved: ticket.isResolved,
    );
  }

  Ticket toEntity() {
    return Ticket(
      id: id,
      title: title,
      description: description,
      isResolved: isResolved,
    );
  }
}
