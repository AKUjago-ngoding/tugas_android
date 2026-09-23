import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/catatan_model.dart';

/// ============================================================================
/// SERVICE: DatabaseHelper (Singleton Pattern)
/// ============================================================================
/// Kelas ini adalah "jembatan" antara aplikasi dan file database SQLite lokal.
///
/// Menggunakan SINGLETON PATTERN: hanya ada 1 instance aktif di seluruh app.
/// Tujuannya agar koneksi database tidak dibuka berkali-kali secara boros.
class DatabaseHelper {
  // --- SINGLETON SETUP ---

  // 1. Simpan satu instance statis dari diri sendiri
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // 2. Factory constructor: setiap kali DatabaseHelper() dipanggil, kembalikan instance yang SAMA
  factory DatabaseHelper() => _instance;

  // 3. Constructor private agar tidak bisa dibuat instance baru dari luar
  DatabaseHelper._internal();

  // Variabel koneksi database (null sampai pertama kali dibuka)
  static Database? _database;

  /// Getter `database`: ambil koneksi DB.
  /// Jika belum ada, buka dulu (Lazy Initialization).
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // ---------------------------------------------------------------------------
  // INISIALISASI DATABASE
  // ---------------------------------------------------------------------------
  Future<Database> _initDB() async {
    // Ambil path folder penyimpanan default di Android/iOS
    final dbPath = await getDatabasesPath();
    // Buat path lengkap: misalnya /data/user/0/.../databases/catatan.db
    final path = join(dbPath, 'catatan.db');

    return await openDatabase(
      path,
      version: 1,
      // onCreate dipanggil HANYA saat file database belum ada (pertama kali)
      onCreate: (db, version) async {
        // Buat tabel 'catatan' dengan 4 kolom
        await db.execute('''
          CREATE TABLE catatan (
            id      INTEGER PRIMARY KEY AUTOINCREMENT,
            judul   TEXT NOT NULL,
            isi     TEXT NOT NULL,
            tanggal TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // ---------------------------------------------------------------------------
  // CREATE — Tambah catatan baru
  // ---------------------------------------------------------------------------
  /// Menyimpan [catatan] baru ke tabel. Mengembalikan id baru yang dibuat SQLite.
  Future<int> tambahCatatan(CatatanModel catatan) async {
    final db = await database;
    try {
      return await db.insert('catatan', catatan.toMap());
    } catch (e) {
      log('Error tambahCatatan: $e');
      return -1; // Kembalikan -1 jika gagal
    }
  }

  // ---------------------------------------------------------------------------
  // READ — Ambil semua catatan
  // ---------------------------------------------------------------------------
  /// Mengambil seluruh baris di tabel dan mengembalikannya sebagai List.
  Future<List<CatatanModel>> semuaCatatan() async {
    final db = await database;
    // Query tanpa 'where' = ambil semua baris, urut dari terbaru
    final List<Map<String, dynamic>> results = await db.query(
      'catatan',
      orderBy: 'id DESC', // Catatan terbaru tampil paling atas
    );
    // Konversi setiap Map menjadi objek CatatanModel
    return results.map((map) => CatatanModel.fromMap(map)).toList();
  }

  // ---------------------------------------------------------------------------
  // UPDATE — Perbarui catatan yang sudah ada
  // ---------------------------------------------------------------------------
  /// Mengupdate data catatan berdasarkan [catatan.id].
  /// Mengembalikan jumlah baris yang berhasil diubah (harusnya 1 jika sukses).
  Future<int> updateCatatan(CatatanModel catatan) async {
    final db = await database;
    try {
      return await db.update(
        'catatan',
        catatan.toMap(),
        where: 'id = ?',
        whereArgs: [catatan.id], // Aman dari SQL Injection!
      );
    } catch (e) {
      log('Error updateCatatan: $e');
      return 0;
    }
  }

  // ---------------------------------------------------------------------------
  // DELETE — Hapus catatan berdasarkan ID
  // ---------------------------------------------------------------------------
  /// Menghapus satu baris catatan yang memiliki [id] yang cocok.
  Future<void> hapusCatatan(int id) async {
    final db = await database;
    await db.delete(
      'catatan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

