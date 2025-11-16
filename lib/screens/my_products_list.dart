import 'package:flutter/material.dart';
import 'package:bolabalestore/models/product.dart';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:bolabalestore/widgets/left_drawer.dart';
import 'package:bolabalestore/screens/products_detail.dart';
import 'package:bolabalestore/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyProductsListPage extends StatefulWidget {
  const MyProductsListPage({super.key});

  @override
  State<MyProductsListPage> createState() => _MyProductsListPageState();
}

class _MyProductsListPageState extends State<MyProductsListPage> {
  Future<void> _refreshProducts() async {
    setState(() {}); // Trigger rebuild untuk refresh data
  }

  Future<List<Product>> fetchMyProducts(CookieRequest request) async {
    // NOTE:
    // - Kalau pakai Chrome/web: http://localhost:8001/api/products/?filter=my
    // - Kalau pakai Android emulator: ganti ke http://10.0.2.2:8001/api/products/?filter=my
    // Menggunakan parameter filter=my untuk mendapatkan hanya produk milik user yang login
    final response = await request.get('http://localhost:8001/api/products/?filter=my');

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
        title: const Text('My Products'),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: FutureBuilder(
        future: fetchMyProducts(request),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'You haven\'t created any products yet.',
                style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
              ),
            );
          }

          // Grid layout seperti website
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
              showEditDelete: true, // Tampilkan tombol edit/delete untuk my products
              onTap: () {
                // Navigate to product detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      product: snapshot.data![index],
                      onProductUpdated: _refreshProducts,
                    ),
                  ),
                ).then((_) => _refreshProducts());
              },
            ),
          );
        },
        ),
      ),
    );
  }
}
