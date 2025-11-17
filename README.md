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

### 2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
- `http` saya pakai untuk endpoint publik yang tidak butuh sesi, misalnya ketika memuat katalog umum di `ProductsEntryListPage` (`lib/screens/products_entry_list.dart`). Di sana saya cukup melakukan `http.get(...)`, meng-decode JSON, lalu merender kartu tanpa harus membawa state login pengguna.
- `CookieRequest` dari `pbp_django_auth` saya pakai untuk semua endpoint yang harus membawa sesi Django: login, register, mengambil produk milik user (`/api/products/?filter=my`), membuat/edit produk, serta delete di `lib/widgets/product_card.dart`. Objek ini otomatis menyimpan cookie, mengatur header CSRF, dan mengekspos status login lewat `request.loggedIn`.
Perbedaan peran: `http` = klien stateless untuk request sederhana; `CookieRequest` = lapisan di atas `http` yang menyertakan state otentikasi Django sehingga aman dipakai untuk aksi yang perlu identitas pengguna.

### 3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Saya membungkus seluruh aplikasi dengan `Provider<CookieRequest>` di `main.dart` supaya setiap layar menerima **instance yang sama**. Dengan begitu:
- Cookie sesi yang diberikan Django saat login tersimpan di satu objek sehingga semua request berikutnya otomatis terautentikasi.
- Status login (`request.loggedIn`, `request.jsonData`) konsisten di seluruh widget.
- Logout cukup dipanggil sekali di drawer dan seluruh aplikasi langsung mengetahui pengguna sudah keluar.
Jika setiap widget membuat `CookieRequest` baru, cookie tidak pernah tersalin sehingga backend menganggap pengguna belum login dan hampir semua request akan gagal 401/403.

### 4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
- **`10.0.2.2` di `ALLOWED_HOSTS`**: alamat ini adalah jembatan dari Android emulator ke `localhost` host machine. Tanpa entri ini Django akan menolak request karena dianggap berasal dari host ilegal.
- **CORS + SameSite/cookie**: Flutter web & Android mengakses API lewat origin berbeda, jadi Django perlu mengizinkan origin tersebut dan mengatur `SESSION_COOKIE_SAMESITE=None` agar cookie bisa dikirim lintas origin. Jika tidak, browser/emulator akan memblokir cookie dan login gagal.
- **Izin internet Android (`android/app/src/main/AndroidManifest.xml`)** memastikan aplikasi boleh melakukan request HTTP. Tanpa izin ini semua request akan langsung gagal dengan `Failed host lookup`.
Kesalahan konfigurasi di poin mana pun membuat Flutter tidak bisa menjangkau API (Network error), atau berhasil menjangkau tapi tidak menyimpan cookie sehingga login selalu dianggap gagal.

### 5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
1. Pengguna mengisi form `ProductFormPage` (`lib/screens/productslist_form.dart`). Setiap field tervalidasi terlebih dahulu.
2. Saat submit, data diserialisasi ke JSON dan dikirim melalui `request.postJson` ke Django (`/create-flutter/` untuk create atau `/edit-flutter/<id>/` untuk edit).
3. View Django mem-validasi, menyimpan ke database, lalu mengembalikan status `success/updated`.
4. Flutter menampilkan snackbar, menutup form, dan memicu refresh.
5. Halaman daftar memanggil endpoint JSON (`/api/products/` atau `/api/products/?filter=my`), mendapatkan array produk, lalu mengubahnya menjadi daftar `Product`.
6. `FutureBuilder`/`GridView` menampilkan kartu produk dengan data terbaru, persis seperti tampilan Django karena struktur datanya identik.

### 6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
1. **Register**: `RegisterPage` mengirim `username`, `password1`, `password2` melalui `CookieRequest.postJson` ke `/auth/register/`. Django melakukan validasi, membuat user, dan Flutter menampilkan snackbar sukses lalu mengarahkan kembali ke halaman login.
2. **Login**: `LoginPage` memanggil `request.login('/auth/login/')`. Jika kredensial benar, Django mengembalikan pesan + username, CookieRequest menyimpan cookie sesi, dan Flutter menavigasi ke `MyHomePage`.
3. **Akses setelah login**: semua layar menggunakan `context.watch<CookieRequest>()`. Selama `request.loggedIn == true`, mereka dapat memanggil endpoint terlindungi (misalnya delete produk lewat `request.postJson` di `widgets/product_card.dart`).
4. **Logout**: Drawer memanggil `request.logout('/auth/logout/')`, Django menghapus cookie, Flutter menampilkan snackbar dan mengarahkan ke `LoginPage`.
Seluruh siklus meniru mekanisme Django karena CookieRequest membawa cookie & CSRF token yang sama seperti ketika mengakses situs webnya.

### 7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
1. **Menyiapkan autentikasi di Django**  
   - Menyediakan endpoint login, register, dan logout di `football-shop/authentication` lalu mengeksposnya sebagai API yang mengembalikan cookie sesi (setara token) ketika kredensial valid.  
   - Mengaktifkan CORS dan mengatur `ALLOWED_HOSTS`/`CSRF_TRUSTED_ORIGINS` agar permintaan dari Flutter (localhost/10.0.2.2) diterima.  
   - Mengetes setiap endpoint menggunakan Postman sebelum dihubungkan ke Flutter untuk memastikan alur login–register–logout sudah berfungsi.

2. **Menyiapkan Provider di Flutter**  
   - Membungkus `MaterialApp` dengan `Provider<CookieRequest>` di `main.dart` sehingga seluruh widget dapat mengakses status autentikasi dan cookie sesi yang sama.  
   - Membuat `AppTheme` yang meniru Tailwind CSS pada proyek Django supaya pengalaman visual di Flutter konsisten dengan versi web.

3. **Menyamakan layout daftar produk**  
   - Menulis ulang `ProductCard`, `MyProductsListPage`, dan dekorasi `AppTheme.glassCard` agar grid, typography, dan efek glassmorphism sama dengan `main.html` + `global.css`.  
   - Menambahkan elemen khas seperti hero text, chip filter (untuk versi publik), serta background gradient sehingga halaman Flutter benar-benar menyerupai landing page Django.

4. **Membuat model & service untuk produk**  
   - Menggenerate kelas `Product` (lengkap dengan `fromJson`/`toJson`) agar data dari `/api/products/` bisa dipetakan ke objek bertipe kuat.  
   - Menyusun fungsi fetch berbasis `http` (untuk katalog publik) dan `CookieRequest` (untuk katalog pribadi) supaya komunikasi dengan backend terorganisir.

5. **Integrasi form create/edit produk**  
   - Membangun `ProductFormPage` dengan validator, dropdown ukuran, checkbox featured, serta field warna/thumbnail.  
   - Menghubungkan form ke endpoint Django `/create-flutter/` dan `/edit-flutter/<id>/` lewat `CookieRequest.postJson`, lalu menampilkan snackbar + refresh setelah server mengembalikan status sukses.

6. **Menambahkan aksi detail, edit, dan delete pada produk**  
   - Halaman “My Products” menampilkan tombol Edit/Delete di setiap kartu; aksi ini memanggil endpoint Django yang sesuai (edit-flutter & delete REST) menggunakan cookie sesi yang sudah tersimpan.  
   - `ProductDetailPage` digunakan ulang untuk melihat detail, dan callback `onProductUpdated` memastikan daftar otomatis memuat ulang setelah perubahan.

7. **Membedakan konsumsi API publik vs privat**  
   - `All Products` memakai package `http` biasa karena tidak memerlukan autentikasi.  
   - `My Products`, create/edit, dan delete menggunakan `CookieRequest` agar cookie/CSRF dikirim otomatis, sehingga pengguna hanya dapat mengelola produk miliknya sendiri.

8. **Konfigurasi konektivitas Flutter ↔ Django**  
   - Menyetel `ALLOWED_HOSTS`, `CORS_ALLOW_ALL_ORIGINS`, serta pengaturan cookie SameSite di Django.  
   - Menggunakan `http://10.0.2.2:8001` ketika mengetes lewat Android emulator dan `http://localhost:8001` ketika via Chrome/desktop.  
   - Menambahkan izin internet pada `AndroidManifest.xml` supaya aplikasi Flutter bisa melakukan request ke server lokal maupun deployment.
