import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;

  const JobEntity({
    this.id,
    this.title,
    this.description,
  });

  @override
  List<Object?> get props => [id, title, description];
}
