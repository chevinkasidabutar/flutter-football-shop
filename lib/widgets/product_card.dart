import 'package:flutter/material.dart';
import 'package:bolabalestore/models/product.dart';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:bolabalestore/screens/productslist_form.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final bool showEditDelete; // untuk menampilkan tombol edit/delete jika user adalah owner

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.showEditDelete = false,
  });

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  List<Widget> _buildColorDots(String? colorStr) {
    if (colorStr == null || colorStr.isEmpty) return [];
    final colors = colorStr.split(RegExp(r'[,;]+')).map((c) => c.trim()).where((c) => c.isNotEmpty).take(6).toList();
    return colors.map((color) {
      Color? parsedColor;
      try {
        if (color.startsWith('#')) {
          parsedColor = Color(int.parse(color.substring(1), radix: 16) + 0xFF000000);
        } else {
          // Try to parse named colors
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
        width: 14,
        height: 14,
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.purple100, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: imageUrl == null
                    ? Container(
                        height: 192,
                        width: double.infinity,
                        color: Colors.grey.shade100,
                        child: const Center(
                          child: Text('No Image', style: TextStyle(color: Colors.grey)),
                        ),
                      )
                    : Image.network(
                        imageUrl,
                        height: 192,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 192,
                          color: Colors.grey.shade100,
                          child: const Center(
                            child: Text('No Image', style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Description
                          Text(
                            product.description.length > 240
                                ? '${product.description.substring(0, 240)}...'
                                : product.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textMuted,
                              fontSize: 14,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          // Size badge & Color dots & Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (product.size.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        product.size,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  if (product.size.isNotEmpty && product.color.isNotEmpty)
                                    const SizedBox(width: 8),
                                  if (product.color.isNotEmpty)
                                    ..._buildColorDots(product.color),
                                ],
                              ),
                              Text(
                                _formatDate(product.createdAt),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Edit/Delete buttons (jika showEditDelete = true)
                      if (showEditDelete)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductFormPage(product: product),
                                    ),
                                  ).then((refreshed) {
                                    if (refreshed == true) {
                                      // Trigger refresh jika perlu
                                      Navigator.of(context).pop(true);
                                    }
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text('Edit', style: TextStyle(fontSize: 12)),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () async {
                                  // Konfirmasi delete
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Product'),
                                      content: Text('Are you sure you want to delete "${product.name}"?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, true),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirmed == true) {
                                    final request = Provider.of<CookieRequest>(context, listen: false);
                                    try {
                                      final response = await request.postJson(
                                        "http://localhost:8001/api/products/${product.id}/delete/",
                                        jsonEncode({}),
                                      );

                                      if (response['status'] == 'deleted') {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Product deleted successfully'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          Navigator.of(context).pop(true); // Trigger refresh
                                        }
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Error: ${e.toString()}'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  side: const BorderSide(color: Colors.red),
                                ),
                                child: const Text('Delete', style: TextStyle(fontSize: 12, color: Colors.red)),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
