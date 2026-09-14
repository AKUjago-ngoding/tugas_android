void main() {
  int uts = 85;
  int uas = 90;
  double kehadiran = 0.9;
  double rataRata = (uts + uas) / 2;

  print("Nilai UTS: $uts");
  print("Nilai UAS: $uas");
  print("Kehadiran: ${kehadiran * 100}%");
  print("Rata-rata: $rataRata");

  print("");
  print("=======================");
  print("");

  if (rataRata >= 70 && kehadiran >= 0.75 && (uts >= 60 || uas >= 60)) {
    print("Status Kelulusan: " "LULUS");
  } else {
    print("Status Kelulusan: " "TIDAK LULUS");
  }
}