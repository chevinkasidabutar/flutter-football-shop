import 'package:flutter/material.dart';
import 'package:bolabalestore/models/product.dart';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:bolabalestore/widgets/left_drawer.dart';
import 'package:bolabalestore/screens/products_detail.dart';
import 'package:bolabalestore/screens/productslist_form.dart';
import 'package:bolabalestore/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyProductsListPage extends StatefulWidget {
  const MyProductsListPage({super.key});

  @override
  State<MyProductsListPage> createState() => _MyProductsListPageState();
}

class _MyProductsListPageState extends State<MyProductsListPage> {

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  List<Product> _sortProducts(List<Product> products) {
    final sorted = [...products];
    sorted.sort((a, b) {
      final aDate = _parseDate(a.createdAt) ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = _parseDate(b.createdAt) ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });
    return sorted;
  }

  Future<void> _handleRefresh(CookieRequest request) async {
    await fetchMyProducts(request);
    if (mounted) {
      setState(() {});
    }
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
    final Map<String, dynamic> userInfo = request.jsonData;
    final displayName = request.loggedIn
        ? (((userInfo['username'] as String?) ?? '').trim().isEmpty
            ? 'Player'
            : (userInfo['username'] as String))
        : 'Guest';
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                _HeaderSection(
                  greeting: _greeting(),
                  username: displayName,
                  onCreateProduct: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductFormPage(),
                      ),
                    ).then((value) {
                      if (value == true) {
                        setState(() {});
                      }
                    });
                  },
                  onRefresh: () => _handleRefresh(request),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: RefreshIndicator(
                    color: AppTheme.purple600,
                    onRefresh: () => _handleRefresh(request),
                    child: FutureBuilder<List<Product>>(
                      future: fetchMyProducts(request),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return _StateMessage(
                            title: 'Loading products',
                            message: 'Fetching your catalog...',
                            child: const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return _StateMessage(
                            title: 'Oops, failed to load',
                            message: 'Please check your connection then pull to refresh.',
                            child: OutlinedButton.icon(
                              onPressed: () => _handleRefresh(request),
                              icon: const Icon(Icons.refresh),
                              label: const Text('Try again'),
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return _StateMessage(
                            title: 'No products yet',
                            message: 'Be the first one to add a product to your shop.',
                            child: FilledButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProductFormPage(),
                                  ),
                                );
                              },
                              child: const Text('Create product'),
                            ),
                          );
                        }

                        final products = _sortProducts(snapshot.data!);
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final crossAxisCount = width > 1100
                                ? 4
                                : width > 800
                                    ? 3
                                    : 2;
                            return GridView.builder(
                              padding: const EdgeInsets.only(bottom: 24),
                              physics: const AlwaysScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.72,
                              ),
                              itemCount: products.length,
                              itemBuilder: (_, index) => ProductCard(
                                product: products[index],
                                showEditDelete: true,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailPage(
                                        product: products[index],
                                        onProductUpdated: () => _handleRefresh(request),
                                      ),
                                    ),
                                  ).then((_) => _handleRefresh(request));
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String greeting;
  final String username;
  final VoidCallback onCreateProduct;
  final VoidCallback onRefresh;

  const _HeaderSection({
    required this.greeting,
    required this.username,
    required this.onCreateProduct,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: AppTheme.glassCard,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greeting, ${username.isEmpty ? 'Player' : username}!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your next winning goal starts with the perfect gear.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: onCreateProduct,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Create product'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
              ),
              OutlinedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh list'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StateMessage extends StatelessWidget {
  final String title;
  final String message;
  final Widget child;

  const _StateMessage({
    required this.title,
    required this.message,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.glassCard,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                color: AppTheme.purple600,
                size: 40,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ],
    );
  }
}

