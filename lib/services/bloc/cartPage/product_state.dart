import 'package:firebase_notification/services/bloc/cartPage/product_bloc.dart';

abstract class ProductStates {}


class ProductInitials extends ProductStates {}

class ProductLoaded extends ProductStates {
  final List<Product> products;
  final List<Product> cart;
  
  ProductLoaded({required this.products, required this.cart});
}