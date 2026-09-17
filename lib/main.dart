import 'package:flutter/material.dart';
import 'package:flutter_application_2/LAT/latihan_bottom_navigator.dart';
import 'package:flutter_application_2/LAT/latihan_drawer.dart';
import 'package:flutter_application_2/TUGAS/Tugas10/app_form.dart';
import 'package:flutter_application_2/TUGAS/Tugas5/tgs_widget5.dart';
import 'package:flutter_application_2/TUGAS/Tugas7/app_drawer.dart';
import 'package:flutter_application_2/TUGAS/Tugas8/app_nav_bottom.dart';
import 'package:flutter_application_2/TUGAS/Tugas9/screen/model_screen.dart';
import 'package:flutter_application_2/day_15/services/preferenc.dart';

void main() async { 
  await PreferenceHandler();
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
      home: AppForm(),
    );
  }
}
