abstract class TodoEvent {}

class TodoInitEvent extends TodoEvent {}

class TodoAddEvent extends TodoEvent {
  final String title;
  final int id;
  final DateTime date;
  TodoAddEvent({required this.id, required this.title, required this.date});
}

class TodoRemoveEvent extends TodoEvent {
  final int id;
  TodoRemoveEvent({
    required this.id,
  });
}

class SnackBarAddEvent extends TodoEvent {}

class SnackBarRemoveEvent extends TodoEvent {}
