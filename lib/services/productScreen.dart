import 'package:firebase_notification/services/bloc/cartPage/product_bloc.dart';
import 'package:firebase_notification/services/bloc/cartPage/product_event.dart';
import 'package:firebase_notification/services/bloc/cartPage/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductBlocs()..add(LoadProducts()),
        child: Scaffold(body: BlocBuilder<ProductBlocs, ProductStates>(
          builder: (context, state) {
            return SafeArea(
              child: state is ProductLoaded
                  ? ListView.builder(
                    shrinkWrap: true,
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ListTile(
                          title: Text(product.title),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Add"),
                          ),
                        );
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        )));
  }
}
