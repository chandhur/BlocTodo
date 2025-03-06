// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firebase_notification/feature/product/toDoBloc/todoBloc/todo_event.dart';
import 'package:firebase_notification/feature/product/toDoBloc/todoBloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final box = GetStorage();

  TodoBloc() : super(TodoInitial()) {
    on<TodoInitEvent>(toInit);
    on<TodoAddEvent>(toAddTask);
    on<TodoRemoveEvent>(toRemoveTask);
  }

  FutureOr<void> toInit(TodoInitEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    List<Task> tasks = _getTasks();
    emit(TodoSuccessState(toDoList: tasks));
  }

  FutureOr<void> toAddTask(TodoAddEvent event, Emitter<TodoState> emit) async {
    List<Task> tasks = _getTasks();
    tasks.add(Task(id: tasks.length + 1, title: event.title, date: event.date.toString()));
    box.write('tasks', jsonEncode(tasks));
    emit(TodoSuccessState(toDoList: tasks));
  }

  FutureOr<void> toRemoveTask(TodoRemoveEvent event, Emitter<TodoState> emit) async {
    List<Task> tasks = _getTasks();
    tasks.removeWhere((task) => task.id == event.id);
    box.write('tasks', jsonEncode(tasks));
    emit(TodoSuccessState(toDoList: tasks));
  }

  List<Task> _getTasks() {
    String? storedTasks = box.read('tasks');
    return storedTasks != null ? (jsonDecode(storedTasks) as List).map((e) => Task.fromJson(e)).toList() : [];
  }
}

class Task {
  int id;
  String title;
  String date;

  Task({required this.id, required this.title, required this.date});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
    };
  }

  @override
  String toString() => 'Task(id: $id, title: $title, date: $date)';
}

