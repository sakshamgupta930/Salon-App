import 'package:flutter/material.dart';
import 'package:salon_app/constants.dart';
import 'package:salon_app/screens/home/cartScreen.dart';
import 'package:salon_app/screens/home/categoryScreen.dart';
import 'package:salon_app/screens/home/homeScreen.dart';
import 'package:salon_app/screens/home/messageScreen.dart';
import 'package:salon_app/screens/home/profileScreen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final _screen = const [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  int initial_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screen[initial_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey[600],
          onTap: (value) {
            setState(() {
              initial_index = value;
            });
          },
          currentIndex: initial_index,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.grid_view_outlined,
                ),
                label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month_outlined,
                ),
                label: "Calendar"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.mode_comment_outlined,
                ),
                label: "Notification"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile")
          ]),
    );
  }
}
