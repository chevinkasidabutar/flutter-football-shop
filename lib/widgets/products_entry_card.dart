import 'package:flutter/material.dart';
import 'package:bolabalestore/models/products_entry.dart';

class ProductsEntryCard extends StatelessWidget {
  final ProductsEntry products;
  final VoidCallback onTap;

  const ProductsEntryCard({
    super.key,
    required this.products,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Biar gampang, ambil alias ke fields
    final data = products.fields;

    // NOTE:
    // - Kalau jalan di web ⇒ pakai localhost
    // - Kalau jalan di Android emulator ⇒ ganti ke 10.0.2.2
    final String? imageUrl = (data.thumbnail.isEmpty)
        ? null
        : 'http://localhost:8001/proxy-image/?url=${Uri.encodeComponent(data.thumbnail)}';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: imageUrl == null
                      ? Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        )
                      : Image.network(
                          imageUrl,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                ),
                const SizedBox(height: 8),

                // Name (judul produk)
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // Price
                Text(
                  'Rp ${data.price}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 6),

                // Category
                Text('Category: ${data.category}'),
                const SizedBox(height: 6),

                // Description preview
                Text(
                  data.description.length > 100
                      ? '${data.description.substring(0, 100)}...'
                      : data.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 6),

                // Featured indicator
                if (data.isFeatured)
                  const Text(
                    'Featured',
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
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
