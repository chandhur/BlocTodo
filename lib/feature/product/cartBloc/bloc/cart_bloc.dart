import 'dart:async';

import 'package:firebase_notification/feature/product/cartBloc/bloc/cart_event.dart';
import 'package:firebase_notification/feature/product/cartBloc/bloc/cart_state.dart';
import 'package:firebase_notification/feature/product/cartScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../listItem/cartItem.list.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialData);
    on<CartRemoveFromEvent>(cartRemoveData);
  }

  FutureOr<void> cartInitialData(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItem: cartItem));
  }

  FutureOr<void> cartRemoveData(
      CartRemoveFromEvent event, Emitter<CartState> emit) async {
    cartItem.remove(event.product);
    emit(CartSuccessState(cartItem: cartItem));
    emit(CartProductItemRemoveState());
    await Future.delayed(const Duration(seconds: 3));
  }
}
