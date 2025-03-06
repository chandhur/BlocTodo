import 'dart:async';

import 'package:firebase_notification/feature/product/bloc/product-event.dart';
import 'package:firebase_notification/feature/product/bloc/product-state.dart';
import 'package:firebase_notification/feature/product/listItem/cartItem.list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/bloc/cartPage/product_bloc.dart';
import '../../../services/bloc/product/product.Service.dart';
import '../listItem/watchItem.list.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService = ProductService();
  ProductBloc() : super(ProductInitial()) {
    on<ProductInitialEvent>(fetchData);
    on<HomeProductWhishButtonNavigationClickedEvent>(homeProductNavigation);
    on<HomeCartButtonNavigateEvent>(cartNavigation);
    on<HomeProductWhishListButtonClickedEvent>(watchListNavigation);
    on<HomeProductWhishCartButtonClickedEvent>(cartProductNavigation);
  }

  FutureOr<void> fetchData(
      ProductInitialEvent event, Emitter<ProductState> emit) async {
    emit(productLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    List<Product> productData = await productService.getProduct();
    emit(productLoadSuccessState(product: productData));
  }

  FutureOr<void> homeProductNavigation(
      HomeProductWhishButtonNavigationClickedEvent event,
      Emitter<ProductState> emit) {
    emit(HomeNavigationToWishListPageActionState());
  }

  FutureOr<void> cartNavigation(
      HomeCartButtonNavigateEvent event, Emitter<ProductState> emit) {
    emit(HomeCartButtonToCartNavigateState());
  }

  FutureOr<void> watchListNavigation(
      HomeProductWhishListButtonClickedEvent event,
      Emitter<ProductState> emit) {
    watchListItem.add(event.product);
    emit(HomeProductItemWishListButtonClickedActionState());
  }

  FutureOr<void> cartProductNavigation(
      HomeProductWhishCartButtonClickedEvent event,
      Emitter<ProductState> emit) {
    cartItem.add(event.product);
    emit(HomeProductItemCartListButtonClickedActionState());
  }
}
