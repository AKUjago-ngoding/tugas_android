import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/tugas/tugas_14_API_using/db/db_service.dart';
import 'package:flutter_application_2/features/tugas/tugas_14_API_using/models/ghibli_models.dart';
import 'package:flutter_application_2/features/tugas/tugas_14_API_using/services/api_film.dart';

class ListGhibliScreen extends StatefulWidget {
  const ListGhibliScreen({super.key});

  @override
  State<ListGhibliScreen> createState() => _ListGhibliScreenState();
}

class _ListGhibliScreenState extends State<ListGhibliScreen> {
  final GhibliServices _apiService = GhibliServices();
  final DbService _dbService = DbService.instance;

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  List<Ghibli> _allFilms = [];
  List<Ghibli> _filteredFilms = [];
  List<Ghibli> _savedFilms = [];
  Set<String> _savedFilmIds = {};

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFilms();
    _loadSavedFilms();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFilms() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final films = await _apiService.fetchFilm();
      if (!mounted) return;
      setState(() {
        _allFilms = films;
        _filteredFilms = films;
        _isLoading = false;
      });
      // Sinkronkan kembali dengan input pencarian jika ada
      if (_searchController.text.isNotEmpty) {
        _onSearch(_searchController.text);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Gagal memuat data film: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadSavedFilms() async {
    try {
      final saved = await _dbService.getSavedFilms();
      if (!mounted) return;
      setState(() {
        _savedFilms = saved;
        _savedFilmIds = saved.map((f) => f.id).whereType<String>().toSet();
      });
    } catch (e) {
      debugPrint('Error loading saved films: $e');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _onSearch(query);
    });
  }

  void _onSearch(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredFilms = _allFilms;
      } else {
        final q = query.toLowerCase().trim();
        _filteredFilms = _allFilms.where((film) {
          final searchable = [
            film.title,
            film.originalTitle,
            film.originalTitleRomanised,
            film.director,
            film.producer,
            film.description,
            film.releaseDate,
          ].where((f) => f != null).join(' ').toLowerCase();
          return searchable.contains(q);
        }).toList();
      }
    });
  }

  Future<void> _handleSaveButton(Ghibli film) async {
    if (film.id == null) return;
    final isAlreadySaved = _savedFilmIds.contains(film.id);

    try {
      if (isAlreadySaved) {
        await _dbService.deleteFilm(film.id!);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${film.title}" dihapus dari favorit (SQLite).'),
            backgroundColor: Colors.orange.shade700,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        await _dbService.saveFilm(film);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${film.title}" disimpan ke database lokal!'),
            backgroundColor: const Color(0xFF059669),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      await _loadSavedFilms();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _onRefresh() async {
    await Future.wait([
      _loadFilms(),
      _loadSavedFilms(),
    ]);
  }

  void _showFilmDetail(Ghibli film) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final currentSaved = film.id != null && _savedFilmIds.contains(film.id);

            return DraggableScrollableSheet(
              initialChildSize: 0.85,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              builder: (_, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    children: [
                      // Header Drag Handle
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 8),
                          width: 48,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // Movie Banner
                      if (film.movieBanner != null && film.movieBanner!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              film.movieBanner!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 180,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title & Bookmark Button
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        film.title ?? 'Tanpa Judul',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                      if (film.originalTitle != null || film.originalTitleRomanised != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          '${film.originalTitle ?? ''} (${film.originalTitleRomanised ?? ''})',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                IconButton.filledTonal(
                                  icon: Icon(
                                    currentSaved ? Icons.bookmark : Icons.bookmark_border,
                                    color: currentSaved ? const Color(0xFF059669) : Colors.grey.shade700,
                                  ),
                                  onPressed: () async {
                                    await _handleSaveButton(film);
                                    setModalState(() {});
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Badges (Year, Duration, Rating)
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                if (film.releaseDate != null)
                                  _buildBadge(Icons.calendar_month, film.releaseDate!, const Color(0xFF2563EB)),
                                if (film.runningTime != null)
                                  _buildBadge(Icons.timer_outlined, '${film.runningTime} min', const Color(0xFF7C3AED)),
                                if (film.rtScore != null)
                                  _buildBadge(Icons.star_rounded, '${film.rtScore}% RT', const Color(0xFFD97706)),
                              ],
                            ),
                            const Divider(height: 32),

                            // Director & Producer Info
                            _buildInfoRow('Sutradara', film.director ?? '-'),
                            const SizedBox(height: 8),
                            _buildInfoRow('Produser', film.producer ?? '-'),
                            const Divider(height: 32),

                            // Synopsis
                            const Text(
                              'Sinopsis',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              film.description ?? 'Tidak ada deskripsi tersedia.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.6,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Tombol Aksi Simpan / Hapus
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: currentSaved ? Colors.red.shade600 : const Color(0xFF059669),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(currentSaved ? Icons.bookmark_remove : Icons.bookmark_add),
                                label: Text(
                                  currentSaved ? 'Hapus dari Tersimpan' : 'Simpan ke Database SQLite',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                onPressed: () async {
                                  await _handleSaveButton(film);
                                  setModalState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Text(': ', style: TextStyle(color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilmCard(Ghibli film) {
    final isSaved = film.id != null && _savedFilmIds.contains(film.id);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showFilmDetail(film),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster Film
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: film.image != null && film.image!.isNotEmpty
                    ? Image.network(
                        film.image!,
                        width: 85,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 85,
                          height: 120,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.movie_outlined, color: Colors.grey),
                        ),
                      )
                    : Container(
                        width: 85,
                        height: 120,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.movie_outlined, color: Colors.grey),
                      ),
              ),
              const SizedBox(width: 14),

              // Detail Ringkas
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.title ?? 'Tanpa Judul',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      film.originalTitleRomanised ?? film.originalTitle ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.person_outline, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            film.director ?? '-',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (film.releaseDate != null) ...[
                          Text(
                            film.releaseDate!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text('•', style: TextStyle(color: Colors.grey)),
                          const SizedBox(width: 6),
                        ],
                        if (film.runningTime != null) ...[
                          Text(
                            '${film.runningTime} m',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                          const SizedBox(width: 6),
                          const Text('•', style: TextStyle(color: Colors.grey)),
                          const SizedBox(width: 6),
                        ],
                        if (film.rtScore != null)
                          Row(
                            children: [
                              const Icon(Icons.star, size: 13, color: Colors.amber),
                              const SizedBox(width: 2),
                              Text(
                                '${film.rtScore}%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD97706),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      film.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // Tombol Simpan (Bookmark)
              IconButton(
                tooltip: isSaved ? 'Hapus Simpanan' : 'Simpan ke SQLite',
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: isSaved ? const Color(0xFF059669) : Colors.grey.shade400,
                ),
                onPressed: () => _handleSaveButton(film),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text(
            '🎬 Studio Ghibli Film',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: const Color(0xFF3B82F6),
            labelColor: const Color(0xFF3B82F6),
            unselectedLabelColor: Colors.grey.shade600,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                icon: const Icon(Icons.movie_outlined, size: 20),
                text: 'Semua Film (${_allFilms.length})',
              ),
              Tab(
                icon: const Icon(Icons.bookmark_outline, size: 20),
                text: 'Tersimpan (${_savedFilms.length})',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TAB 1: SEMUA FILM (REST API + SEARCH)
            _buildAllFilmsTab(),

            // TAB 2: FILM TERSIMPAN (SQLITE DATABASE)
            _buildSavedFilmsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllFilmsTab() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF3B82F6)),
            SizedBox(height: 16),
            Text(
              'Memuat daftar film Ghibli...',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _loadFilms,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari judul, sutradara, sinopsis...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF3B82F6)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          _onSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                ),
              ),
            ),
          ),

          // Film List
          Expanded(
            child: _filteredFilms.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          'Film tidak ditemukan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Coba kata kunci pencarian yang lain',
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: _filteredFilms.length,
                    itemBuilder: (context, index) {
                      return _buildFilmCard(_filteredFilms[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedFilmsTab() {
    return RefreshIndicator(
      onRefresh: _loadSavedFilms,
      color: const Color(0xFF3B82F6),
      child: _savedFilms.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bookmark_border_rounded, size: 70, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada film tersimpan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tekan ikon bookmark pada film di tab "Semua Film" untuk menyimpannya ke database lokal (SQLite).',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _savedFilms.length,
              itemBuilder: (context, index) {
                return _buildFilmCard(_savedFilms[index]);
              },
            ),
    );
  }
}
