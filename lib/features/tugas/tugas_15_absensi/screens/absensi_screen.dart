import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_2/features/tugas/tugas_15_absensi/services/api_service.dart';
import 'package:dio/dio.dart';

class AbsensiWidget extends StatefulWidget {
  const AbsensiWidget({super.key});

  @override
  State<AbsensiWidget> createState() => _AbsensiWidgetState();
}

class _AbsensiWidgetState extends State<AbsensiWidget> {
  final ApiService _apiService = ApiService();

  Position? _currentPosition;
  String? _currentAddress;
  bool _isLoading = false;
  bool _isGettingLocation = true;

  String _selectedStatus = 'masuk';
  final TextEditingController _alasanController = TextEditingController();

  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _alasanController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!mounted) return;
      if (!serviceEnabled) {
        throw Exception('Layanan lokasi tidak aktif.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Izin lokasi ditolak permanen.');
      }
      if (!mounted) return;

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      String address =
          'Lokasi (${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)})';
      try {
        final geocoding = Geocoding();
        List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (!mounted) return;
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          final parts = [
            place.street,
            place.subLocality,
            place.locality,
            place.postalCode,
            place.country,
          ].where((e) => e != null && e.isNotEmpty).toList();
          if (parts.isNotEmpty) {
            address = parts.join(', ');
          }
        }
      } catch (_) {
        // Fallback: koordinat tetap valid meski reverse geocoding gagal
      }

      setState(() {
        _currentPosition = position;
        _currentAddress = address;
        _isGettingLocation = false;
      });

      if (mounted && _mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isGettingLocation = false;
      });
      _showSnackBar(e.toString(), isError: true);
    }
  }

  Future<void> _handleCheckIn() async {
    if (_currentPosition == null || _currentAddress == null) {
      _showSnackBar('Lokasi belum ditemukan', isError: true);
      return;
    }

    if (_selectedStatus == 'izin' && _alasanController.text.trim().isEmpty) {
      _showSnackBar('Alasan izin harus diisi', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _apiService.checkIn(
        checkInLat: _currentPosition!.latitude,
        checkInLng: _currentPosition!.longitude,
        checkInAddress: _currentAddress!,
        status: _selectedStatus,
        alasanIzin: _selectedStatus == 'izin'
            ? _alasanController.text.trim()
            : null,
      );

      _showSnackBar('Berhasil absen masuk');

      if (_selectedStatus == 'izin') {
        _alasanController.clear();
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      final msg = (data is Map && data['message'] != null)
          ? data['message'].toString()
          : (e.message ?? 'Gagal absen masuk');
      _showSnackBar(msg, isError: true);
    } catch (e) {
      _showSnackBar('Gagal absen masuk: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleCheckOut() async {
    if (_currentPosition == null || _currentAddress == null) {
      _showSnackBar('Lokasi belum ditemukan', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _apiService.checkOut(
        checkOutLat: _currentPosition!.latitude,
        checkOutLng: _currentPosition!.longitude,
        checkOutAddress: _currentAddress!,
      );

      _showSnackBar('Berhasil absen pulang');
    } on DioException catch (e) {
      final data = e.response?.data;
      final msg = (data is Map && data['message'] != null)
          ? data['message'].toString()
          : (e.message ?? 'Gagal absen pulang');
      _showSnackBar(msg, isError: true);
    } catch (e) {
      _showSnackBar('Gagal absen pulang: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Peta Lokasi
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            clipBehavior: Clip.antiAlias,
            child: _isGettingLocation
                ? const Center(child: CircularProgressIndicator())
                : _currentPosition == null
                ? const Center(child: Text('Lokasi tidak tersedia'))
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('current_location'),
                        position: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                      ),
                    },
                    onMapCreated: (controller) => _mapController = controller,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                  ),
          ),
          const SizedBox(height: 16),

          // Info Lokasi Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Lokasi Saat Ini',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_isGettingLocation)
                    const Text('Mengambil lokasi...')
                  else if (_currentAddress != null)
                    Text(_currentAddress!)
                  else
                    const Text(
                      'Gagal mendapatkan alamat',
                      style: TextStyle(color: Colors.red),
                    ),

                  if (_currentPosition != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Lat: ${_currentPosition!.latitude}, Lng: ${_currentPosition!.longitude}',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: _isLoading ? null : _getCurrentLocation,
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Perbarui'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Pilihan Status (Segmented Button)
          Text(
            'Status Kehadiran',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment<String>(
                value: 'masuk',
                label: Text('Hadir'),
                icon: Icon(Icons.work),
              ),
              ButtonSegment<String>(
                value: 'izin',
                label: Text('Izin'),
                icon: Icon(Icons.sick),
              ),
            ],
            selected: {_selectedStatus},
            onSelectionChanged: (Set<String> newSelection) {
              setState(() {
                _selectedStatus = newSelection.first;
              });
            },
          ),
          const SizedBox(height: 16),

          // Form Alasan Izin (Muncul jika status = izin)
          if (_selectedStatus == 'izin') ...[
            TextField(
              controller: _alasanController,
              decoration: const InputDecoration(
                labelText: 'Alasan Izin',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
          ],

          // Tombol Aksi
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _handleCheckIn,
                    icon: const Icon(Icons.login),
                    label: const Text('Absen Masuk'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _selectedStatus == 'izin'
                        ? null
                        : _handleCheckOut,
                    icon: const Icon(Icons.logout),
                    label: const Text('Absen Pulang'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
