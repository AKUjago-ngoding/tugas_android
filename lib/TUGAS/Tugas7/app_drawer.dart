import 'package:flutter/material.dart';

class app_Drawer extends StatefulWidget {
  const app_Drawer({Key? key}) : super(key: key);

  @override
  _app_DrawerState createState() => _app_DrawerState();
}

class _app_DrawerState extends State<app_Drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.pink,
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(child: Text('INI HEADER')),

            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('BERANDA'),
              onTap: () => {
                // context.pop();
              },
            )
          ],
        )
      ),
    );
  }
}
