import 'package:shopping_app/models/product.dart';

class ProductViewModel {
  final Product _product;

  ProductViewModel({required Product product}) : _product = product;

  int get id {
    return _product.id;
  }

  String get title {
    return _product.title;
  }

  num get price {
    return _product.price;
  }

  String get description {
    return _product.description;
  }

  String get category {
    return _product.category;
  }

  String get image {
    return _product.image;
  }
}
