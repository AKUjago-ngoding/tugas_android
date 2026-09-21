import 'package:flutter/material.dart';
import '../core/models/module_item.dart';

// Import all Tugas
import '../features/tugas/tugas_01_biodata/tugas_01_widget.dart';
import '../features/tugas/tugas_01_biodata/tugas_01_console.dart';
import '../features/tugas/tugas_02_layout_toko/tugas_02_widget.dart';
import '../features/tugas/tugas_02_layout_toko/tugas_02_logic.dart';
import '../features/tugas/tugas_03_laporan_udara/tugas_03_widget.dart';
import '../features/tugas/tugas_03_laporan_udara/tugas_03_looping.dart';
import '../features/tugas/tugas_04_registrasi_grid/tugas_04_widget.dart';
import '../features/tugas/tugas_04_registrasi_grid/tugas_04_revisi.dart';
import '../features/tugas/tugas_05_interaksi_event/tugas_05_interaksi.dart';
import '../features/tugas/tugas_05_interaksi_event/tugas_05_form_input.dart';
import '../features/tugas/tugas_07_custom_drawer/tugas_07_drawer.dart';
import '../features/tugas/tugas_08_navigation/tugas_08_bottom_nav.dart';
import '../features/tugas/tugas_09_listview_model/tugas_09_hub.dart';
import '../features/tugas/tugas_10_form_validation/tugas_10_form.dart';
import '../features/tugas/tugas_11_session_auth/tugas_11_auth_hub.dart';
import '../features/tugas/tugas_12dan13_local_storage/tugas_12dan13_hub.dart';

// Import all Latihan
import '../features/latihan/lat_01_article_ui/lat_article_screen.dart';
import '../features/latihan/lat_02_navigation_drawer/lat_drawer_screen.dart';
import '../features/latihan/lat_02_navigation_drawer/lat_bottom_nav_screen.dart';
import '../features/latihan/lat_03_auth_ui/lat_login_screen.dart';
import '../features/latihan/lat_04_shared_pref/splash_screen.dart';
import '../features/latihan/lat_05_scroll_ui/lat_scroll_screen.dart';

class AppRoutes {
  static final List<ModuleItem> modules = [
    // ================= TUGAS =================
    ModuleItem(
      id: 'tugas_01_ui',
      moduleNumber: 'Tugas 01',
      title: 'Profil & Biodata Pribadi',
      subtitle: 'StatelessWidget, Column, Row, dan Styling dasar',
      description:
          'Implementasi kartu profil sederhana menggunakan widget dasar Flutter seperti Column, Row, Text, Icon, dan Padding.',
      category: ModuleCategory.tugas,
      icon: Icons.person_pin,
      color: const Color(0xFF10B981),
      tags: ['StatelessWidget', 'Column', 'Row', 'Styling'],
      builder: (context) => const Tugas01Widget(),
    ),
    ModuleItem(
      id: 'tugas_01_logic',
      moduleNumber: 'Tugas 01',
      title: 'Biodata Klub Buku (Dart Core)',
      subtitle: 'Variabel, List, Map, TextTheme, dan InfoRow',
      description:
          'Penerapan tipe data fundamental Dart: String, int, double, boolean, List buku, dan Map informasi tambahan.',
      category: ModuleCategory.tugas,
      icon: Icons.auto_stories,
      color: const Color(0xFF6366F1),
      tags: ['Dart Core', 'List', 'Map', 'Card'],
      builder: (context) => const Tugas01ConsoleScreen(),
      logicRunner: Tugas01ConsoleScreen.runLogic,
    ),
    ModuleItem(
      id: 'tugas_02_ui',
      moduleNumber: 'Tugas 02',
      title: 'Detail Toko Harmony Music',
      subtitle: 'Layout Card, Shadow, Wrap, dan Image Asset',
      description:
          'Halaman katalog detail toko musik dengan integrasi SingleChildScrollView, Card statistik rating, Icon, dan asset gambar.',
      category: ModuleCategory.tugas,
      icon: Icons.storefront,
      color: const Color(0xFFF59E0B),
      tags: ['SingleChildScrollView', 'Card', 'Asset', 'Layout'],
      builder: (context) => const Tugas02Widget(),
    ),
    ModuleItem(
      id: 'tugas_02_logic',
      moduleNumber: 'Tugas 02',
      title: 'Kalkulator Kelulusan Nilai',
      subtitle: 'Kondisi if-else, operator logika, dan Slider interaktif',
      description:
          'Simulasi logika penentuan kelulusan mahasiswa berdasarkan syarat nilai UTS, UAS, dan persentase kehadiran.',
      category: ModuleCategory.tugas,
      icon: Icons.calculate_outlined,
      color: const Color(0xFFEC4899),
      tags: ['Logic', 'Conditional', 'Slider', 'Interactive'],
      builder: (context) => const Tugas02LogicScreen(),
      logicRunner: () => Tugas02LogicScreen.runCalculation(),
    ),
    ModuleItem(
      id: 'tugas_03_ui',
      moduleNumber: 'Tugas 03',
      title: 'Laporan Kualitas Udara',
      subtitle: 'Form input TextFormField dan ListView riwayat',
      description:
          'Aplikasi pelaporan kondisi udara dengan form input, tombol tambah data, dan list riwayat laporan terkini.',
      category: ModuleCategory.tugas,
      icon: Icons.air,
      color: const Color(0xFF06B6D4),
      tags: ['TextFormField', 'ListView', 'StatefulWidget'],
      builder: (context) => const Tugas03Widget(),
    ),
    ModuleItem(
      id: 'tugas_03_logic',
      moduleNumber: 'Tugas 03',
      title: 'Algoritma Looping Dart',
      subtitle: 'For loop, while loop, for-in, dan struktur data List',
      description:
          'Visualisasi 5 latihan perulangan Dart: deret ganjil, pola bintang, pengulangan nama, koleksi buah, dan daftar belanja.',
      category: ModuleCategory.tugas,
      icon: Icons.loop,
      color: const Color(0xFF8B5CF6),
      tags: ['Looping', 'For-in', 'While', 'Algorithms'],
      builder: (context) => const Tugas03LoopingScreen(),
      logicRunner: Tugas03LoopingScreen.runLoopingTasks,
    ),
    ModuleItem(
      id: 'tugas_04_ui',
      moduleNumber: 'Tugas 04',
      title: 'Registrasi & Galeri Edukasi',
      subtitle: 'Form registrasi lengkap + GridView responsif',
      description:
          'Form registrasi dengan validasi input password, dikombinasikan dengan GridView.builder untuk galeri kartu edukasi.',
      category: ModuleCategory.tugas,
      icon: Icons.grid_view,
      color: const Color(0xFF3B82F6),
      tags: ['GridView', 'Form', 'ObscureText', 'Stack'],
      builder: (context) => const Tugas04Widget(),
    ),
    ModuleItem(
      id: 'tugas_04_revisi',
      moduleNumber: 'Tugas 04 (Revisi)',
      title: 'SliverGrid & CustomScrollView',
      subtitle: 'Arsitektur responsif standar industri dengan Slivers',
      description:
          'Refaktorisasi Tugas 4 menggunakan CustomScrollView, SliverPadding, dan SliverGridDelegateWithMaxCrossAxisExtent.',
      category: ModuleCategory.tugas,
      icon: Icons.view_quilt,
      color: const Color(0xFF2563EB),
      tags: ['Slivers', 'CustomScrollView', 'Responsive', 'Clean Code'],
      builder: (context) => const Tugas04RevisiWidget(),
    ),
    ModuleItem(
      id: 'tugas_05_interaksi',
      moduleNumber: 'Tugas 05',
      title: 'Lab Interaksi & Event Gesture',
      subtitle: 'ElevatedButton, IconButton, InkWell, & GestureDetector',
      description:
          'Eksplorasi lengkap berbagai event sentuhan di Flutter: toggle visibility, favorit, ripple effect, multi-gesture tap/double tap/long press, serta FAB.',
      category: ModuleCategory.tugas,
      icon: Icons.touch_app,
      color: const Color(0xFFEF4444),
      tags: ['ElevatedButton', 'InkWell', 'GestureDetector', 'FAB'],
      builder: (context) => const Tugas05InteraksiWidget(),
    ),
    ModuleItem(
      id: 'tugas_05_form',
      moduleNumber: 'Tugas 05',
      title: 'Form Input & Validasi Real-time',
      subtitle: 'FormBuilderValidators, SnackBar, dan State Management',
      description:
          'Form input data user lengkap dengan validasi email, tombol reset, dialog informasi, dan hasil submit interaktif.',
      category: ModuleCategory.tugas,
      icon: Icons.dynamic_form,
      color: const Color(0xFF14B8A6),
      tags: ['FormValidation', 'SnackBar', 'Dialog', 'Controller'],
      builder: (context) => const Tugas05FormInputWidget(),
    ),
    ModuleItem(
      id: 'tugas_07_drawer',
      moduleNumber: 'Tugas 07',
      title: 'Custom Navigation Drawer',
      subtitle: 'Drawer kustom dengan header profil dan navigasi menu',
      description:
          'Implementasi navigasi panel samping (Side Drawer) dengan styling kustom dan integrasi Scaffold.',
      category: ModuleCategory.tugas,
      icon: Icons.menu_open,
      color: const Color(0xFFDB2777),
      tags: ['Drawer', 'Scaffold', 'Navigation'],
      builder: (context) => const Tugas07DrawerWidget(),
    ),
    ModuleItem(
      id: 'tugas_08_nav',
      moduleNumber: 'Tugas 08',
      title: 'Bottom Navigation & Multi-Screen',
      subtitle: 'IndexedStack, BottomNavigationBar, Drawer, dan Form',
      description:
          'Arsitektur navigasi multi-halaman menggabungkan BottomNavigationBar, IndexedStack state retention, dan About screen.',
      category: ModuleCategory.tugas,
      icon: Icons.tab,
      color: const Color(0xFF4F46E5),
      tags: ['BottomNav', 'IndexedStack', 'MultiPage', 'State'],
      builder: (context) => const Tugas08BottomNavWidget(),
    ),
    ModuleItem(
      id: 'tugas_09_listview',
      moduleNumber: 'Tugas 09',
      title: 'ListView & Data Model Hub',
      subtitle: '3 Pendekatan ListView: List<String>, List<Map>, & Model Class',
      description:
          'Studi komparasi 3 cara menampilkan data list pada Flutter secara bersih dan terstruktur menggunakan model data Produk.',
      category: ModuleCategory.tugas,
      icon: Icons.inventory_2,
      color: const Color(0xFF0D9488),
      tags: ['ListView', 'DataModel', 'NetworkImage', 'TabBar'],
      builder: (context) => const Tugas09HubWidget(),
    ),
    ModuleItem(
      id: 'tugas_10_validation',
      moduleNumber: 'Tugas 10',
      title: 'Validasi Form Tingkat Lanjut',
      subtitle: 'Regex email, password validation, & AlertDialog konfirmasi',
      description:
          'Penerapan best-practice validasi form pendaftaran akun dengan regex email, indikator keamanan, dan popup dialog konfirmasi.',
      category: ModuleCategory.tugas,
      icon: Icons.verified_user,
      color: const Color(0xFF7C3AED),
      tags: ['FormValidation', 'Regex', 'AlertDialog', 'Security'],
      builder: (context) => const Tugas10FormWidget(),
    ),
    ModuleItem(
      id: 'tugas_11_session',
      moduleNumber: 'Tugas 11',
      title: 'Session Token & Auth Flow',
      subtitle: 'Splash Screen, Bearer Token, Dialog Pop, & Auto-Redirect',
      description:
          'Implementasi autentikasi sesi lengkap: Splash screen memeriksa token SharedPreferences, Login dengan dialog konfirmasi, dan auto-redirect kembali ke profil saat token aktif.',
      category: ModuleCategory.tugas,
      icon: Icons.vpn_key,
      color: const Color(0xFF2563EB),
      tags: ['SharedPreferences', 'BearerToken', 'SplashAutoRedirect', 'SessionAuth'],
      builder: (context) => const Tugas11AuthHubWidget(),
    ),
    ModuleItem(
      id: 'tugas_12dan13_local_storage',
      moduleNumber: 'Tugas 12 & 13',
      title: 'Local Storage — CRUD SQLite',
      subtitle: 'Simpan, Baca, Edit & Hapus catatan dengan sqflite',
      description:
          'Penerapan local storage (SQLite) secara praktis: membuat tabel catatan, menambah data baru (INSERT), menampilkan daftar (SELECT), mengedit (UPDATE), dan menghapus (DELETE) menggunakan package sqflite.',
      category: ModuleCategory.tugas,
      icon: Icons.storage,
      color: const Color(0xFF059669),
      tags: ['SQLite', 'sqflite', 'CRUD', 'LocalStorage', 'FutureBuilder'],
      builder: (context) => const Tugas12dan13LocalStorageWidget(),
    ),

    // ================= LATIHAN =================
    ModuleItem(
      id: 'lat_01_article',
      moduleNumber: 'Latihan 01',
      title: 'Artikel UI EcoSync',
      subtitle: 'Layout berita modern dengan gambar, badge, & author info',
      description:
          'Desain halaman artikel responsif dengan integrasi banner gambar, badge verifikasi penulis, dan konten edukatif.',
      category: ModuleCategory.latihan,
      icon: Icons.article_outlined,
      color: const Color(0xFF059669),
      tags: ['ArticleUI', 'ClipRRect', 'Typography', 'Row/Column'],
      builder: (context) => const LatArticleScreen(),
    ),
    ModuleItem(
      id: 'lat_02_drawer',
      moduleNumber: 'Latihan 02',
      title: 'Latihan Drawer & Accounts Header',
      subtitle: 'UserAccountsDrawerHeader dengan multi-menu',
      description:
          'Latihan pembuatan Drawer lengkap dengan UserAccountsDrawerHeader, avatar inisial, dan pemilihan halaman aktif.',
      category: ModuleCategory.latihan,
      icon: Icons.account_circle_outlined,
      color: const Color(0xFF2563EB),
      tags: ['UserAccountsDrawer', 'Avatar', 'StatefulNav'],
      builder: (context) => const LatDrawerScreen(),
    ),
    ModuleItem(
      id: 'lat_02_bottom_nav',
      moduleNumber: 'Latihan 02',
      title: 'Latihan Bottom Navigation Bar',
      subtitle: 'Navigasi 4 tab dengan status aktif',
      description:
          'Latihan implementasi dasar BottomNavigationBar 4 menu: Beranda, Billing, Laporan, dan Profil.',
      category: ModuleCategory.latihan,
      icon: Icons.view_carousel,
      color: const Color(0xFF0284C7),
      tags: ['BottomNavigationBar', 'Icons', 'Pages'],
      builder: (context) => const LatBottomNavScreen(),
    ),
    ModuleItem(
      id: 'lat_03_login',
      moduleNumber: 'Latihan 03',
      title: 'Latihan Desain Login UI',
      subtitle: 'Tampilan otentikasi login modern & bersih',
      description:
          'Desain antarmuka form login dengan input email, password toggle obscure, dan tombol login.',
      category: ModuleCategory.latihan,
      icon: Icons.lock_open,
      color: const Color(0xFFD97706),
      tags: ['LoginUI', 'TextField', 'FormLayout'],
      builder: (context) => const LatLoginScreen(),
    ),
    ModuleItem(
      id: 'lat_04_session',
      moduleNumber: 'Latihan 04',
      title: 'Splash Screen & Session SharedPreferences',
      subtitle: 'Persistensi sesi login lokal dengan shared_preferences',
      description:
          'Alur otentikasi nyata: Splash Screen -> Cek Session -> Login / Halaman Selamat Datang -> Logout.',
      category: ModuleCategory.latihan,
      icon: Icons.storage,
      color: const Color(0xFF9333EA),
      tags: ['SharedPreferences', 'Session', 'SplashScreen', 'Async'],
      builder: (context) => const LatSplashScreen(),
    ),
    ModuleItem(
      id: 'lat_05_scroll',
      moduleNumber: 'Latihan 05',
      title: 'Latihan Scroll Horizontal',
      subtitle: 'SingleChildScrollView dengan scrollDirection Axis.horizontal',
      description:
          'Demo navigasi scroll horizontal dengan konten panjang yang dapat digeser menyamping.',
      category: ModuleCategory.latihan,
      icon: Icons.swap_horiz,
      color: const Color(0xFF64748B),
      tags: ['HorizontalScroll', 'SingleChildScrollView', 'Layout'],
      builder: (context) => const LatScrollScreen(),
    ),
  ];
}

