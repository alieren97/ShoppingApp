import 'package:dio/dio.dart';
import 'package:shopping_app/models/product.dart';

class WebService {
  var dio = Dio();

  Future<List<Product>> fetchProducts() async {
    String productUrl = "https://fakestoreapi.com/products";

    final response = await dio.get(productUrl);
    if (response.statusCode == 200) {
      final result = response.data;
      print(result);
      Iterable list = result;
      print(list);
      return list.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception("Failled to get top news");
    }
  }
}
