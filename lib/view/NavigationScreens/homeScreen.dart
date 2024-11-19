

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class homeScreen extends StatefulWidget {




  homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  int _currentIndex = 0;
  final _items= [
    SalomonBottomBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
        selectedColor: Colors.green),

    SalomonBottomBarItem(
        icon: Icon(Icons.manage_search_outlined),
        title: Text('Categores'),
        selectedColor: Colors.green
    ),

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
        bottomNavigationBar: Card(color: Colors.white,
          child: SalomonBottomBar(items: _items, currentIndex: _currentIndex,
            onTap: (index)=> setState(() {
              _currentIndex = index;

            }),),
        )



    );
  }
}
