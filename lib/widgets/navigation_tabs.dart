import 'package:ecommerce_project/widgets/tab_btn.dart';
import 'package:flutter/material.dart';

// navigation tabs (the set of all tabs)

class NavigationTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  NavigationTabs({this.selectedTab, this.tabPressed});

  @override
  _NavigationTabsState createState() => _NavigationTabsState();
}

// ALL THE TABS
class _NavigationTabsState extends State<NavigationTabs> {
  int _selectedTab = 0; // default tab selection

  // builds the widget onto the screen

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.6),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          ),
        ]
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TabBtn(
            label: "Home",
            imagePath: "assets/images/home_tap.png",
            selected: _selectedTab == 0 ? true: false, // determines which tab is selected
            onPressed: () {
              setState(() {
                widget.tabPressed(0);
              });
            },
          ),
          TabBtn(
            label: "Search",
            imagePath: "assets/images/search_tap.png",
            selected: _selectedTab == 1 ? true: false,
            onPressed: () {
              setState(() {
                widget.tabPressed(1); // changes the tab
              });
            },
          ),
          TabBtn(
            label: "Saved",
            imagePath: "assets/images/save_tap.png",
            selected: _selectedTab == 2 ? true: false,
            onPressed: () {
              setState(() {
                widget.tabPressed(2);
              });
            },
          ),
          TabBtn(
            label: "Profile",
            imagePath: "assets/images/user_tap.png",
            selected: _selectedTab == 3 ? true: false,
            onPressed: () {
              setState(() {
                widget.tabPressed(3);
              });
            },
          ),
        ]
      ),
    );
  }
}

