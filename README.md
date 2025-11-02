# Tugas 7

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

    Widget tree dalam Flutter adalah struktur hierarkis yang menggambarkan bagaimana widget-widget disusun dalam aplikasi. Ini mirip dengan pohon dimana setiap widget bisa memiliki widget anak (children) dan setiap widget (kecuali widget root) memiliki widget induk (parent).

    Hubungan parent-child bekerja dengan cara:
    - Parent widget mengontrol posisi dan constraint layout untuk child widgets
    - Properties dan behavior dari parent dapat mempengaruhi children
    - State dan data dapat diwariskan dari parent ke child melalui constructors
    - Children dapat mengakses data dan fungsi parent melalui BuildContext

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

    1. **MaterialApp**
    - Widget root yang menyediakan struktur dasar material design
    - Mengatur tema, routing, dan lokalisasi aplikasi

    2. **Scaffold**
    - Menyediakan struktur layout dasar material design
    - Mengatur AppBar, body, dan fitur material design lainnya

    3. **AppBar**
    - Menampilkan bar aplikasi di bagian atas
    - Berisi judul aplikasi "BolaBale Store"

    4. **Column & Row**
    - Column: Menyusun widget secara vertikal
    - Row: Menyusun widget secara horizontal
    - Digunakan untuk layout InfoCard dan konten

    5. **Container**
    - Memberikan padding dan styling
    - Mengatur ukuran dan dekorasi widget

    6. **Text**
    - Menampilkan teks seperti judul dan konten
    - Mengatur style teks seperti warna dan ukuran font

    7. **Card**
    - Menampilkan informasi dalam bentuk kartu material design
    - Digunakan dalam InfoCard untuk menampilkan NPM, Name, dan Class

    8. **GridView**
    - Menampilkan children dalam grid layout
    - Mengatur item produk dalam grid 3 kolom

    9. **Icon**
    - Menampilkan ikon untuk setiap item
    - Menggunakan Material Icons

    10. **InkWell**
        - Memberikan efek splash ketika ditekan
        - Menangani interaksi tap pada item

    11. **Material**
        - Memberikan efek visual material design
        - Mengatur warna background items


3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

    MaterialApp sering digunakan sebagai root widget karena:
    1. Menyediakan konfigurasi dasar yang diperlukan untuk aplikasi Material Design
    2. Mengatur tema global aplikasi (colors, typography, shapes)
    3. Menangani navigasi dan routing
    4. Menyediakan lokalisasi dan internationalization
    5. Mengatur behavior dasar aplikasi seperti navigasi back button
    6. Menjembatani aplikasi dengan sistem operasi

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

    ### StatelessWidget
    - Widget yang tidak memiliki state internal
    - Tidak dapat berubah setelah dibuat (immutable)
    - Rebuild hanya terjadi jika ada perubahan di parent widget
    - Cocok untuk UI yang statis atau bergantung sepenuhnya pada data external
    - Contoh penggunaan: InfoCard, ItemCard di aplikasi ini

    ### StatefulWidget
    - Widget yang memiliki state internal yang dapat berubah
    - Dapat melakukan rebuild ketika state berubah
    - Memiliki object State terpisah yang menyimpan data
    - Cocok untuk UI yang interaktif atau perlu update berkala
    - Contoh: Form input, animasi, atau countdown timer

    Pemilihan antara keduanya:
    - Gunakan StatelessWidget jika UI bersifat statis atau hanya bergantung pada data yang diberikan
    - Gunakan StatefulWidget jika UI perlu berubah secara dinamis atau menyimpan state internal

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

    BuildContext adalah:
    1. Handle ke lokasi widget dalam widget tree
    2. Memberikan akses ke data yang diwariskan dari widget parent
    3. Memungkinkan widget untuk berinteraksi dengan widget lain di tree

    Penggunaan dalam metode build:
    - Mengakses Theme: `Theme.of(context)`
    - Mengakses MediaQuery untuk responsive design: `MediaQuery.of(context)`
    - Menampilkan dialog/snackbar: `ScaffoldMessenger.of(context)`
    - Navigasi: `Navigator.of(context)`

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

    ### Hot Reload
    - Memperbarui UI dengan cepat tanpa kehilangan state
    - Hanya menginjeksi kode yang berubah
    - State aplikasi tetap terjaga
    - Cocok untuk experimental UI changes
    - Tidak me-reset state variables

    ### Hot Restart
    - Memulai ulang aplikasi dari awal
    - Me-reset semua state
    - Mengompilasi ulang seluruh aplikasi
    - Lebih lambat dari hot reload
    - Diperlukan ketika mengubah state initialization atau dependencies

    Kapan menggunakan masing-masing:
    - Hot Reload: Untuk perubahan UI atau logic yang tidak mempengaruhi state
    - Hot Restart: Ketika mengubah state initialization atau menambah dependencies baru

