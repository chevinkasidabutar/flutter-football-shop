import 'package:flutter/material.dart';
import 'package:bolabalestore/models/product.dart';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:bolabalestore/widgets/left_drawer.dart';
import 'package:bolabalestore/screens/products_detail.dart';
import 'package:bolabalestore/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductsEntryListPage extends StatefulWidget {
  const ProductsEntryListPage({super.key});

  @override
  State<ProductsEntryListPage> createState() => _ProductsEntryListPageState();
}

class _ProductsEntryListPageState extends State<ProductsEntryListPage> {
  Future<List<Product>> fetchProducts(CookieRequest request) async {
    // NOTE:
    // - Kalau pakai Chrome/web: http://localhost:8001/api/products/
    // - Kalau pakai Android emulator: ganti ke http://10.0.2.2:8001/api/products/
    final response = await request.get('http://localhost:8001/api/products/');

    var data = response;
    List<Product> listProducts = [];
    for (var d in data) {
      if (d != null) {
        listProducts.add(Product.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'There are no products in BolaBale Store yet.',
                style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
              ),
            );
          }

          // Grid layout seperti website (2 columns di mobile, 3-4 di tablet/desktop)
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ProductCard(
              product: snapshot.data![index],
              onTap: () {
                // Navigate to product detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      product: snapshot.data![index],
                    ),
                  ),
                );
              },
            ),
          );
        },
        ),
      ),
    );
  }
}
