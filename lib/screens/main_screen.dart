import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard/home_dashboard.dart';
import 'dashboard/sales_dashboard_screen.dart';
import 'dashboard/products_screen.dart';
import 'dashboard/notifications_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex
