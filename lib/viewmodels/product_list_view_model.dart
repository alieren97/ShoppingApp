import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/services/web_service.dart';
import 'package:shopping_app/viewmodels/product_view_model.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class ProductListViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.searching;
  List<ProductViewModel> products = <ProductViewModel>[];

  void fetchingProducts() async {
    List<Product> newProducts = await WebService().fetchProducts();
    notifyListeners();

    this.products = newProducts
        .map((product) => ProductViewModel(product: product))
        .toList();

    if (this.products.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }
}
