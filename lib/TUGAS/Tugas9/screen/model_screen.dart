import 'package:flutter/material.dart';

import '../model/produk.dart';

class ModelScreen extends StatelessWidget {
  ModelScreen({Key? key}) : super(key: key);

  final List<Produk> produk = [
    Produk(
      nama: 'Apel Fuji',
      gambar: 'https://picsum.photos/seed/apel/200/200',
      deskripsi: 'Apel Fuji segar, manis dan renyah, kaya serat dan vitamin C.',
      harga: 'Rp 35.000 / kg',
    ),
    Produk(
      nama: 'Pisang Cavendish',
      gambar: 'https://picsum.photos/seed/pisang/200/200',
      deskripsi:
          'Pisang Cavendish premium, sumber energi cepat dan kalium tinggi.',
      harga: 'Rp 25.000 / kg',
    ),
    Produk(
      nama: 'Jeruk Baby',
      gambar: 'https://picsum.photos/seed/jeruk/200/200',
      deskripsi: 'Jeruk baby manis tanpa biji, cocok untuk camilan sehat anak.',
      harga: 'Rp 28.000 / kg',
    ),
    Produk(
      nama: 'Semangka Merah',
      gambar: 'https://picsum.photos/seed/semangka/200/200',
      deskripsi:
          'Semangka merah tanpa biji, segar dan menyegarkan di siang hari.',
      harga: 'Rp 15.000 / kg',
    ),
    Produk(
      nama: 'Anggur Import',
      gambar: 'https://picsum.photos/seed/anggur/200/200',
      deskripsi:
          'Anggur merah import, rasanya manis dengan tekstur yang juicy.',
      harga: 'Rp 55.000 / kg',
    ),
    Produk(
      nama: 'Mangga Harum Manis',
      gambar: 'https://picsum.photos/seed/mangga/200/200',
      deskripsi:
          'Mangga harum manis khas Indramayu, matang pohon dan aroma harum.',
      harga: 'Rp 30.000 / kg',
    ),
    Produk(
      nama: 'Stroberi Fresh',
      gambar: 'https://picsum.photos/seed/stroberi/200/200',
      deskripsi: 'Stroberi segar dari Lembang, kaya antioksidan dan vitamin.',
      harga: 'Rp 40.000 / pack',
    ),
    Produk(
      nama: 'Nanas Madu',
      gambar: 'https://picsum.photos/seed/nanas/200/200',
      deskripsi: 'Nanas madu subang, manis legit tanpa rasa asam berlebih.',
      harga: 'Rp 18.000 / buah',
    ),
    Produk(
      nama: 'Pepaya California',
      gambar: 'https://picsum.photos/seed/pepaya/200/200',
      deskripsi:
          'Pepaya california, daging tebal, manis, baik untuk pencernaan.',
      harga: 'Rp 20.000 / buah',
    ),
    Produk(
      nama: 'Melon Golden',
      gambar: 'https://picsum.photos/seed/melon/200/200',
      deskripsi:
          'Melon golden premium, daging tebal berwarna oranye, sangat manis.',
      harga: 'Rp 32.000 / buah',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FUCK!')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
              itemCount: produk.length,
              itemBuilder: (context, index) {
                return ListProduk(produk: produk[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final Produk produk;

  const ListProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            produk.gambar,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(
          produk.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          produk.deskripsi,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          produk.harga,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
