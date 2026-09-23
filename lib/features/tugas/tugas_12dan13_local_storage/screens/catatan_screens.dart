import 'package:flutter/material.dart';

import '../models/catatan_model.dart';
import '../services/database_helper.dart';

/// ============================================================================
/// SCREEN: DaftarCatatanScreen (Home — READ + DELETE)
/// ============================================================================
/// Halaman utama yang menampilkan seluruh daftar catatan dari SQLite.
/// - FutureBuilder dipakai untuk menampilkan loading / error / data secara otomatis.
/// - Setiap item ada tombol EDIT dan HAPUS.
/// - FAB di pojok kanan bawah untuk TAMBAH catatan baru.
class DaftarCatatanScreen extends StatefulWidget {
  const DaftarCatatanScreen({super.key});

  @override
  State<DaftarCatatanScreen> createState() => _DaftarCatatanScreenState();
}

class _DaftarCatatanScreenState extends State<DaftarCatatanScreen> {
  // Simpan Future di variabel state agar tidak dipanggil ulang setiap rebuild
  late Future<List<CatatanModel>> _catatanFuture;

  @override
  void initState() {
    super.initState();
    _muatUlang(); // Muat data pertama kali
  }

  /// Memicu ulang query ke SQLite dan memperbarui UI
  void _muatUlang() {
    setState(() {
      _catatanFuture = DatabaseHelper().semuaCatatan();
    });
  }

  // ---------------------------------------------------------------------------
  // HAPUS: Dialog konfirmasi sebelum menghapus data
  // ---------------------------------------------------------------------------
  void _konfirmasiHapus(CatatanModel catatan) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Hapus Catatan?'),
          ],
        ),
        content: Text('Catatan "${catatan.judul}" akan dihapus permanen.'),
        actions: [
          // Batal: tutup dialog saja
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          // Hapus: jalankan DELETE lalu refresh list
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              Navigator.pop(ctx); // Tutup dialog
              await DatabaseHelper().hapusCatatan(catatan.id!);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Catatan "${catatan.judul}" dihapus'),
                  backgroundColor: Colors.red,
                ),
              );
              _muatUlang(); // Refresh tampilan
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // NAVIGASI ke FormCatatanScreen (untuk Tambah atau Edit)
  // ---------------------------------------------------------------------------
  Future<void> _bukaForm({CatatanModel? catatan}) async {
    // Tunggu halaman form ditutup, lalu refresh list
    final bool? diperbarui = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => FormCatatanScreen(catatan: catatan),
      ),
    );
    // Jika form mengembalikan 'true' (artinya ada data yang disimpan), refresh
    if (diperbarui == true) {
      _muatUlang();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📝 Catatan SQLite',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<CatatanModel>>(
        future: _catatanFuture,
        builder: (context, snapshot) {
          // --- Status 1: Sedang loading ---
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // --- Status 2: Terjadi error ---
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi error:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          // --- Status 3: Data kosong ---
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.note_alt_outlined,
                      size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada catatan.\nTekan + untuk menambahkan!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                ],
              ),
            );
          }

          // --- Status 4: Data tersedia ---
          final daftarCatatan = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: daftarCatatan.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final catatan = daftarCatatan[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  // Nomor urut sebagai leading
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF4F46E5),
                    child: Text(
                      '${daftarCatatan.length - index}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    catatan.judul,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        catatan.isi,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 12, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            catatan.tanggal,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tombol EDIT
                      IconButton(
                        tooltip: 'Edit',
                        onPressed: () => _bukaForm(catatan: catatan),
                        icon: const Icon(Icons.edit, color: Color(0xFF4F46E5)),
                      ),
                      // Tombol HAPUS
                      IconButton(
                        tooltip: 'Hapus',
                        onPressed: () => _konfirmasiHapus(catatan),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // FAB untuk TAMBAH catatan baru
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        onPressed: () => _bukaForm(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}

/// ============================================================================
/// SCREEN: FormCatatanScreen (CREATE & UPDATE)
/// ============================================================================
/// Satu form yang bisa dipakai untuk DUA keperluan:
/// - [catatan] == null  → mode TAMBAH (Create)
/// - [catatan] != null  → mode EDIT (Update), field sudah terisi data lama
///
/// Setelah simpan, halaman di-pop dengan nilai `true` agar DaftarCatatanScreen
/// tahu perlu me-refresh listnya.
class FormCatatanScreen extends StatefulWidget {
  /// Jika null = mode tambah, jika ada isinya = mode edit
  final CatatanModel? catatan;

  const FormCatatanScreen({super.key, this.catatan});

  @override
  State<FormCatatanScreen> createState() => _FormCatatanScreenState();
}

class _FormCatatanScreenState extends State<FormCatatanScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulCtrl;
  late final TextEditingController _isiCtrl;

  bool _isSaving = false; // Tampilkan loading saat proses simpan

  // Apakah sedang mode edit?
  bool get _modeEdit => widget.catatan != null;

  @override
  void initState() {
    super.initState();
    // Jika mode edit, isi controller dengan data yang ada
    _judulCtrl = TextEditingController(text: widget.catatan?.judul ?? '');
    _isiCtrl = TextEditingController(text: widget.catatan?.isi ?? '');
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // SIMPAN: Panggil INSERT atau UPDATE sesuai mode
  // ---------------------------------------------------------------------------
  Future<void> _simpan() async {
    // Validasi form terlebih dahulu
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    // Buat objek catatan dari input pengguna
    final now = DateTime.now();
    final tanggalStr =
        '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}  ${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}';

    final CatatanModel dataBaru = CatatanModel(
      id: widget.catatan?.id, // Null jika tambah, ada nilai jika edit
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      tanggal: tanggalStr,
    );

    bool sukses;
    if (_modeEdit) {
      // UPDATE: perbarui baris yang sudah ada berdasarkan ID
      final rowsAffected = await DatabaseHelper().updateCatatan(dataBaru);
      sukses = rowsAffected > 0;
    } else {
      // INSERT: tambah baris baru, kembalikan ID baru (> 0 = sukses)
      final newId = await DatabaseHelper().tambahCatatan(dataBaru);
      sukses = newId > 0;
    }

    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(sukses
            ? (_modeEdit ? 'Catatan berhasil diperbarui!' : 'Catatan berhasil ditambahkan!')
            : 'Gagal menyimpan catatan.'),
        backgroundColor: sukses ? Colors.green : Colors.red,
      ),
    );

    if (sukses) {
      // Kembalikan `true` agar halaman sebelumnya tahu perlu refresh
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _modeEdit ? '✏️ Edit Catatan' : '➕ Catatan Baru',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ----------------------------------------------------------------
              // INFO BANNER
              // ----------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: Color(0xFF4F46E5), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _modeEdit
                            ? 'Mode Edit: ubah isi form lalu tekan Simpan.'
                            : 'Mode Tambah: isi form lalu tekan Simpan.',
                        style: const TextStyle(
                          color: Color(0xFF4F46E5),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ----------------------------------------------------------------
              // INPUT JUDUL
              // ----------------------------------------------------------------
              const Text(
                'Judul Catatan',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _judulCtrl,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Masukkan judul catatan...',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ----------------------------------------------------------------
              // INPUT ISI
              // ----------------------------------------------------------------
              const Text(
                'Isi Catatan',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _isiCtrl,
                maxLines: 6,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Tulis isi catatan di sini...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Isi catatan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // ----------------------------------------------------------------
              // TOMBOL SIMPAN
              // ----------------------------------------------------------------
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Tampilkan loading spinner saat sedang menyimpan
                  onPressed: _isSaving ? null : _simpan,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(
                    _isSaving
                        ? 'Menyimpan...'
                        : (_modeEdit ? 'Simpan Perubahan' : 'Simpan Catatan'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
