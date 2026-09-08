import 'package:flutter/material.dart';
import 'package:flutter_application_2/TUGAS/Tugas3/tgs_widget3.dart';
import 'package:flutter_application_2/TUGAS/Tugas5/tgs_widget5.dart';
import 'package:flutter_application_2/TUGAS/Tugas5/lat_form.dart';

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
      home: const InteraksiPage(),
    );
  }
}
