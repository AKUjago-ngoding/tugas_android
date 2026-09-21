import 'package:flutter/material.dart';
import 'screens/list_view_screen.dart';
import 'screens/list_map_screen.dart';
import 'screens/model_screen.dart';

class Tugas09HubWidget extends StatelessWidget {
  const Tugas09HubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tugas 9: ListView & Data Model'),
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.list), text: '1. List<String>'),
              Tab(icon: Icon(Icons.map_outlined), text: '2. List<Map>'),
              Tab(icon: Icon(Icons.inventory_2_outlined), text: '3. Model Class'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ListViewScreen(),
            ListMapScreen(),
            ModelScreen(),
          ],
        ),
      ),
    );
  }
}

