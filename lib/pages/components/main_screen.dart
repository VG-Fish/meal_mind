import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../chef/chef.dart';
import '../current/current.dart';
import '../recipes/recipes.dart';
import '../social/social.dart';
import '../today/today.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TodayPage(),
    CurrentPage(),
    ChefPage(),
    RecipesPage(),
    SocialPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "Today"),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Current",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic_outlined),
            label: "Chef",
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.silverware),
            label: "Recipes",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Social"),
        ],
      ),
    );
  }
}
