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

---

## Tugas 9

### 1. Mengapa perlu membuat model Dart saat bekerja dengan JSON?
Model `Product` di `lib/models/product.dart` memaksa setiap field memiliki tipe yang jelas (`int id`, `String name`, dll) dan menyediakan `fromJson`/`toJson`. Dengan model:
- **Validasi tipe & null-safety** berlangsung otomatis karena parsing akan melempar error jika tipe tidak sesuai dan setiap field diberi default yang aman (`thumbnail ?? ''`, `stock ?? 0`).
- **Maintainability** meningkat; perubahan skema backend cukup dilakukan di satu kelas sehingga semua widget yang memakai `Product` ikut diperbarui melalui compiler error.
- **Readability & tooling** lebih baik berkat autocompletion dan dokumentasi terpusat.
Jika hanya memakai `Map<String, dynamic>`, kita rentan salah ketik key, lupa konversi tipe, atau tidak menyadari field null sehingga mudah muncul bug runtime yang sulit dilacak.

### 2. Fungsi package `http` vs `CookieRequest`
- `http` saya pakai untuk endpoint publik yang tidak butuh sesi, misalnya ketika memuat katalog umum di `ProductsEntryListPage` (`lib/screens/products_entry_list.dart`). Di sana saya cukup melakukan `http.get(...)`, meng-decode JSON, lalu merender kartu tanpa harus membawa state login pengguna.
- `CookieRequest` dari `pbp_django_auth` saya pakai untuk semua endpoint yang harus membawa sesi Django: login, register, mengambil produk milik user (`/api/products/?filter=my`), membuat/edit produk, serta delete di `lib/widgets/product_card.dart`. Objek ini otomatis menyimpan cookie, mengatur header CSRF, dan mengekspos status login lewat `request.loggedIn`.
Perbedaan peran: `http` = klien stateless untuk request sederhana; `CookieRequest` = lapisan di atas `http` yang menyertakan state otentikasi Django sehingga aman dipakai untuk aksi yang perlu identitas pengguna.

### 3. Mengapa instance `CookieRequest` harus dibagikan?
Saya membungkus seluruh aplikasi dengan `Provider<CookieRequest>` di `main.dart` supaya setiap layar menerima **instance yang sama**. Dengan begitu:
- Cookie sesi yang diberikan Django saat login tersimpan di satu objek sehingga semua request berikutnya otomatis terautentikasi.
- Status login (`request.loggedIn`, `request.jsonData`) konsisten di seluruh widget.
- Logout cukup dipanggil sekali di drawer dan seluruh aplikasi langsung mengetahui pengguna sudah keluar.
Jika setiap widget membuat `CookieRequest` baru, cookie tidak pernah tersalin sehingga backend menganggap pengguna belum login dan hampir semua request akan gagal 401/403.

### 4. Konfigurasi konektivitas Flutter ↔ Django
- **`10.0.2.2` di `ALLOWED_HOSTS`**: alamat ini adalah jembatan dari Android emulator ke `localhost` host machine. Tanpa entri ini Django akan menolak request karena dianggap berasal dari host ilegal.
- **CORS + SameSite/cookie**: Flutter web & Android mengakses API lewat origin berbeda, jadi Django perlu mengizinkan origin tersebut dan mengatur `SESSION_COOKIE_SAMESITE=None` agar cookie bisa dikirim lintas origin. Jika tidak, browser/emulator akan memblokir cookie dan login gagal.
- **Izin internet Android (`android/app/src/main/AndroidManifest.xml`)** memastikan aplikasi boleh melakukan request HTTP. Tanpa izin ini semua request akan langsung gagal dengan `Failed host lookup`.
Kesalahan konfigurasi di poin mana pun membuat Flutter tidak bisa menjangkau API (Network error), atau berhasil menjangkau tapi tidak menyimpan cookie sehingga login selalu dianggap gagal.

### 5. Mekanisme pengiriman data sampai tampil di Flutter
1. Pengguna mengisi form `ProductFormPage` (`lib/screens/productslist_form.dart`). Setiap field tervalidasi terlebih dahulu.
2. Saat submit, data diserialisasi ke JSON dan dikirim melalui `request.postJson` ke Django (`/create-flutter/` untuk create atau `/edit-flutter/<id>/` untuk edit).
3. View Django mem-validasi, menyimpan ke database, lalu mengembalikan status `success/updated`.
4. Flutter menampilkan snackbar, menutup form, dan memicu refresh.
5. Halaman daftar memanggil endpoint JSON (`/api/products/` atau `/api/products/?filter=my`), mendapatkan array produk, lalu mengubahnya menjadi daftar `Product`.
6. `FutureBuilder`/`GridView` menampilkan kartu produk dengan data terbaru, persis seperti tampilan Django karena struktur datanya identik.

### 6. Mekanisme autentikasi (login, register, logout)
1. **Register**: `RegisterPage` mengirim `username`, `password1`, `password2` melalui `CookieRequest.postJson` ke `/auth/register/`. Django melakukan validasi, membuat user, dan Flutter menampilkan snackbar sukses lalu mengarahkan kembali ke halaman login.
2. **Login**: `LoginPage` memanggil `request.login('/auth/login/')`. Jika kredensial benar, Django mengembalikan pesan + username, CookieRequest menyimpan cookie sesi, dan Flutter menavigasi ke `MyHomePage`.
3. **Akses setelah login**: semua layar menggunakan `context.watch<CookieRequest>()`. Selama `request.loggedIn == true`, mereka dapat memanggil endpoint terlindungi (misalnya delete produk lewat `request.postJson` di `widgets/product_card.dart`).
4. **Logout**: Drawer memanggil `request.logout('/auth/logout/')`, Django menghapus cookie, Flutter menampilkan snackbar dan mengarahkan ke `LoginPage`.
Seluruh siklus meniru mekanisme Django karena CookieRequest membawa cookie & CSRF token yang sama seperti ketika mengakses situs webnya.

### 7. Implementasi checklist secara step-by-step
1. **Menyiapkan tema & provider**: membuat `AppTheme` (warna sama seperti Tailwind di proyek Django) lalu menerapkannya di `main.dart` bersamaan dengan `Provider<CookieRequest>` agar state auth global tersedia.
2. **Menyamakan layout daftar produk**: menulis ulang `ProductCard`, `MyProductsListPage`, dan `AppTheme.glassCard` supaya pola grid, hero text, dan glass effect mengikuti `main.html` + `global.css` Django (termasuk background “floating blobs” dan chip filter).
3. **Membuat model & service**: mengenerate `Product` lengkap dengan `fromJson`/`toJson`, lalu memakainya di semua layar agar JSON ↔ Dart konsisten.
4. **Integrasi form create/edit**: membangun `ProductFormPage` dengan validator, dropdown size, checkbox featured, lalu menyambungkannya ke endpoint Django `/create-flutter/` dan `/edit-flutter/<id>/`.
5. **Menambahkan aksi detail, edit, delete**: pada `ProductCard` saya menambahkan tombol edit/delete yang hanya muncul di halaman “My Products” dan memanggil endpoint Django yang relevan memakai `CookieRequest`.
6. **Membedakan konsumsi API publik vs privat**: halaman “All Products” menggunakan package `http` (tanpa sesi) sedangkan “My Products” memakai `CookieRequest` agar cocok dengan behavior situs Django.
7. **Konfigurasi konektivitas**: memperbarui `settings.py` (CORS, `ALLOWED_HOSTS`, same-site cookie), menambahkan izin internet Android, dan memastikan URL `localhost` vs `10.0.2.2` terdokumentasi pada komentar kode sehingga aplikasi Flutter mampu berbagi backend yang sama dengan versi Django.
