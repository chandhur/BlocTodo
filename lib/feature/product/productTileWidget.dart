import 'package:flutter/material.dart';

import '../../services/bloc/cartPage/product_bloc.dart';
import 'bloc/product-bloc.dart';
import 'bloc/product-event.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductBloc productBloc;
  final Product product;
  const ProductTileWidget(
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
                    productBloc.add(HomeProductWhishListButtonClickedEvent(
                        product: product));
                  },
                  icon: const Icon(Icons.favorite)),
              IconButton(
                  onPressed: () {
                    productBloc.add(HomeProductWhishCartButtonClickedEvent(
                        product: product));
                  },
                  icon: const Icon(Icons.category_outlined))
            ],
          )
        ],
      ),
    );
  }
}
