import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool isResolved;

  const Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.isResolved,
  });

  @override
  List<Object?> get props => [id, title, description, isResolved];

  Ticket copyWith({
    int? id,
    String? title,
    String? description,
    bool? isResolved,
  }) {
    return Ticket(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isResolved: isResolved ?? this.isResolved,
    );
  }
}
