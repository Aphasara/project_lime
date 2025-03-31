// ignore_for_file: prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lime_app/models/lime.dart';
import 'package:lime_app/models/user.dart';
import 'package:lime_app/views/subviews/profile.dart';
import 'package:lime_app/views/subviews/show_all_lime_ui.dart';
import 'package:lime_app/views/subviews/show_lime_by_date_ui.dart';

class HomeLimeUI extends StatefulWidget {
  User? user;

  HomeLimeUI({
    this.user,
    super.key,
  });

  @override
  State<HomeLimeUI> createState() => _HomeLimeUIState();
}

class _HomeLimeUIState extends State<HomeLimeUI> {
  bool _isLoading = true;
  String _errorMessage = '';
  List<Lime> _moneyList = [];

  int _currentIndex = 1;
  late List _currentShow = [
    
    ShowLimeByDateUI(),
    ShowAllLimeUI(),
    UserProfile(user: widget.user),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentShow[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.redAccent,
        height: 50,
        activeColor: Colors.yellowAccent,
        curveSize: 100,
        items: [
          TabItem(icon: Icons.calendar_month, title: 'Date'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
