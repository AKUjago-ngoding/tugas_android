import 'package:flutter/material.dart';

class Tugas1 extends StatelessWidget {
  const Tugas1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profil",
          style: TextStyle(
            color: Color.fromARGB(1, 100, 80, 255),
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: 5,
          ),),
      ),
      // body: Padding(padding: padding),
    );
  }
}
