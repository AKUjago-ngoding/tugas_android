import 'package:flutter/material.dart';
import '../models/produk.dart';

class ModelScreen extends StatelessWidget {
  const ModelScreen({super.key});

  static final List<Produk> daftarProduk = [
    const Produk(
      nama: 'Apel Fuji Premium',
      gambar: 'https://picsum.photos/seed/apel/200/200',
      deskripsi: 'Apel Fuji segar, manis dan renyah, kaya serat dan vitamin C.',
      harga: 'Rp 35.000 / kg',
    ),
    const Produk(
      nama: 'Pisang Cavendish',
      gambar: 'https://picsum.photos/seed/pisang/200/200',
      deskripsi: 'Pisang Cavendish premium, sumber energi cepat dan kalium tinggi.',
      harga: 'Rp 25.000 / kg',
    ),
    const Produk(
      nama: 'Jeruk Baby Manis',
      gambar: 'https://picsum.photos/seed/jeruk/200/200',
      deskripsi: 'Jeruk baby manis tanpa biji, cocok untuk camilan sehat anak.',
      harga: 'Rp 28.000 / kg',
    ),
    const Produk(
      nama: 'Semangka Merah Tanpa Biji',
      gambar: 'https://picsum.photos/seed/semangka/200/200',
      deskripsi: 'Semangka merah tanpa biji, manis dan sangat menyegarkan.',
      harga: 'Rp 15.000 / kg',
    ),
    const Produk(
      nama: 'Anggur Merah Import',
      gambar: 'https://picsum.photos/seed/anggur/200/200',
      deskripsi: 'Anggur merah import pilihan, rasanya manis dan juicy.',
      harga: 'Rp 55.000 / kg',
    ),
    const Produk(
      nama: 'Mangga Harum Manis',
      gambar: 'https://picsum.photos/seed/mangga/200/200',
      deskripsi: 'Mangga harum manis matang pohon dengan aroma wangi semerbak.',
      harga: 'Rp 30.000 / kg',
    ),
    const Produk(
      nama: 'Stroberi Fresh Lembang',
      gambar: 'https://picsum.photos/seed/stroberi/200/200',
      deskripsi: 'Stroberi segar dari Lembang, kaya antioksidan dan vitamin C.',
      harga: 'Rp 40.000 / pack',
    ),
    const Produk(
      nama: 'Nanas Madu Subang',
      gambar: 'https://picsum.photos/seed/nanas/200/200',
      deskripsi: 'Nanas madu subang, manis legit tanpa rasa gatal di lidah.',
      harga: 'Rp 18.000 / buah',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendekatan 3: List<Produk> Model'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: daftarProduk.length,
        itemBuilder: (context, index) {
          return ListProdukCard(produk: daftarProduk[index]);
        },
      ),
    );
  }
}

class ListProdukCard extends StatelessWidget {
  final Produk produk;

  const ListProdukCard({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                produk.gambar,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.shopping_basket, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    produk.deskripsi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    produk.harga,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
}

