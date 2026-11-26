import 'package:flutter/material.dart';
import '../../config/theme.dart';

class StoreSetupScreen extends StatefulWidget {
  const StoreSetupScreen({super.key});

  @override
  State<StoreSetupScreen> createState() => _StoreSetupScreenState();
}

class _StoreSetupScreenState extends State<StoreSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Créer ma boutique', style: TextStyle(color: AppColors.whiteSoft)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Présentation de votre boutique',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.whiteSoft),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Les informations que vous saisirez apparaîtront sur votre vitrine publique.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 32),

                // Nom de la boutique
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: AppColors.whiteSoft),
                  decoration: const InputDecoration(
                    labelText: 'Nom de la boutique',
                    hintText: 'Ex: Chez Fatou - Mode & Accessoires',
                  ),
                  validator: (v) => v!.isEmpty ? 'Donnez un nom à votre boutique' : null,
                ),
                const SizedBox(height: 20),

                // Description
                TextFormField(
                  controller: _descController,
                  maxLines: 4,
                  style: const TextStyle(color: AppColors.whiteSoft),
                  decoration: const InputDecoration(
                    labelText: 'Description (optionnel)',
                    hintText: 'Présentez votre activité en quelques mots...',
                  ),
                ),
                const SizedBox(height: 40),

                // Bouton valider
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Boutique créée avec succès !'), backgroundColor: AppColors.success),
                        );
                      }
                    },
                    child: const Text('Créer ma boutique'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
