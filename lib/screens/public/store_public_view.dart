import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';

class StorePublicView extends StatefulWidget {
  final String storeName;
  final String? storeDescription;

  const StorePublicView({
    super.key,
    required this.storeName,
    this.storeDescription,
  });

  @override
  State<StorePublicView> createState() => _StorePublicViewState();
}

class _StorePublicViewState extends State<StorePublicView> {
  final NumberFormat _fcfaFormat = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: 'FCFA',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: CustomScrollView(
        slivers: [
          // En-tête de la boutique
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.gold, AppColors.goldDark],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.storeName,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      if (widget.storeDescription != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.storeDescription!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.black70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Contenu
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Infos boutique
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.gold, size: 18),
                    const SizedBox(width: 8),
                    Text('Côte d\'Ivoire', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle, color: AppColors.success, size: 14),
                          SizedBox(width: 4),
                          Text('Boutique vérifiée', style: TextStyle(color: AppColors.success, fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Catalogue
                const Text(
                  'Catalogue',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.whiteSoft),
                ),
                const SizedBox(height: 16),

                _buildEmptyCatalogue(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCatalogue() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: const Column(
        children: [
          Icon(Icons.storefront_outlined, color: Colors.grey, size: 56),
          SizedBox(height: 16),
          Text('Aucun produit disponible', style: TextStyle(color: Colors.grey, fontSize: 16)),
          SizedBox(height: 8),
          Text('Le vendeur n\'a pas encore ajouté de produit.', style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}
