import 'package:flutter/material.dart';
import 'package:yatri_cab/presentation/screens/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  void onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      pageIndex = index;
    });
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        backgroundColor: Theme.of(context).primaryColor,
        showUnselectedLabels: true,
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed, // Essential for 4+ items
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: onTabTapped,
        elevation: 2,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            activeIcon: Icon(Icons.home, color: Colors.black),
            icon: Icon(Icons.home, color: Colors.white),
          ),
          BottomNavigationBarItem(
            label: 'My Trip',
            activeIcon: Icon(
              Icons.directions_car_outlined,
              color: Colors.black,
            ),
            icon: Icon(Icons.directions_car_outlined, color: Colors.white),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            activeIcon: Icon(Icons.person, color: Colors.black),
            icon: Icon(Icons.person, color: Colors.white),
          ),
          BottomNavigationBarItem(
            label: 'More',
            activeIcon: Icon(
              Icons.dashboard_customize_outlined,
              color: Colors.black,
            ),
            icon: Icon(Icons.dashboard_customize_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: onPageChanged,
          children: [
            DashboardScreen(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
          ],
        ),
      ),
    );
  }
}
