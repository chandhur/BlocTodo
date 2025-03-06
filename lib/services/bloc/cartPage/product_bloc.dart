import 'package:firebase_notification/services/bloc/cartPage/product_event.dart';
import 'package:firebase_notification/services/bloc/cartPage/product_state.dart';
import 'package:firebase_notification/services/bloc/product/product.Service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../feature/product/bloc/product-state.dart';

class ProductBlocs extends Bloc<ProductEvent, ProductStates> {

  final ProductService productService = ProductService();
  ProductBlocs() : super(ProductInitials()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProductToCart>(_onAddProductToCart);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductStates> emit) async {
    try{
       List<Product> products = await productService.getProduct();
   
      emit(ProductLoaded(products: products, cart: []));
    }catch(e){
        print("Error loading products: $e");
      emit(ProductLoaded(products: [], cart: []));

    }
  }

  void _onAddProductToCart(AddProductToCart event, Emitter<ProductStates> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final updatedCart = List<Product>.from(currentState.cart)..add(event.product);
      emit(ProductLoaded(products: currentState.products, cart: updatedCart));
    }
  }
}

class Product {
  final String title;
  final double? price;
  final String? thumbnail;

  Product({
    required this.title,
     this.price,
     this.thumbnail,
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      thumbnail: json['imageUrl'],
    );
  }

  // Convert Product to JSON (useful for saving locally)
  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'price': price,
      'imageUrl': thumbnail,
    };
  }

  @override
   String toString() {
    return 'Product {name : $title, price : $price, imageUrl : $thumbnail}';
  }
}

