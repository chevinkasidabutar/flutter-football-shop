import 'dart:convert';

import 'package:bolabalestore/models/product.dart';
import 'package:bolabalestore/screens/products_detail.dart';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:bolabalestore/widgets/left_drawer.dart';
import 'package:bolabalestore/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsEntryListPage extends StatefulWidget {
  const ProductsEntryListPage({super.key});

  @override
  State<ProductsEntryListPage> createState() => _ProductsEntryListPageState();
}

class _ProductsEntryListPageState extends State<ProductsEntryListPage> {
  late Future<List<Product>> _productsFuture;
  String _activeCategory = 'all';

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('http://localhost:8001/api/products/');
    final response = await http.get(
      uri,
      headers: const {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    return data.map((d) => Product.fromJson(d as Map<String, dynamic>)).toList();
  }

  Future<void> _refresh() async {
    setState(() {
      _productsFuture = fetchProducts();
    });
    await _productsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: RefreshIndicator(
          color: AppTheme.purple600,
          onRefresh: _refresh,
          child: FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(
                      height: 320,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(24),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: AppTheme.glassCard,
                      child: Column(
                        children: [
                          const Icon(Icons.wifi_off, size: 40, color: AppTheme.purple600),
                          const SizedBox(height: 12),
                          Text(
                            'Failed to load products',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.error.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.inventory_2_outlined, size: 48, color: AppTheme.purple600),
                            const SizedBox(height: 12),
                            Text(
                              'There are no products in BolaBale Store yet.',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              final data = snapshot.data!;
              final categories = data
                  .map((product) => (product.category).trim())
                  .where((category) => category.isNotEmpty)
                  .toSet()
                  .toList()
                ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
              final filteredProducts = _activeCategory == 'all'
                  ? data
                  : data.where((product) => product.category.trim() == _activeCategory).toList();

              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: const Text('All Categories'),
                            selected: _activeCategory == 'all',
                            selectedColor: AppTheme.purple50,
                            side: const BorderSide(color: AppTheme.purple100),
                            onSelected: (_) => setState(() => _activeCategory = 'all'),
                            labelStyle: TextStyle(
                              color: _activeCategory == 'all' ? AppTheme.purple600 : AppTheme.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ...categories.map(
                          (category) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: _activeCategory == category,
                              selectedColor: AppTheme.purple50,
                              side: const BorderSide(color: AppTheme.purple100),
                              onSelected: (_) => setState(() => _activeCategory = category),
                              labelStyle: TextStyle(
                                color: _activeCategory == category ? AppTheme.purple600 : AppTheme.textMuted,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 900
                          ? 4
                          : MediaQuery.of(context).size.width > 600
                              ? 3
                              : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (_, index) => ProductCard(
                      product: filteredProducts[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              product: filteredProducts[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
