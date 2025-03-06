import 'package:firebase_notification/feature/product/cartBloc/bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cartBloc/bloc/cart_bloc.dart';
import 'cartBloc/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cartTileWidget.dart';
import 'productTileWidget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartBloc _cartBloc = CartBloc();
  @override
  void initState() {
    super.initState();
    _cartBloc.add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<CartBloc, CartState>(
          bloc: _cartBloc,
          listener: (context, state) {
            if (state is CartProductItemRemoveState) {
              print("Hello world");
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Item is remove")));
            }
          },
          listenWhen: (previous, current) => current is CartActionState,
          buildWhen: (previous, current) => current is! CartActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartSuccessState:
                final cartSuccessState = state as CartSuccessState;
                return ListView.builder(
                  itemCount: state.cartItem.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final productData = state.cartItem[index];
                    return CartTileWidget(
                        product: productData, productBloc: _cartBloc);
                  },
                );
              default:
                return const Scaffold(
                  body: Center(
                    child: Text("No Data"),
                  ),
                );
            }
          },
        ));
  }
}
