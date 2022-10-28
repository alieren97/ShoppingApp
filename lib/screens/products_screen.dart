import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/viewmodels/product_list_view_model.dart';
import 'package:shopping_app/viewmodels/product_view_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductListViewModel>(context, listen: false)
        .fetchingProducts();
  }

  Widget _buildList(ProductListViewModel vs) {
    switch (vs.loadingStatus) {
      case LoadingStatus.searching:
        return Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.completed:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: NewsGrid(
            products: vs.products,
          ),
        );
      case LoadingStatus.empty:
      default:
        return Center(
          child: Text("No results found"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var vs = Provider.of<ProductListViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 30),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 50),
              ),
            ),
            const Divider(
              height: 40,
              color: Color(0xffFF8A30),
              thickness: 8,
              indent: 30,
              endIndent: 20,
            ),
            Expanded(
              child: _buildList(vs),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsGrid extends StatelessWidget {
  final List<ProductViewModel> products;

  NewsGrid({required this.products});

  void _showNewsArticleDetails(BuildContext context, ProductViewModel vm) {
    // Navigator.push(context, MaterialPageRoute(builder: (_) {
    //   return NewsArticleDetailScreen(
    //     article: vm,
    //   );
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: this.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              (MediaQuery.of(context).orientation == Orientation.portrait)
                  ? 2
                  : 3),
      itemBuilder: (BuildContext _, int index) {
        final product = this.products[index];

        return GestureDetector(
          onTap: () {
            _showNewsArticleDetails(context, product);
          },
          child: GridTile(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: CircleImage(
                imageUrl: product.image,
              ),
            ),
            footer: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CircleImage extends StatelessWidget {
  final String imageUrl;

  const CircleImage({Key? key, required this.imageUrl}) : super(key: key);

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      placeholder: (context, url) {
        return Center(child: CircularProgressIndicator());
      },
      errorWidget: (context, url, error) {
        return _imageWidget(
          AssetImage(
            'assets/images/news.jpeg',
          ),
        );
      },
    );
  }
}
