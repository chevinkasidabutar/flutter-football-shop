import 'dart:convert';
import 'package:bolabalestore/theme/app_theme.dart';
import 'package:bolabalestore/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product; // null untuk create, ada untuk edit

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _thumbnailController = TextEditingController();
  final _categoryController = TextEditingController();
  final _stockController = TextEditingController();
  final _colorController = TextEditingController();

  bool _isFeatured = false;
  String? _size;
  final List<String> _sizeOptions = ['', 'S', 'M', 'L', 'XL'];
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.product != null;
    if (_isEditMode && widget.product != null) {
      // Prefill form dengan data product yang akan di-edit
      final p = widget.product!;
      _nameController.text = p.name;
      _priceController.text = p.price.toString();
      _descriptionController.text = p.description;
      _thumbnailController.text = p.thumbnail;
      _categoryController.text = p.category;
      _stockController.text = p.stock.toString();
      _colorController.text = p.color;
      _isFeatured = p.isFeatured;
      _size = p.size.isEmpty ? '' : p.size;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    _categoryController.dispose();
    _stockController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? "Edit Product" : "Create Product"),
      ),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: AppTheme.glassCard,
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isEditMode ? "Edit Product" : "Create Product",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isEditMode ? "Update product information" : "Add new product",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  // Name
                  _buildFormField(
                    label: "Name",
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Product name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                  ),

                  // Price
                  _buildFormField(
                    label: "Price",
                    child: TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        hintText: "0",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Price is required";
                        }
                        if (int.tryParse(value) == null) {
                          return "Price must be a number";
                        }
                        return null;
                      },
                    ),
                  ),

                  // Description
                  _buildFormField(
                    label: "Description",
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: "Write a short description...",
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description is required";
                        }
                        return null;
                      },
                    ),
                  ),

                  // Thumbnail URL
                  _buildFormField(
                    label: "Thumbnail URL",
                    child: TextFormField(
                      controller: _thumbnailController,
                      decoration: const InputDecoration(
                        hintText: "https://example.com/image.jpg",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.url,
                    ),
                  ),

                  // Category
                  _buildFormField(
                    label: "Category",
                    child: TextFormField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        hintText: "e.g. Jersey, Boots, Accessory",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Category is required";
                        }
                        return null;
                      },
                    ),
                  ),

                  // Stock
                  _buildFormField(
                    label: "Stock",
                    child: TextFormField(
                      controller: _stockController,
                      decoration: const InputDecoration(
                        hintText: "0",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Stock is required";
                        }
                        if (int.tryParse(value) == null) {
                          return "Stock must be a number";
                        }
                        return null;
                      },
                    ),
                  ),

                  // Size & Color in Grid (seperti website)
                  Row(
                    children: [
                      Expanded(
                        child: _buildFormField(
                          label: "Size",
                          child: DropdownButtonFormField<String>(
                            value: _size,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: _sizeOptions.map((size) {
                              return DropdownMenuItem(
                                value: size,
                                child: Text(size.isEmpty ? "(None)" : size),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() => _size = value ?? ''),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFormField(
                          label: "Color(s)",
                          child: TextFormField(
                            controller: _colorController,
                            decoration: const InputDecoration(
                              hintText: "e.g black, red or #000000, #ff0000",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                    child: Text(
                      "Separate with comma/semicolon for multiple colors",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Featured Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _isFeatured,
                        onChanged: (value) {
                          setState(() {
                            _isFeatured = value ?? false;
                          });
                        },
                        activeColor: AppTheme.purple600,
                      ),
                      Text(
                        "Featured",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: AppTheme.textMuted),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final data = {
                                "name": _nameController.text.trim(),
                                "price": int.parse(_priceController.text),
                                "description": _descriptionController.text.trim(),
                                "thumbnail": _thumbnailController.text.trim(),
                                "category": _categoryController.text.trim(),
                                "is_featured": _isFeatured.toString(),
                                "stock": int.parse(_stockController.text),
                                "color": _colorController.text.trim(),
                                "size": _size ?? "",
                              };

                              Map<String, dynamic> response;
                              if (_isEditMode) {
                                // Edit mode - gunakan endpoint edit Flutter
                                response = await request.postJson(
                                  "http://localhost:8001/edit-flutter/${widget.product!.id}/",
                                  jsonEncode(data),
                                );
                              } else {
                                // Create mode
                                response = await request.postJson(
                                  "http://localhost:8001/create-flutter/",
                                  jsonEncode(data),
                                );
                              }

                              if (response['status'] == 'success' || response['status'] == 'updated') {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(_isEditMode
                                          ? "Product successfully updated!"
                                          : "Product successfully created!"),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pop(context, true); // Return true untuk trigger refresh
                                }
                              } else {
                                String message = response['message']?.toString() ?? "Failed to ${_isEditMode ? 'update' : 'create'} product";
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Error: ${e.toString()}"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.purple600,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(_isEditMode ? "Save Changes" : "Publish Product"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
