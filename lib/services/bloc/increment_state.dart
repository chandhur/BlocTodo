import 'package:equatable/equatable.dart';
import 'package:firebase_notification/services/bloc/increment_event.dart';

class IncrementState extends Equatable {
  final int count;

  const IncrementState({this.count = 0});

  IncrementState copyWith(count) {
    return IncrementState(count: count ?? this.count);
  }

  @override
  List<Object> get props => [count];

  void add(AddEvent addEvent) {}
}
