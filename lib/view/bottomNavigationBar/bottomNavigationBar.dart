import 'package:estoree/view/NavigationScreens/cartScreen.dart';
import 'package:estoree/view/NavigationScreens/categoryScreen.dart';
import 'package:estoree/view/NavigationScreens/homeScreen.dart';
import 'package:estoree/view/NavigationScreens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class bottomNavigationBar extends StatefulWidget {
  bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _homeScreenState();
}

class _homeScreenState extends State<bottomNavigationBar> {
  int _currentIndex = 0;


  final List<Widget> _screens = [
    homeScreen(),
    categoryScreen(),
    cartScreen(),
    profileScreen()
  ];

  final _items = [
    SalomonBottomBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
        selectedColor: Colors.green),
    SalomonBottomBarItem(
        icon: Icon(Icons.manage_search_outlined),
        title: Text('Categories'),
        selectedColor: Colors.green),
    SalomonBottomBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text('Cart'),
        selectedColor: Colors.green),
    SalomonBottomBarItem(
        icon: Icon(Icons.perm_identity),
        title: Text('Profile'),
        selectedColor: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Card(
        color: Colors.white,
        child: SalomonBottomBar(
          items: _items,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
        ),
      ),
    );
  }
}
