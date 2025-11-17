import 'package:bolabalestore/screens/my_products_list.dart';
import 'package:bolabalestore/screens/products_entry_list.dart';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:bolabalestore/widgets/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'productslist_form.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Chevinka Queen Cilia Sidabutar";
  final String npm = "2406437376";
  final String kelas = "F";

  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.shopping_bag, AppTheme.purple600),
    ItemHomepage("My Products", Icons.inventory, AppTheme.purple700),
    ItemHomepage("Create Product", Icons.add_circle, AppTheme.purple600),
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final username = request.loggedIn
        ? ((request.jsonData['username'] as String?) ?? 'Player')
        : 'Guest';
    return Scaffold(
      appBar: AppBar(
        title: const Text('BolaBale Store'),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _HeroSection(username: username),
                    const SizedBox(height: 24),
                    _InfoChips(npm: npm, nama: nama, kelas: kelas),
                    const SizedBox(height: 24),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final double itemWidth = constraints.maxWidth > 720 ? 260 : 220;
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: items
                              .map(
                                (item) => SizedBox(
                                  width: itemWidth,
                                  child: ItemCard(item),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final String username;

  const _HeroSection({required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.glassCard,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, $username!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _InfoChips extends StatelessWidget {
  final String npm;
  final String nama;
  final String kelas;

  const _InfoChips({
    required this.npm,
    required this.nama,
    required this.kelas,
  });

  @override
  Widget build(BuildContext context) {
    final chips = [
      {'label': 'NPM', 'value': npm},
      {'label': 'Name', 'value': nama},
      {'label': 'Class', 'value': kelas},
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: chips
          .map(
            (chip) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: AppTheme.glassCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    chip['label']!,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    chip['value']!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          if (item.name == "Create Product") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductFormPage(),
              ),
            );
          } else if (item.name == "All Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductsEntryListPage(),
              ),
            );
          } else if (item.name == "My Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyProductsListPage(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Kamu menekan ${item.name}!")),
              );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                item.color,
                item.color.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadow1,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 32.0),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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
