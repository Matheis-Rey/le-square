import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard/home_dashboard.dart';
import 'dashboard/products_screen.dart';
import 'dashboard/store_setup_screen.dart';
import 'dashboard/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeDashboard(),
    ProductsScreen(),
    StoreSetupScreen(),
    WalletScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
