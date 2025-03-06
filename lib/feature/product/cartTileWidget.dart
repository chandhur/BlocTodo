import 'package:firebase_notification/feature/product/cartBloc/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';

import '../../services/bloc/cartPage/product_bloc.dart';
import 'bloc/product-bloc.dart';
import 'bloc/product-event.dart';
import 'cartBloc/bloc/cart_event.dart';

class CartTileWidget extends StatelessWidget {
  final CartBloc productBloc;
  final Product product;
  const CartTileWidget(
      {super.key, required this.product, required this.productBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product.thumbnail ?? ""))),
          ),
          Text(product.title),
          Text('${product.price}'),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    productBloc.add(CartRemoveFromEvent(product: product));
                  },
                  icon: const Icon(Icons.remove_circle_outline_outlined)),
            ],
          )
        ],
      ),
    );
  }
}
