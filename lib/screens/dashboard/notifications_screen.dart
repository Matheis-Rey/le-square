import 'package:flutter/material.dart';
import '../../config/theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Notifications', style: TextStyle(color: AppColors.whiteSoft)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Tout marquer lu', style: TextStyle(color: AppColors.gold)),
          ),
        ],
      ),
      body: SafeArea(
        child: _buildEmptyNotifications(),
      ),
    );
  }

  Widget _buildEmptyNotifications() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications_none, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            const Text('Pas encore de notifications', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Tu seras informé des nouvelles commandes et mises à jour ici.',
                style: TextStyle(color: Colors.grey, fontSize: 13), textAlign: TextAlign.center),
            const SizedBox(height: 32),
            _buildInfoCard(
              icon: Icons.shopping_bag,
              title: 'Nouvelle commande',
              subtitle: 'Recevez une alerte dès qu\'un client commande',
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              icon: Icons.payment,
              title: 'Paiement confirmé',
              subtitle: 'Soyez notifié quand un paiement est validé',
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              icon: Icons.verified_user,
              title: 'Statut KYC',
              subtitle: 'Suivez l\'état de vérification de vos documents',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.whiteSoft, fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
