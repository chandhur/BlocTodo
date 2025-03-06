// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../services/bloc/cartPage/product_bloc.dart';

abstract class ProductEvent {}

class ProductInitialEvent extends ProductEvent {}

class HomeProductWhishListButtonClickedEvent extends ProductEvent {
  final Product product;
  HomeProductWhishListButtonClickedEvent({
    required this.product,
  });
}

class HomeProductWhishCartButtonClickedEvent extends ProductEvent {
   final Product product;
  HomeProductWhishCartButtonClickedEvent({
    required this.product,
  });
   
}

class HomeProductWhishButtonNavigationClickedEvent extends ProductEvent {}

class HomeCartButtonNavigateEvent extends ProductEvent {}
