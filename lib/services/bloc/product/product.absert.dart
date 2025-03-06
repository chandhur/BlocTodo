import '../cartPage/product_bloc.dart';

abstract class ProductRepositry {

Future<List<Product>> getProduct();

}