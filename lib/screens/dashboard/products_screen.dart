import 'package:flutter/material.dart';
import '../../config/theme.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Mes Produits', style: TextStyle(color: AppColors.whiteSoft)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: AppColors.gold, size: 28),
            onPressed: () => _showAddProductModal(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Catalogue',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Liste des produits
              Expanded(
                child: ListView(
                  children: [
                    _buildEmptyState(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inventory_2_outlined, color: Colors.grey, size: 64),
          const SizedBox(height: 16),
          const Text(
            'Aucun produit pour le moment',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => _showAddProductModal(context),
            icon: const Icon(Icons.add, color: AppColors.black),
            label: const Text('Ajouter mon premier produit'),
          ),
        ],
      ),
    );
  }

  void _showAddProductModal(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    final descController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ajouter un produit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.whiteSoft)),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                style: const TextStyle(color: AppColors.whiteSoft),
                decoration: const InputDecoration(labelText: 'Nom du produit'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                style: const TextStyle(color: AppColors.whiteSoft),
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.whiteSoft),
                decoration: const InputDecoration(labelText: 'Prix (FCFA)'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.whiteSoft),
                decoration: const InputDecoration(labelText: 'Quantité en stock'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Produit ajouté !'), backgroundColor: AppColors.success),
                    );
                  },
                  child: const Text('Enregistrer le produit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
