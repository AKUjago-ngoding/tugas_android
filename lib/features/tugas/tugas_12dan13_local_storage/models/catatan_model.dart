/// ============================================================================
/// MODEL: CatatanModel
/// ============================================================================
/// Blueprint data satu baris catatan yang akan disimpan di SQLite.
/// Setiap catatan memiliki: id (auto), judul, isi, dan tanggal dibuat.
class CatatanModel {
  final int? id; // Null sebelum disimpan ke DB (ID diisi otomatis oleh SQLite)
  final String judul;
  final String isi;
  final String tanggal;

  CatatanModel({
    this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
  });

  /// Konversi objek Dart -> Map (dibutuhkan saat INSERT / UPDATE ke SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'tanggal': tanggal,
    };
  }

  /// Konversi Map hasil query SQLite -> objek Dart
  factory CatatanModel.fromMap(Map<String, dynamic> map) {
    return CatatanModel(
      id: map['id'] as int?,
      judul: map['judul'] as String,
      isi: map['isi'] as String,
      tanggal: map['tanggal'] as String,
    );
  }
}

