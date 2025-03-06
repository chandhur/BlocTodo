import 'package:firebase_notification/services/bloc/cartPage/product_bloc.dart';
import 'package:firebase_notification/services/bloc/increment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBloc {
  static final incrementDecrementBloc = IncrementBloc();
  static final productState = ProductBlocs();

  static final List<BlocProvider> blocProvider = [
    BlocProvider<IncrementBloc>(
      create: (context) => incrementDecrementBloc,
    ),
    BlocProvider<ProductBlocs>(create: (context) => productState),
  ];

  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }
  CommonBloc._internal();
}
