import 'package:firebase_notification/feature/product/toDoBloc/todoBloc/todo_bloc.dart';
import 'package:firebase_notification/feature/product/toDoBloc/todoBloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todoBloc/todo_event.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TodoBloc _todoBloc = TodoBloc();
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _todoBloc.add(TodoInitEvent());
  }

  void _addTask() {
    if (_textEditingController.text.trim().isEmpty) {
      _todoBloc.add(TodoAddEvent(
        title: _textEditingController.text.trim(),
        id: 0,
        date: DateTime.now(),
      ));
      _textEditingController.clear();
      _focusNode.unfocus();
    } else {
      _showSnackBar('red', Colors.red);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoBloc.close();
    _textEditingController.dispose();
    _focusNode.dispose();
  }

  void _showSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blueGrey,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey,
        ),
      ),
      child: BlocConsumer<TodoBloc, TodoState>(
        bloc: _todoBloc,
        buildWhen: (previous, current) => current is! TodoActionState,
        listenWhen: (previous, current) => current is TodoActionState,
        listener: (context, state) {
          if (state is TodoSnackBarAddState) {
            _showSnackBar("Task added successfully", Colors.green);
          } else if (state is TodoSnackBarRemoveState) {
            _showSnackBar("Task removed", Colors.red);
          } else if (state is TodoSnackBarErrorState) {
            _showSnackBar("Task already exists", Colors.orange);
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('ToDo List',
                    style: TextStyle(color: Colors.black)),
                centerTitle: true,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: 'Add a new task...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.task),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            onSubmitted: (_) => _addTask(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: _buildTaskList(state),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _addTask,
                backgroundColor: Colors.white,
                child: const Icon(Icons.add),
              ));
        },
      ),
    );
  }

  Widget _buildTaskList(TodoState state) {
    if (state is TodoLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TodoSuccessState) {
      final tasks = state.toDoList;
      if (tasks.isEmpty) {
        return _buildEmptyState();
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return _buildTaskItem(task);
        },
      );
    }
    return const SizedBox();
  }

  Widget _buildTaskItem(task) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: const Icon(Icons.task_outlined, color: Colors.blueGrey),
        title: Text(
          task.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(task.date),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () => _todoBloc.add(TodoRemoveEvent(id: task.id)),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.assignment_outlined, size: 100, color: Colors.grey),
        const SizedBox(height: 24),
        Text(
          'No tasks yet!',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add your first task using the field above',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
