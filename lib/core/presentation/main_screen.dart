import 'package:flutter/material.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/presentation/screens/home_screen.dart';
import 'package:jenosize_loyalty_assignment/features/membership/presentation/screens/membership_screen.dart';
import 'package:jenosize_loyalty_assignment/features/points/presentation/point_transaction_screen.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MembershipScreen(),
    PointTransactionScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Membership',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: 'Points',
          ),
        ]
      ),
    );
  }
}