import 'package:flutter/material.dart';
import '../../../core/models/module_item.dart';
import '../../../routes/app_routes.dart';
import '../widgets/category_chips.dart';
import '../widgets/module_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ModuleCategory _selectedCategory = ModuleCategory.all;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ModuleItem> get _filteredModules {
    return AppRoutes.modules.where((item) {
      final matchesCategory = _selectedCategory == ModuleCategory.all ||
          item.category == _selectedCategory;

      final matchesQuery = _searchQuery.isEmpty ||
          item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.subtitle.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.moduleNumber.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.tags.any(
            (tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()),
          );

      return matchesCategory && matchesQuery;
    }).toList();
  }

  int get _tugasCount => AppRoutes.modules
      .where((m) => m.category == ModuleCategory.tugas)
      .length;
  int get _latihanCount => AppRoutes.modules
      .where((m) => m.category == ModuleCategory.latihan)
      .length;

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredModules;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top App Bar Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/profile/qingxiao.jpg'),
                      backgroundColor: Colors.blueAccent,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Katalog Tugas & Latihan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            'PPKD Jakarta Utara • Flutter Mobile',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline, color: Colors.blueGrey),
                      onPressed: () => _showAboutApp(context),
                    ),
                  ],
                ),
              ),
            ),

            // Statistics Summary Cards
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _buildStatCard(
                      title: 'Total Modul',
                      count: '${AppRoutes.modules.length}',
                      icon: Icons.layers_outlined,
                      color: const Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 10),
                    _buildStatCard(
                      title: 'Tugas Kuliah',
                      count: '$_tugasCount',
                      icon: Icons.assignment_outlined,
                      color: const Color(0xFF10B981),
                    ),
                    const SizedBox(width: 10),
                    _buildStatCard(
                      title: 'Latihan Lab',
                      count: '$_latihanCount',
                      icon: Icons.science_outlined,
                      color: const Color(0xFF8B5CF6),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari tugas, widget, topik (misal: ListView, Grid)...',
                    hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              ),
            ),

            // Category Filter Chips
            SliverToBoxAdapter(
              child: CategoryChips(
                selectedCategory: _selectedCategory,
                onCategoryChanged: (cat) => setState(() => _selectedCategory = cat),
              ),
            ),

            // Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Text(
                      _selectedCategory == ModuleCategory.all
                          ? 'Semua Modul Pembelajaran (${filtered.length})'
                          : _selectedCategory == ModuleCategory.tugas
                              ? 'Daftar Tugas (${filtered.length})'
                              : 'Daftar Latihan (${filtered.length})',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Module Items List
            if (filtered.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Column(
                      children: const [
                        Icon(Icons.search_off, size: 56, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          'Modul tidak ditemukan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Coba gunakan kata kunci pencarian yang lain.',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ModuleCard(item: filtered[index]),
                  childCount: filtered.length,
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    count,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.flutter_dash, size: 48, color: Color(0xFF3B82F6)),
        title: const Text('Katalog Modul Flutter'),
        content: const Text(
          'Aplikasi ini menggabungkan seluruh tugas kuliah dan modul latihan praktikum pemrograman mobile Flutter ke dalam sebuah antarmuka yang terstruktur, bersih, dan interaktif.\n\nSetiap tugas dapat langsung dijalankan dan dieksplorasi secara visual maupun melalui output logikanya.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }
}

