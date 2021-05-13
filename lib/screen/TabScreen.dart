import 'package:flutter/material.dart';
import 'package:flutter_app_c/screen/HomePage.dart';
import 'package:flutter_app_c/screen/OtpScreen.dart';

class TabsScreen extends StatefulWidget {
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  var _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        "page": HomePage(),
        "title": "Verified Leads",
      },
      {
        "page": OtpScreen(),
        "title": "Add Information",
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _selectedPageIndex == 1
            ? [
                IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed: () {},
                ),
              ]
            : null,
        title: Text(
          _pages[_selectedPageIndex]["title"],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BottomAppBar(
            color: Colors.black54,
            notchMargin: 0.0,
            clipBehavior: Clip.antiAlias,
            shape: CircularNotchedRectangle(),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.white,
              selectedItemColor: Theme.of(context).accentColor,
              currentIndex: _selectedPageIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.collections_bookmark_rounded),
                  label: "Verified Leads",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.add_alert_rounded),
                  label: "Add Information",
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share_rounded),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _pages[_selectedPageIndex]["page"],
    );
  }
}
