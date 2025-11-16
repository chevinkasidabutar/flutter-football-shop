import 'package:flutter/material.dart';
import 'package:bolabalestore/models/product.dart';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:bolabalestore/screens/productslist_form.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final VoidCallback? onProductUpdated;

  const ProductDetailPage({super.key, required this.product, this.onProductUpdated});

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '—';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}, '
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateStr;
    }
  }

  List<Widget> _buildColorDots(String? colorStr) {
    if (colorStr == null || colorStr.isEmpty) return [const Text('-')];
    final colors = colorStr.split(RegExp(r'[,;]+')).map((c) => c.trim()).where((c) => c.isNotEmpty).take(8).toList();
    if (colors.isEmpty) return [const Text('-')];
    return colors.map((color) {
      Color? parsedColor;
      try {
        if (color.startsWith('#')) {
          parsedColor = Color(int.parse(color.substring(1), radix: 16) + 0xFF000000);
        } else {
          final colorMap = {
            'black': Colors.black,
            'white': Colors.white,
            'red': Colors.red,
            'blue': Colors.blue,
            'green': Colors.green,
            'yellow': Colors.yellow,
            'orange': Colors.orange,
            'purple': Colors.purple,
          };
          parsedColor = colorMap[color.toLowerCase()] ?? Colors.grey;
        }
      } catch (e) {
        parsedColor = Colors.grey;
      }
      return Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: parsedColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = (product.thumbnail.isEmpty)
        ? null
        : 'http://localhost:8001/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Tombol Edit (jika user adalah owner)
          if (product.userId != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductFormPage(product: product),
                  ),
                );
                if (result == true && onProductUpdated != null) {
                  onProductUpdated!();
                }
              },
              tooltip: 'Edit Product',
            ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (sticky-like)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  _formatDate(product.createdAt),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textMuted,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '•',
                                  style: TextStyle(color: AppTheme.textMuted),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${product.views} views',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Body - Grid Layout (seperti website)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Jika lebar cukup, gunakan row (grid 2 kolom)
                      if (constraints.maxWidth > 600) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image (kiri)
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: imageUrl == null
                                      ? Container(
                                          height: 256,
                                          color: Colors.grey.shade100,
                                          child: const Center(
                                            child: Text('No Image', style: TextStyle(color: Colors.grey)),
                                          ),
                                        )
                                      : Image.network(
                                          imageUrl,
                                          height: 256,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            height: 256,
                                            color: Colors.grey.shade100,
                                            child: const Center(
                                              child: Text('No Image', style: TextStyle(color: Colors.grey)),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Info (kanan)
                            Expanded(
                              flex: 1,
                              child: _buildInfoColumn(context),
                            ),
                          ],
                        );
                      } else {
                        // Jika sempit, gunakan column (stacked)
                        return Column(
                          children: [
                            // Image (atas)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: imageUrl == null
                                    ? Container(
                                        height: 256,
                                        color: Colors.grey.shade100,
                                        child: const Center(
                                          child: Text('No Image', style: TextStyle(color: Colors.grey)),
                                        ),
                                      )
                                    : Image.network(
                                        imageUrl,
                                        height: 256,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          height: 256,
                                          color: Colors.grey.shade100,
                                          child: const Center(
                                            child: Text('No Image', style: TextStyle(color: Colors.grey)),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Info (bawah)
                            _buildInfoColumn(context),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category & Featured
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                product.category,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            if (product.isFeatured) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Featured',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.yellow.shade800,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        // Price
        Text(
          'Rp ${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.purple700,
          ),
        ),
        const SizedBox(height: 16),
        // Meta info (Size, Colors, Stock, Seller)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMetaRow(context, 'Size:', product.size.isEmpty ? '-' : product.size),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Colors: ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMuted,
                  ),
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _buildColorDots(product.color),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildMetaRow(context, 'Stock:', product.stock.toString()),
            const SizedBox(height: 8),
            _buildMetaRow(context, 'Seller:', product.userUsername ?? 'Anonymous'),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        // Description
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildMetaRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textMuted,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
