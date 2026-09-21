import 'package:flutter/material.dart';

class Tugas02Widget extends StatelessWidget {
  const Tugas02Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Detail Toko",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
          ),
        ),
        backgroundColor: const Color(0xFF455899),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/profile/qingxiao.jpg'),
              backgroundColor: Colors.black12,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BIG TITLE
              const Wrap(
                children: [
                  Text(
                    "Harmony Music Emporium",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // MESSAGE / WEBSITE SECTION
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.email_outlined, size: 20, color: Colors.deepOrange),
                    SizedBox(width: 8),
                    Text(
                      "contact@harmony.id",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // CONTACT & LOCATION INFO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Phone
                  const Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: Colors.blueAccent),
                      SizedBox(width: 6),
                      Text('0812-1292-3623', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  // Location
                  Row(
                    children: const [
                      Icon(Icons.location_pin, size: 16, color: Colors.redAccent),
                      SizedBox(width: 6),
                      Text(
                        'Jakarta, Indonesia',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // STATS CARDS
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.blue.shade50,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                        child: Column(
                          children: [
                            Text(
                              "300+",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Books Sold / Mo",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      color: Colors.amber.shade50,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                        child: Column(
                          children: [
                            Text(
                              "4.8 / 5.0 ⭐",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Customer Rating",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // DESCRIPTION
              const Text(
                "Harmony Music Emporium menyediakan berbagai alat musik, partitur buku panduan musik, serta aksesoris terbaik untuk mendukung kreativitas bermusik Anda.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
              ),

              const SizedBox(height: 24),

              // STORE BANNER IMAGE
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/profile/bg.png',
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Icon(Icons.music_note, size: 64, color: Colors.blue),
                      ),
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
