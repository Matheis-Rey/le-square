import 'package:flutter/material.dart';
import '../../config/theme.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Mon Portefeuille', style: TextStyle(color: AppColors.whiteSoft)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Solde principal
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.gold, AppColors.goldDark],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Solde disponible', style: TextStyle(fontSize: 14, color: AppColors.black70)),
                    SizedBox(height: 8),
                    Text('0 FCFA', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.black)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('En attente', style: TextStyle(fontSize: 12, color: AppColors.black70)),
                          Text('0 FCFA', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.black)),
                        ]),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Total gagné', style: TextStyle(fontSize: 12, color: AppColors.black70)),
                          Text('0 FCFA', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.black)),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Bouton Retrait
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.gold,
                    side: const BorderSide(color: AppColors.gold),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Le seuil minimum de 5 000 FCFA est requis pour un retrait'), backgroundColor: AppColors.warning),
                    );
                  },
                  icon: const Icon(Icons.money),
                  label: const Text('Demander un retrait'),
                ),
              ),
              const SizedBox(height: 32),

              // Historique
              const Text(
                'Historique des transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.whiteSoft),
              ),
              const SizedBox(height: 16),

              // Liste vide
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(children: [
                    Icon(Icons.receipt_long, color: Colors.grey, size: 48),
                    SizedBox(height: 12),
                    Text('Aucune transaction', style: TextStyle(color: Colors.grey)),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
