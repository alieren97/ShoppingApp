import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/products_screen.dart';
import 'package:shopping_app/viewmodels/product_list_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffFEFDFD),
          appBarTheme: AppBarTheme(
            color: Color(0xffFEFDFD),
            elevation: 0,
            textTheme: const TextTheme(
              subtitle1: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ProductListViewModel(),
            )
          ],
          child: ProductsScreen(),
        ));
  }
}
