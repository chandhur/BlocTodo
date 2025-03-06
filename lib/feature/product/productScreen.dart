import 'package:firebase_notification/feature/product/bloc/product-bloc.dart';
import 'package:firebase_notification/feature/product/bloc/product-event.dart';
import 'package:firebase_notification/feature/product/cartScreen.dart';
import 'package:firebase_notification/feature/product/watchListScreen.dart';
import 'package:firebase_notification/services/bloc/cartPage/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product-state.dart';
import 'productTileWidget.dart';

class ProductScreenAnb extends StatefulWidget {
  const ProductScreenAnb({super.key});

  @override
  State<ProductScreenAnb> createState() => _ProductState();
}

class _ProductState extends State<ProductScreenAnb> {
  final ProductBloc _productBloc = ProductBloc();

  @override
  void initState() {
    super.initState();
    _productBloc.add(ProductInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      bloc: _productBloc,
      listenWhen: (context, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigationToWishListPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WatchListScreen()));
        } else if (state is HomeCartButtonToCartNavigateState) {
          Navigator.push(                         
              context, MaterialPageRoute(builder: (context) => const CartScreen()));
        } else if (state is HomeProductItemCartListButtonClickedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Item Added to Cart"),
            duration: Duration(seconds: 2),
          ));
        } else if (state is HomeProductItemWishListButtonClickedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Item Added to WishList"),
            duration: Duration(seconds: 2),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case productLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case productLoadSuccessState:
            final successState = state as productLoadSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Ecommerce"),
                actions: [
                  IconButton(
                      onPressed: () {
                        _productBloc.add(
                            HomeProductWhishButtonNavigationClickedEvent());
                      },
                      icon: const Icon(Icons.favorite)),
                  IconButton(
                      onPressed: () {
                        _productBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.category_outlined))
                ],
              ),
              body: ListView.builder(
                itemCount: state.product.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final productData = state.product[index];
                  return ProductTileWidget(
                      product: productData, productBloc: _productBloc);
                },
              ),
            );
          case ProductErrorState:
            return const Scaffold(
              body: Center(
                child: Text("HelloWorld"),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
