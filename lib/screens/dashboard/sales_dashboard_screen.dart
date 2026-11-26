import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';

class SalesDashboardScreen extends StatefulWidget {
  const SalesDashboardScreen({super.key});

  @override
  State<SalesDashboardScreen> createState() => _SalesDashboardScreenState();
}

class _SalesDashboardScreenState extends State<SalesDashboardScreen> {
  final NumberFormat _fcfaFormat = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: 'FCFA',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Ventes & Commandes', style: TextStyle(color: AppColors.whiteSoft)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Période
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ce mois-ci', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Voir tout', style: TextStyle(color: AppColors.gold)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Cartes statistiques
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Chiffre d\'affaires',
                      value: _fcfaFormat.format(0),
                      icon: Icons.attach_money,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Commandes',
                      value: '0',
                      icon: Icons.shopping_bag,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'En attente',
                      value: '0',
                      icon: Icons.schedule,
                      color: AppColors.warning,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Clients',
                      value: '0',
                      icon: Icons.people,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Commandes récentes
              const Text(
                'Commandes récentes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.whiteSoft),
              ),
              const SizedBox(height: 16),

              _buildEmptyOrdersState(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.whiteSoft)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildEmptyOrdersState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: const Column(
        children: [
          Icon(Icons.shopping_bag_outlined, color: Colors.grey, size: 56),
          SizedBox(height: 16),
          Text('Aucune commande pour le moment', style: TextStyle(color: Colors.grey, fontSize: 16)),
          SizedBox(height: 8),
          Text('Vos premières commandes apparaîtront ici', style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}
