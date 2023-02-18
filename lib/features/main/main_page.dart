import 'package:flutter/material.dart';

import '../tours/pages/tours_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;

  final List<Widget> _pages = [
    const ToursPage(),
    const Center(child: Text('test')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedPage,
          children: _pages,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (value) => setState(() => _selectedPage = value),
      currentIndex: _selectedPage,
      items: const [
        BottomNavigationBarItem(
          label: 'My Tours',
          icon: Icon(Icons.map_outlined),
          activeIcon: Icon(Icons.map),
        ),
        BottomNavigationBarItem(
          label: 'Account',
          icon: Icon(Icons.person_outline_outlined),
          activeIcon: Icon(Icons.person),
        ),
      ],
    );
  }
}
