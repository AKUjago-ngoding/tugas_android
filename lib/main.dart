import 'package:flutter/material.dart';
import 'package:flutter_application_2/LAT/latihan_bottom_navigator.dart';
import 'package:flutter_application_2/LAT/latihan_drawer.dart';
import 'package:flutter_application_2/TUGAS/Tugas5/tgs_widget5.dart';
import 'package:flutter_application_2/TUGAS/Tugas7/app_drawer.dart';

// import 'package:flutter_application_2/TUGAS/task_layout.dart';
// import 'package:flutter_application_2/TUGAS/tugas1.dart';
// import 'package:flutter_application_2/TUGAS/tugas2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Standard Input & Event',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LatihanDrawer(),
    );
  }
}
