import 'dart:convert';

import 'package:firebase_notification/services/bloc/cartPage/product_bloc.dart';
import 'package:firebase_notification/services/bloc/product/product.absert.dart';
import 'package:http/http.dart' as http;

class ProductService implements ProductRepositry {
  @override
  Future<List<Product>> getProduct() async  {
  final response  = await http.get(Uri.parse('https://dummyjson.com/products'));
  final responseData = jsonDecode(response.body); 
    final List<dynamic> productsJson = responseData['products'];
    return productsJson.map((json) => Product.fromJson(json)).toList();
  }
}