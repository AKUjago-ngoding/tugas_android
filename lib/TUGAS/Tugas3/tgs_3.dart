import 'dart:io';
void main() {
  print('===== SOAL 1: Bilangan Ganjil 1-20 =====');
  soal1();

  print('\n===== SOAL 2: Cetak Bintang 5x =====');
  soal2();

  print('\n===== SOAL 3: Nama Berulang (while) =====');
  soal3();

  print('\n===== SOAL 4: Loop List Buah (for-in) =====');
  soal4();

  print('\n===== SOAL 5: Daftar Belanja =====');
  soal5();
}

/// Soal 1: Menampilkan bilangan ganjil dari 1 hingga 20
void soal1() {
  for (int i = 1; i <= 20; i += 2) {
    stdout.write(i);
    if (i < 19) stdout.write(', ');
  }
  print('');
}

/// Soal 2: Cetak karakter bintang * sebanyak 5 kali dalam satu baris
void soal2() {
  for (int i = 0; i < 5; i++) {
    stdout.write('* ');
  }
  print('');
}

/// Soal 3: Tampilkan nama sebanyak 4 kali menggunakan while
void soal3() {
  int count = 0;
  while (count < 4) {
    print('Aisyah');
    count++;
  }
}

/// Soal 4: Gunakan for-in untuk mencetak list buah
void soal4() {
  List<String> buah = ['Apel', 'Jeruk', 'Mangga', 'Anggur'];
  for (String item in buah) {
    print('Saya suka $item');
  }
}

/// Soal 5: Simulasi daftar belanja menggunakan loop
void soal5() {
  List<String> belanja = ['Beras', 'Minyak', 'Gula', 'Telur', 'Sabun'];
  for (int i = 0; i < belanja.length; i++) {
    print('Item ke-${i + 1}: ${belanja[i]}');
  }
}