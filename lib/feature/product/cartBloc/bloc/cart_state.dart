import '../../../../services/bloc/cartPage/product_bloc.dart';

abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<Product> cartItem;
  CartSuccessState({required this.cartItem});
}

class CartProductItemRemoveState extends CartActionState {}
