import 'package:flutter/material.dart';

class Tugas05InteraksiWidget extends StatefulWidget {
  const Tugas05InteraksiWidget({super.key});

  @override
  State<Tugas05InteraksiWidget> createState() => _Tugas05InteraksiWidgetState();
}

class _Tugas05InteraksiWidgetState extends State<Tugas05InteraksiWidget> {
  // Poin 1: ElevatedButton - toggle teks rahasia
  bool _showSecret = false;

  // Poin 2: IconButton - status favorit
  bool _isFavorite = false;

  // Poin 3: TextButton - tampilkan/sembunyikan deskripsi
  bool _showDescription = false;

  // Poin 4: InkWell - status sentuhan
  bool _inkTouched = false;

  // Poin 5 & 6: GestureDetector + FloatingActionButton
  int _counter = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 5: Lab Interaksi & Event'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. ELEVATED BUTTON
            _buildSectionCard(
              title: '1. ElevatedButton (Toggle State)',
              child: Column(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.touch_app),
                    onPressed: () {
                      setState(() {
                        _showSecret = !_showSecret;
                      });
                    },
                    label: Text(_showSecret ? 'Sembunyikan Pesan' : 'Buka Pesan Rahasia'),
                  ),
                  if (_showSecret)
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: const Text(
                        '🎉 Halo, saya Mobile Flutter Developer!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. ICON BUTTON
            _buildSectionCard(
              title: '2. IconButton (Favorite Toggle)',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 44,
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isFavorite ? 'Disukai ❤️' : 'Belum Disukai 🤍',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _isFavorite ? Colors.red : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. TEXT BUTTON
            _buildSectionCard(
              title: '3. TextButton (Expand Description)',
              child: Column(
                children: [
                  TextButton.icon(
                    icon: Icon(_showDescription ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _showDescription = !_showDescription;
                      });
                    },
                    label: Text(_showDescription ? 'Tutup Deskripsi' : 'Lihat Deskripsi Lengkap'),
                  ),
                  if (_showDescription)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        'Ini adalah paragraf deskripsi tambahan yang sebelumnya tersembunyi, dan muncul setelah TextButton ditekan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87, height: 1.4),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 4. INKWELL
            _buildSectionCard(
              title: '4. InkWell (Ripple Effect Visual)',
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          _inkTouched = true;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          alignment: Alignment.center,
                          child: const Text(
                            'Sentuh Kotak Ripple Ini',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_inkTouched)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '✨ Sentuhan terdeteksi via InkWell!',
                        style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 5 & 6. GESTURE DETECTOR + FAB
            _buildSectionCard(
              title: '5. GestureDetector (Tap, Double Tap, Long Press)',
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _counter += 1),
                    onDoubleTap: () => setState(() => _counter += 2),
                    onLongPress: () => setState(() => _counter += 3),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade600,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Text(
                            'Gesture Box',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Nilai Counter: $_counter',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('• Tap: +1', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      Text('• 2x Tap: +2', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      Text('• Hold: +3', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _counter -= 1;
          });
        },
        icon: const Icon(Icons.remove),
        label: const Text('Kurangi Counter (-1)'),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const Divider(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}

