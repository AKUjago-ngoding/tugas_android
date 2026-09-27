import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/services/auth_service.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/services/api_service.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/models/user_model.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/models/absen_model.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/screens/absensi_screen.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/screens/history_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dio/dio.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = const [
    DashboardHomeWidget(),
    AbsensiWidget(),
    HistoryWidget(),
    ProfileWidget(),
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi PPKD', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            selectedIcon: Icon(Icons.access_time),
            label: 'Absensi',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class DashboardHomeWidget extends StatefulWidget {
  const DashboardHomeWidget({super.key});

  @override
  State<DashboardHomeWidget> createState() => _DashboardHomeWidgetState();
}

class _DashboardHomeWidgetState extends State<DashboardHomeWidget> {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  
  UserModel? _user;
  AbsenModel? _todayAbsen;
  bool _isLoading = true;
  
  int _totalMasuk = 0;
  int _totalIzin = 0;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.getUser();
      
      final allHistory = await _apiService.getHistory();
      
      final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
      AbsenModel? todayAbsen;
      
      int masukCount = 0;
      int izinCount = 0;
      
      for (var absen in allHistory) {
        if (absen.checkIn != null && absen.checkIn!.startsWith(todayStr)) {
          todayAbsen = absen;
        }
        
        if (absen.status?.toLowerCase() == 'izin') {
          izinCount++;
        } else {
          masukCount++;
        }
      }

      setState(() {
        _user = user;
        _todayAbsen = todayAbsen;
        _totalMasuk = masukCount;
        _totalIzin = izinCount;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  String _formatTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return '--:--';
    try {
      final date = DateTime.parse(dateTimeStr);
      return DateFormat('HH:mm', 'id_ID').format(date);
    } catch (e) {
      return dateTimeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final todayDateStr = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());
    
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Text(
              '${_getGreeting()}, ${_user?.name ?? 'Pengguna'}!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              todayDateStr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 24),
            
            // Today's Attendance Card
            Text(
              'Status Hari Ini',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shadowColor: Colors.blue.withOpacity(0.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: _todayAbsen == null
                    ? const Center(
                        child: Text(
                          'Belum absen hari ini',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('Masuk', style: TextStyle(color: Colors.white70, fontSize: 16)),
                              const SizedBox(height: 8),
                              Text(
                                _formatTime(_todayAbsen!.checkIn),
                                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 50,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          Column(
                            children: [
                              const Text('Pulang', style: TextStyle(color: Colors.white70, fontSize: 16)),
                              const SizedBox(height: 8),
                              Text(
                                _todayAbsen!.checkOut != null ? _formatTime(_todayAbsen!.checkOut) : '--:--',
                                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Statistics Cards
            Text(
              'Statistik Kehadiran',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Total Hadir',
                    count: _totalMasuk,
                    icon: Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Total Izin',
                    count: _totalIzin,
                    icon: Icons.info_outline,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, {required String title, required int count, required IconData icon, required Color color}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700)),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = await _apiService.getProfile();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      // Fallback to local user
      final localUser = await _authService.getUser();
      setState(() {
        _user = localUser;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _authService.clearAll();
      if (mounted) {
        // Navigasi ke halaman login (asumsi named route '/login')
        // Navigator.of(context).pushReplacementNamed('/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil keluar')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 32),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue.shade100,
            child: Icon(Icons.person, size: 60, color: Colors.blue.shade700),
          ),
          const SizedBox(height: 24),
          Text(
            _user?.name ?? 'Nama Pengguna',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _user?.email ?? 'email@example.com',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 48),
          
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Bantuan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Keluar', style: TextStyle(color: Colors.red)),
            onTap: _handleLogout,
          ),
        ],
      ),
    );
  }
}
