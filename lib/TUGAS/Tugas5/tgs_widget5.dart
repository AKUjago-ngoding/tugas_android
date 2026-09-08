import 'package:flutter/material.dart';

class InteraksiPage extends StatefulWidget {
  const InteraksiPage({super.key});

  @override
  State<InteraksiPage> createState() => _InteraksiPageState();
}

class _InteraksiPageState extends State<InteraksiPage> {
  bool _showSecret = false;
  bool _isFavorite = false;
  bool _showDescription = false;
  bool _inkTouched = false;
  int _counter = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Interaksi Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'ini tentang ElevatedButton:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showSecret = !_showSecret;
                });
              },
              child: const Text('Klik Saya!'),
            ),
            if (_showSecret)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Halo, saya Developer!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

            const SizedBox(height: 24),

            const Text(
              'ini tentang IconButton:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.favorite,
                color: _isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
            Text(_isFavorite ? 'Disukai!' : 'Belum Disukai'),

            const SizedBox(height: 24),

            const Text(
              'ini tentang TextButton:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showDescription = !_showDescription;
                });
              },
              child: const Text('Lihat Deskripsi'),
            ),
            if (_showDescription)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Ini adalah paragraf deskripsi tambahan yang '
                  'sebelumnya tersembunyi, dan muncul setelah '
                  'TextButton ditekan.',
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 24),

            const Text(
              'ini tentang InkWell:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  print('Sentuhan terdeteksi di InkWell (pesan rahasia)');
                  setState(() {
                    _inkTouched = true;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Sentuh Kotak Ini',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            if (_inkTouched)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('Sentuhan terdeteksi!'),
              ),

            const SizedBox(height: 24),

            const Text(
              'ini tentang GestureDetector:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                print('Ditekan sekali');
                setState(() {
                  _counter += 1;
                });
              },
              onDoubleTap: () {
                print('Ditekan dua kali');
                setState(() {
                  _counter += 2;
                });
              },
              onLongPress: () {
                print('Tahan lama');
                setState(() {
                  _counter += 3;
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Angka: $_counter',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('• Tap = +1'),
            const Text('• Double Tap = +2'),
            const Text('• Long Press = +3'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter -= 1;
          });
        },
        child: const Icon(Icons.remove),
      ),
    );
  }
}
