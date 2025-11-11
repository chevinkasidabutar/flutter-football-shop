## Tugas 7

### 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

Widget tree dalam Flutter adalah struktur hierarkis yang menggambarkan bagaimana widget-widget disusun dalam aplikasi.  
Ini mirip dengan pohon, di mana setiap widget bisa memiliki widget anak (children) dan setiap widget (kecuali root) memiliki widget induk (parent).

Hubungan parent-child bekerja dengan cara:
- Parent widget mengontrol posisi dan layout untuk child widgets.
- Properti dan perilaku parent bisa memengaruhi children.
- Data dapat diwariskan dari parent ke child melalui constructor.
- Child bisa mengakses data dan fungsi parent melalui `BuildContext`.

---

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

1. **MaterialApp** – Widget root yang menyediakan struktur dasar Material Design dan mengatur tema aplikasi.  
2. **Scaffold** – Memberikan struktur halaman dasar (AppBar, body, Drawer).  
3. **AppBar** – Menampilkan judul aplikasi di bagian atas layar.  
4. **Column & Row** – Menyusun widget secara vertikal dan horizontal.  
5. **Container** – Memberikan padding, margin, dan dekorasi.  
6. **Text** – Menampilkan teks statis dan dinamis.  
7. **Card** – Menampilkan informasi dalam bentuk kartu.  
8. **GridView** – Menampilkan daftar item dalam grid layout 3 kolom.  
9. **Icon** – Menampilkan ikon dari library Material Icons.  
10. **InkWell** – Menambahkan efek saat elemen ditekan.  
11. **Material** – Menyediakan efek visual khas Material Design.  

---

### 3. Apa fungsi dari widget MaterialApp? Mengapa digunakan sebagai widget root?

**MaterialApp** digunakan sebagai root karena menyediakan konfigurasi dan komponen dasar Material Design.  
Widget ini mengatur:
- Tema global aplikasi
- Routing dan navigasi
- Lokalisasi dan behavior tombol back

Tanpa `MaterialApp`, widget seperti `Scaffold` atau `AppBar` tidak akan berfungsi dengan benar.

---

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan menggunakan masing-masing?

**StatelessWidget**
- Tidak memiliki state internal.
- Tidak berubah setelah dibuat (immutable).
- Cocok untuk tampilan statis seperti `InfoCard` atau `ItemCard`.

**StatefulWidget**
- Memiliki state internal yang dapat berubah.
- Rebuild setiap kali state berubah.
- Cocok untuk tampilan interaktif seperti form input.

Gunakan:
- `StatelessWidget` untuk UI statis.  
- `StatefulWidget` untuk UI yang butuh update dinamis (misal form, animasi, timer).

---

### 5. Apa itu BuildContext dan mengapa penting di Flutter?

`BuildContext` adalah objek yang merepresentasikan lokasi widget di dalam widget tree.  
Fungsinya:
- Mengakses data yang diwariskan dari parent widget.
- Mengambil tema global (`Theme.of(context)`).
- Menampilkan `SnackBar`, `Dialog`, atau navigasi ke halaman lain (`Navigator.of(context)`).

---

### 6. Jelaskan konsep "hot reload" di Flutter dan bedanya dengan "hot restart".

**Hot Reload**
- Memperbarui kode tanpa kehilangan state aplikasi.
- Cepat untuk perubahan UI.
- Tidak me-reset state.

**Hot Restart**
- Menjalankan ulang seluruh aplikasi.
- Me-reset semua state dan variabel.
- Diperlukan saat mengubah inisialisasi state atau dependencies.

---

## Tugas 8

### 1. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter.  
Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi *Football Shop* kamu?

- **`Navigator.push()`**  
  Menambahkan halaman baru di atas stack navigasi tanpa menghapus halaman sebelumnya.  
  Pengguna bisa menekan tombol **back** untuk kembali.  
  Cocok saat pengguna masih perlu kembali ke halaman asal.  

  **Contoh:** Saat membuka detail produk dari halaman utama.

- **`Navigator.pushReplacement()`**  
  Mengganti halaman saat ini dengan halaman baru dan menghapus halaman lama dari stack.  
  Pengguna tidak bisa kembali ke halaman sebelumnya.  
  Cocok untuk navigasi yang sifatnya permanen.  

  **Contoh:** Saat membuka halaman “Tambah Produk” dari Drawer atau card “Create Product”.

**Kesimpulan:**
- `Navigator.push()` → navigasi sementara.  
- `Navigator.pushReplacement()` → navigasi permanen.

---

### 2. Bagaimana kamu memanfaatkan hierarchy widget seperti `Scaffold`, `AppBar`, dan `Drawer`?

Ketiga widget ini digunakan untuk membuat struktur halaman yang konsisten di seluruh aplikasi.

- **`Scaffold`**  
  Memberikan layout dasar seperti AppBar, Drawer, dan body.

- **`AppBar`**  
  Menampilkan judul halaman agar pengguna tahu posisi mereka di aplikasi.

- **`Drawer`**  
  Berfungsi sebagai navigasi utama antar-halaman seperti “Halaman Utama” dan “Tambah Produk”.

Dengan struktur ini:
- Semua halaman terlihat seragam.
- Navigasi mudah dan cepat.
- Mengikuti prinsip *Material Design* untuk pengalaman pengguna yang baik.

---

### 3. Kelebihan menggunakan `Padding`, `SingleChildScrollView`, dan `ListView` dalam form.

- **`Padding`**  
  Memberikan jarak antar elemen agar tidak terlalu rapat.  
  *Contoh:* Setiap `TextFormField` pada halaman form memiliki padding 16px.

- **`SingleChildScrollView`**  
  Membuat halaman bisa di-*scroll* jika kontennya panjang.  
  *Contoh:* Digunakan di halaman *Tambah Produk Baru* agar tetap bisa digulir meskipun keyboard muncul.

- **`ListView`**  
  Menyusun daftar widget yang bisa di-*scroll*.  
  *Contoh:* Digunakan pada Drawer untuk menampung daftar menu.

Dengan ketiga widget ini, tampilan form menjadi responsif, mudah digunakan di layar kecil, dan tidak ada elemen yang tertutup keyboard.

---

### 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi memiliki identitas visual yang konsisten?

Aplikasi *BolaBale Store* menggunakan warna biru sebagai warna utama untuk menciptakan kesan profesional dan modern.  
Tema ini diatur melalui `ThemeData(primarySwatch: Colors.blue)` dalam `MaterialApp`.

**Contoh penerapan:**
```dart
return MaterialApp(
  title: 'BolaBale Store',
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  home: MyHomePage(),
);
