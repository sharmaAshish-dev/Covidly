import 'dart:ui';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:covidly/Screens/HomeScreen.dart';
import 'package:covidly/Screens/IndiaUpdatePage.dart';
import 'package:covidly/Screens/NewsUpdatePage.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MoreOptions.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  List<Widget> _screens = [HomeScreen(), IndiaUpdatePage(), NewsUpdatePage(), MoreOptions()];

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onBottomIconPressed(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 60,
        selectedIndex: _selectedIndex,
        showElevation: true,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        backgroundColor: Colors.teal[50],
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController.jumpToPage(index);
        }),
        items: [
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: LightTheme.primaryColor,
          ),
          BottomNavyBarItem(textAlign: TextAlign.center, icon: Icon(Icons.stacked_bar_chart), title: Text('Updates'), activeColor: LightTheme.primaryColor),
          BottomNavyBarItem(textAlign: TextAlign.center, icon: Icon(Icons.description_rounded), title: Text('News'), activeColor: LightTheme.primaryColor),
          BottomNavyBarItem(textAlign: TextAlign.center, icon: Icon(Icons.settings), title: Text('Settings'), activeColor: LightTheme.primaryColor),
        ],
      ),
      body: _activityArea(context),
    );
  }

  Widget _activityArea(context) {
    return PageView(
      controller: _pageController,
      children: _screens,
      pageSnapping: false,
      onPageChanged: _onPageChanged,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
