class CatatanModel {
  final int? id;
  final String judul;
  final String isi;
  final String tanggal;

  CatatanModel({
    this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'tanggal': tanggal,
    };
  }

  factory CatatanModel.fromMap(Map<String, dynamic> map) {
    return CatatanModel(
      id: map['id'] as int?,
      judul: map['judul'] as String,
      isi: map['isi'] as String,
      tanggal: map['tanggal'] as String,
    );
  }
}
