import 'package:flutter/material.dart';
import '../../config/theme.dart';

class KycUploadScreen extends StatefulWidget {
  const KycUploadScreen({super.key});

  @override
  State<KycUploadScreen> createState() => _KycUploadScreenState();
}

class _KycUploadScreenState extends State<KycUploadScreen> {
  bool _rectoUploaded = false;
  bool _versoUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Vérification d\'identité', style: TextStyle(color: AppColors.whiteSoft)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Étape 1 sur 2',
                style: TextStyle(color: AppColors.success, fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                'Téléversez votre CNI',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.whiteSoft),
              ),
              const SizedBox(height: 12),
              const Text(
                'Nous avons besoin de votre carte nationale d\'identité pour valider votre compte.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Recto CNI
              _buildUploadCard(
                title: 'Recto de la CNI',
                icon: Icons.photo_front,
                isUploaded: _rectoUploaded,
                onTap: () => setState(() => _rectoUploaded = true),
              ),
              const SizedBox(height: 16),

              // Verso CNI
              _buildUploadCard(
                title: 'Verso de la CNI',
                icon: Icons.photo_back,
                isUploaded: _versoUploaded,
                onTap: () => setState(() => _versoUploaded = true),
              ),
              const Spacer(),

              // Bouton continuer
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_rectoUploaded && _versoUploaded)
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Document en cours de vérification...'), backgroundColor: AppColors.success),
                          );
                        }
                      : null,
                  child: const Text('Soumettre'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard({
    required String title,
    required IconData icon,
    required bool isUploaded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUploaded ? AppColors.success : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              isUploaded ? Icons.check_circle : icon,
              color: isUploaded ? AppColors.success : AppColors.gold,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(color: AppColors.whiteSoft, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              isUploaded ? 'Fichier téléversé' : 'Appuyez pour choisir une photo',
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
