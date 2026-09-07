import 'package:flutter/material.dart';
import 'package:flutter_application_2/TUGAS/Tugas1/tgs_1.dart';
import 'package:flutter_application_2/TUGAS/Tugas1/tgs_widget1.dart';
import 'package:flutter_application_2/TUGAS/Tugas3/tgs_widget3.dart';
import 'package:flutter_application_2/TUGAS/Tugas4/tgs_widget4.dart';
import 'package:flutter_application_2/TUGAS/revisitugas4.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // debugShowCheckedModeBanner: false,
      home: const BiodataPage(),
    );
  }
}
