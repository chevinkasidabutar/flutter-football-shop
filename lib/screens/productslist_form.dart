import 'package:flutter/material.dart';
import '../widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  String _description = "";
  String? _thumbnail;
  String _category = "";
  bool _isFeatured = false;
  int _stock = 0;
  String? _color;
  String? _size; // 🔹 tambahkan variabel size

  final List<String> _sizeOptions = ['S', 'M', 'L', 'XL', 'tidak ada']; // 🔹 pilihan ukuran

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk Baru"),
        backgroundColor: Colors.blue,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 NAMA PRODUK
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nama Produk",
                  hintText: "Masukkan nama produk",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama produk tidak boleh kosong!";
                  }
                  if (value.length < 3) {
                    return "Nama produk minimal 3 karakter!";
                  }
                  if (value.length > 100) {
                    return "Nama produk maksimal 100 karakter!";
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 16),

              // 🔹 HARGA
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Harga (Rp)",
                  hintText: "Masukkan harga produk",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return "Harga harus berupa angka!";
                  }
                  if (number < 0) {
                    return "Harga tidak boleh negatif!";
                  }
                  return null;
                },
                onSaved: (value) => _price = int.parse(value!),
              ),
              const SizedBox(height: 16),

              // 🔹 STOK
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Stok Produk",
                  hintText: "Masukkan jumlah stok produk",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Stok tidak boleh kosong!";
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return "Stok harus berupa angka!";
                  }
                  if (number < 0) {
                    return "Stok tidak boleh negatif!";
                  }
                  return null;
                },
                onSaved: (value) => _stock = int.parse(value!),
              ),
              const SizedBox(height: 16),

              // 🔹 DESKRIPSI
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Deskripsi Produk",
                  hintText: "Masukkan deskripsi produk",
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  if (value.length < 10) {
                    return "Deskripsi minimal 10 karakter!";
                  }
                  if (value.length > 500) {
                    return "Deskripsi terlalu panjang (maks 500 karakter)!";
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 16),

              // 🔹 KATEGORI
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Kategori Produk",
                  hintText: "Masukkan kategori produk",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Kategori tidak boleh kosong!";
                  }
                  if (value.length > 50) {
                    return "Kategori maksimal 50 karakter!";
                  }
                  return null;
                },
                onSaved: (value) => _category = value!,
              ),
              const SizedBox(height: 16),

              // 🔹 THUMBNAIL
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "URL Thumbnail (opsional)",
                  hintText: "Masukkan link gambar produk (http/https)",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return null; // boleh kosong
                  final urlPattern =
                      r'^(http|https):\/\/([\w\-]+(\.[\w\-]+)+)([\w\-,@?^=%&:/~+#]*[\w\-,@?^=%&/~+#])?$';
                  if (!RegExp(urlPattern).hasMatch(value)) {
                    return "Masukkan URL yang valid (http/https)!";
                  }
                  return null;
                },
                onSaved: (value) => _thumbnail = value,
              ),
              const SizedBox(height: 16),

              // 🔹 WARNA
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Warna Produk (opsional)",
                  hintText: "Masukkan warna produk",
                ),
                validator: (value) {
                  if (value != null && value.length > 30) {
                    return "Nama warna maksimal 30 karakter!";
                  }
                  return null;
                },
                onSaved: (value) => _color = value,
              ),
              const SizedBox(height: 16),

              // 🔹 SIZE DROPDOWN
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Ukuran Produk",
                ),
                items: _sizeOptions
                    .map((size) =>
                        DropdownMenuItem(value: size, child: Text(size)))
                    .toList(),
                value: _size,
                onChanged: (value) {
                  setState(() {
                    _size = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Pilih ukuran produk!" : null,
                onSaved: (value) => _size = value,
              ),
              const SizedBox(height: 16),

              // 🔹 FEATURED SWITCH
              SwitchListTile(
                title: const Text("Produk Unggulan (Featured)"),
                value: _isFeatured,
                onChanged: (bool value) {
                  setState(() {
                    _isFeatured = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              // 🔹 TOMBOL SAVE
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Produk Berhasil Ditambahkan "),
                          content: Text(
                            "Nama: $_name\n"
                            "Harga: $_price\n"
                            "Deskripsi: $_description\n"
                            "Kategori: $_category\n"
                            "Thumbnail: ${_thumbnail ?? '-'}\n"
                            "Warna: ${_color ?? '-'}\n"
                            "Ukuran: ${_size ?? '-'}\n"
                            "Stok: $_stock\n"
                            "Featured: ${_isFeatured ? 'Ya' : 'Tidak'}",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Tutup dialog
                                setState(() {
                                  // 🔹 Reset semua nilai variabel ke default
                                  _formKey.currentState!.reset();
                                  _isFeatured = false;
                                  _size = null;
                                });
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );

                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
