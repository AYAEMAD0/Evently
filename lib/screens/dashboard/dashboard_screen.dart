import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:evently/screens/dashboard/tabs/favourite/favourite_tab.dart';
import 'package:evently/screens/dashboard/tabs/home/home_tab.dart';
import 'package:evently/screens/dashboard/tabs/map/map_tab.dart';
import 'package:evently/screens/dashboard/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  final List<IconData> iconSelected = [
    Icons.home,
    Icons.location_on,
    Icons.favorite,
    Icons.person,
  ];

  final List<IconData> iconUnselected = [
    Icons.home_outlined,
    Icons.location_on_outlined,
    Icons.favorite_outline,
    Icons.person_outline,
  ];

  final List tabList = [HomeTab(), MapTab(), FavouriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconSelected.length,
        borderColor:Theme.of(context).cardColor ,
        borderWidth: 3,
        backgroundColor: Theme.of(context).canvasColor,
        activeIndex: selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 25,
        rightCornerRadius: 25,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        tabBuilder: (index, active) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.015,
              horizontal: width * 0.003,
            ),
            child: Column(
              children: [
                Icon(
                  active ? iconSelected[index] : iconUnselected[index],
                  size: 28,
                  color: Theme.of(context).cardColor,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: StadiumBorder(
           side: BorderSide(color: Theme.of(context).cardColor, width: 3),
        ),
        child: Icon(Icons.add, size: 30),
      ),
      body: tabList[selectedIndex],
    );
  }
}
