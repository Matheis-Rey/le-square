import 'package:flutter/material.dart';
import '../../config/theme.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Mon Espace', style: TextStyle(color: AppColors.whiteSoft)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.gold),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bienvenue
              const Text(
                'Bienvenue 👋',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.whiteSoft),
              ),
              const Text(
                'Voici l\'état de votre activité',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Cartes statistiques
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Ventes',
                      value: '0',
                      icon: Icons.shopping_cart,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Solde',
                      value: '0 FCFA',
                      icon: Icons.wallet,
                      color: AppColors.gold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Actions rapides
              const Text(
                'Actions rapides',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.whiteSoft),
              ),
              const SizedBox(height: 16),

              _buildActionCard(
                icon: Icons.add_box,
                title: 'Ajouter un produit',
                subtitle: 'Mettez un nouvel article en vente',
                onTap: () {},
              ),
              const SizedBox(height: 12),

              _buildActionCard(
                icon: Icons.inventory_2,
                title: 'Mes produits',
                subtitle: 'Gérez votre catalogue',
                onTap: () {},
              ),
              const SizedBox(height: 12),

              _buildActionCard(
                icon: Icons.account_balance_wallet,
                title: 'Mon portefeuille',
                subtitle: 'Consultez vos gains et retraits',
                onTap: () {},
              ),
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
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.whiteSoft)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.gold, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.whiteSoft)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
