import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../services/store_service.dart';
import '../../services/auth_service.dart';
import 'home_dashboard.dart';

class StoreSetupScreen extends StatefulWidget {
  const StoreSetupScreen({super.key});

  @override
  State<StoreSetupScreen> createState() => _StoreSetupScreenState();
}

class _StoreSetupScreenState extends State<StoreSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final StoreService _storeService = StoreService();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _createStore() async {
    if (!_formKey.currentState!.validate()) return;

    final userId = _authService.currentUser?.id;
    if (userId == null) return;

    setState(() => _isLoading = true);

    final result = await _storeService.createStore(
      ownerId: userId,
      name: _nameController.text.trim(),
      description: _descController.text.trim().isNotEmpty ? _descController.text.trim() : null,
    );

    setState(() => _isLoading = false);

    if (mounted) {
      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Boutique créée avec succès ! 🎉'), backgroundColor: AppColors.success),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeDashboard()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Erreur'), backgroundColor: AppColors.error),
        );
      }
    }
  }

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
                const Text('Présentation de votre boutique', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.whiteSoft)),
                const SizedBox(height: 8),
                const Text('Les informations que vous saisirez apparaîtront sur votre vitrine publique.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 32),

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

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _createStore,
                    child: _isLoading
                        ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            CircularProgressIndicator(color: AppColors.black, strokeWidth: 2),
                            SizedBox(width: 12),
                            Text('Création en cours...'),
                          ])
                        : const Text('Créer ma boutique'),
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
