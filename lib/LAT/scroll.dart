import 'package:flutter/material.dart';

class Scroll extends StatelessWidget {
  const Scroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("scroll"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Text("HELLO WORLD !"),
                SizedBox(width: 880,),
                Text("INI TEXT PANJANG BANGET LOHHH")
                ]),
            ),
          ],
        ),
      ),
    );
  }
}
