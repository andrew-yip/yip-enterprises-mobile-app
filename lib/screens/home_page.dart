import 'package:ecommerce_project/services/firebase_services.dart';
import 'package:ecommerce_project/tabs/home_tab.dart';
import 'package:ecommerce_project/tabs/profile_tab.dart';
import 'package:ecommerce_project/tabs/saved_tab.dart';
import 'package:ecommerce_project/tabs/search_tab.dart';
import 'package:ecommerce_project/widgets/navigation_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// home page for all page view items

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseServices _firebaseServices = FirebaseServices();
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // space between each
          children: [
              Expanded(
                child: PageView(
                  controller: _tabsPageController, //how we control and navigate to different pages
                  onPageChanged: (num) {
                    setState(() {
                      _selectedTab = num;
                    });
                  },
                  children: [ // all the tabs that are within page view
                    HomePageTab(), // home page tab
                    SearchPageTab(), // search tab
                    SavedPageTab(), // saved tab
                    ProfilePageTab(), // profile tab
                  ],
                ),
              ),
            NavigationTabs(
              selectedTab: _selectedTab,
              tabPressed: (num) {
                setState(() {
                  _tabsPageController.animateToPage( // to change to different page
                      num,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic);
                });
              },
            ),
          ]
        ),
      ),
    );
  }
}
