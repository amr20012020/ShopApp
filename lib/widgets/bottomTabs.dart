import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
 // final int selectedTab;
 // final Function(int) tabPressed;
 // BottomTabs({required this.selectedTab,required this.tabPressed});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {

  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
   // _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1.0,
          ),
        ],
      ),
    );
  }
}


