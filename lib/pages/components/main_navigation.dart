import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../chef/chef.dart';
import '../current/current.dart';
import '../recipes/recipes.dart';
import '../social/social.dart';
import '../today/today.dart';
import 'state/main_navigation_state.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationState>(
      builder: (context, navigationState, _) {
        final pages = [
          TodayPage(),
          CurrentPage(),
          ChefPage(),
          RecipesPage(),
          SocialPage(),
        ];

        return Scaffold(
          body: IndexedStack(
            index: navigationState.selectedIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationState.selectedIndex,
            onTap: (index) {
              navigationState.selectedIndex = index;
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
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "Social",
              ),
            ],
          ),
        );
      },
    );
  }
}
