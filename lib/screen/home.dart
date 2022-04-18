// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/screen/login.dart';
import 'package:socially/screen/messages.dart';
import 'package:socially/theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    int _selectedIndex = 0;
    final List _children = [
      MessageScreen(),
      LoginScreen(),
      Center(
        child: Text('Notification'),
      ),
      Center(
        child: Text('Profile'),
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          //showSelectedLabels: false,
          //showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.chat_bubble_2,
              ),
              label: 'Massages',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.alarm,
              ),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.bag_fill,
              ),
              label: 'Call',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      );
  }
}
