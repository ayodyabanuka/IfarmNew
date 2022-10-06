import 'package:flutter/material.dart';

import 'package:ifarm/Screens/AB/Home.dart';
import 'package:ifarm/Screens/AB/Profile.dart';
import 'package:ifarm/Screens/AB/settings.dart';
import 'package:ifarm/Screens/AB/shop.dart';

class Navbar extends StatefulWidget {
  Navbar({
    Key? key,
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff024F8E),
      appBar: AppBar(
        title: const SizedBox(
            width: 100,
            child: Image(
                image: AssetImage(
              'assets/images/IFarm_Logo_White.png',
            ))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: buildPages(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(150, 6, 91, 161),
        type: BottomNavigationBarType.fixed,
        elevation: 1,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Buy', icon: Icon(Icons.shopping_bag)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings))
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildPages() {
    switch (_selectedIndex) {
      case 1:
        return shop();
      case 2:
        return profile();
      case 3:
        return settings();

      case 0:
      default:
        return Home();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
