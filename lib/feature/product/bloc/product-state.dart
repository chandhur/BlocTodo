import 'package:firebase_notification/services/bloc/cartPage/product_bloc.dart';

abstract class ProductState {} // <--- This is the abstract class

abstract class HomeActionState extends ProductState {} // action state for home action

class ProductInitial extends ProductState {}

// in ui state  

class productLoadingState extends ProductState {}

class productLoadSuccessState extends ProductState {
  final List<Product> product;
  productLoadSuccessState({required this.product});
}

class ProductErrorState extends ProductState {}


// in action state 

class HomeNavigationToWishListPageActionState extends HomeActionState {}
class HomeCartButtonToCartNavigateState extends HomeActionState {}

class HomeProductItemWishListButtonClickedActionState extends HomeActionState {}
class HomeProductItemCartListButtonClickedActionState extends HomeActionState {}

