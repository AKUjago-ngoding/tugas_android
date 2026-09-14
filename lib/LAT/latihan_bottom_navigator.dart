import 'package:flutter/material.dart';

class LatihanBottomNavigator extends StatefulWidget {
  const LatihanBottomNavigator({ Key? key }) : super(key: key);

  @override
  _LatihanBottomNavigatorState createState() => _LatihanBottomNavigatorState();
}

class _LatihanBottomNavigatorState extends State<LatihanBottomNavigator> {

  int _currentIndex = 0;

  final List<Widget> _pages =[
    const Center(
      child: Text('beranda 1'),
    ),
    const Center(
      child: Text('Biling 2'),
    ),
    const Center(
      child: Text('Laporan 3'),
    ),
    const Center(
      child: Text('profil 4', style: TextStyle(fontSize: 50),),
    )
  ];

  void _onTap (int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DRAWER LAT'),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white70,
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Billing'),
            BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Laporan'),
            BottomNavigationBarItem(icon: Icon(Icons.person_sharp), label: 'Profil'),
          ]
        ),
    );
  }
}