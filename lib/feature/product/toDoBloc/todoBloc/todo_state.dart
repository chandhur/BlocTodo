import 'package:firebase_notification/feature/product/toDoBloc/todoBloc/todo_bloc.dart';

abstract class TodoState {}

abstract class TodoActionState extends TodoState {}

class TodoInitial extends TodoState {}

class TodoSuccessState extends TodoState {
  List<Task> toDoList;
  TodoSuccessState({
    required this.toDoList,
  });

  TodoSuccessState copyWith(toDoList) {
    return TodoSuccessState(
      toDoList: toDoList ?? this.toDoList,
    );
  }
}

class TodoLoadingState extends TodoState {}

class TodoSnackBarAddState extends TodoActionState {}

class TodoSnackBarRemoveState extends TodoActionState {}

class TodoSnackBarErrorState extends TodoActionState {}
