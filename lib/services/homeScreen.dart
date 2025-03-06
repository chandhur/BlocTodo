import 'package:firebase_notification/services/bloc/increment_bloc.dart';
import 'package:firebase_notification/services/bloc/increment_event.dart';
import 'package:firebase_notification/services/bloc/increment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<IncrementBloc, IncrementState>(builder: (context, state) {
      return SafeArea(
        child: Center(
            child: Column(children: [
          Text('Count : ${state.count}'),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<IncrementBloc>(context).add(AddEvent());
            },
            child: const Text("Plus"),
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<IncrementBloc>(context).add(MinEvent());
            },
            child: const Text("min"),
          ),
        //  const ProductScreen()
        ])),
      );
    }));
  }
}
