import 'package:firebase_notification/services/bloc/cartPage/product_bloc.dart';


abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class AddProductToCart extends ProductEvent {
  final Product product;
  
  AddProductToCart(this.product);
}