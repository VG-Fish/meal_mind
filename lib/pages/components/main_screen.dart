import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../chef/chef.dart';
import '../current/current.dart';
import '../recipes/recipes.dart';
import '../social/social.dart';
import '../today/today.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TodayPage(),
    CurrentPage(),
    ChefPage(),
    RecipesPage(),
    SocialPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
