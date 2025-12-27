import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/presentation/screens/home_screen.dart';
import 'package:jenosize_loyalty_assignment/features/membership/presentation/screens/membership_screen.dart';
import 'package:jenosize_loyalty_assignment/features/points/presentation/screens/point_transaction_screen.dart';
import '../providers/bottom_nav_provider.dart';

class MainScreen extends ConsumerWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final screens = [
      const HomeScreen(),
      const MembershipScreen(),
      const PointTransactionScreen(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => ref.read(bottomNavIndexProvider.notifier).setIndex(index),
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