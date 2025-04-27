import 'package:flutter/material.dart';
import 'package:masterpiece_flutter/components/heroSection.dart';
import 'package:masterpiece_flutter/pages/attendance.dart';

class MainPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const MainPage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HeroSection(), Attendance()];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFeeeeee),
        title: const Text('LMC', style: TextStyle(color: Color(0xFFeeeeee))),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Attendance',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
