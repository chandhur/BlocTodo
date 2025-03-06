import '../../../../services/bloc/cartPage/product_bloc.dart';

abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveFromEvent extends CartEvent {
  final Product product;
  CartRemoveFromEvent({required this.product});
}
