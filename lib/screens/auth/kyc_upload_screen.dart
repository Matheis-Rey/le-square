import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/theme.dart';
import '../../services/storage_service.dart';
import '../../services/auth_service.dart';

class KycUploadScreen extends StatefulWidget {
  const KycUploadScreen({super.key});

  @override
  State<KycUploadScreen> createState() => _KycUploadScreenState();
}

class _KycUploadScreenState extends State<KycUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();
  
  XFile? _rectoFile;
  XFile? _versoFile;
  bool _isUploading = false;
  String? _rectoUrl;
  String? _versoUrl;

  Future<void> _pickImage(bool isRecto, ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          if (isRecto) {
            _rectoFile = image;
          } else {
            _versoFile = image;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e'), backgroundColor: AppColors.error),
        );
      }
    }
  }

  Future<void> _uploadDocuments() async {
    if (_rectoFile == null || _versoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez ajouter le recto et le verso'), backgroundColor: AppColors.warning),
      );
      return;
    }

    final userId = _authService.currentUser?.id;
    if (userId == null) return;

    setState(() => _isUploading = true);

    final rectoBytes = await _rectoFile!.readAsBytes();
    final versoBytes = await _versoFile!.readAsBytes();

    _rectoUrl = await _storageService.uploadKycDocument(
      userId,
      'recto.jpg',
      rectoBytes,
    );
    _versoUrl = await _storageService.uploadKycDocument(
      userId,
      'verso.jpg',
      versoBytes,
    );

    setState(() => _isUploading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Documents téléversés avec succès ! ✅'), backgroundColor: AppColors.success),
      );
      Navigator.pop(context);
    }
  }

  void _showImageSourceDialog(bool isRecto) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isRecto ? 'Recto de la CNI' : 'Verso de la CNI',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.whiteSoft),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.gold),
              title: const Text('Prendre une photo', style: TextStyle(color: AppColors.whiteSoft)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(isRecto, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.gold),
              title: const Text('Choisir dans la galerie', style: TextStyle(color: AppColors.whiteSoft)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(isRecto, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

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
              const Text('Étape 1 sur 2', style: TextStyle(color: AppColors.success, fontSize: 14)),
              const SizedBox(height: 8),
              const Text('Téléversez votre CNI', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.whiteSoft)),
              const SizedBox(height: 12),
              const Text('Prenez une photo claire de votre carte d\'identité recto et verso.', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 32),

              // Recto CNI
              _buildUploadCard(
                title: 'Recto de la CNI',
                icon: Icons.photo_front,
                file: _rectoFile,
                onTap: () => _showImageSourceDialog(true),
              ),
              const SizedBox(height: 16),

              // Verso CNI
              _buildUploadCard(
                title: 'Verso de la CNI',
                icon: Icons.photo_back,
                file: _versoFile,
                onTap: () => _showImageSourceDialog(false),
              ),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_rectoFile != null && _versoFile != null && !_isUploading)
                      ? _uploadDocuments
                      : null,
                  child: _isUploading
                      ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          CircularProgressIndicator(color: AppColors.black, strokeWidth: 2),
                          SizedBox(width: 12),
                          Text('Téléversement en cours...'),
                        ])
                      : const Text('Soumettre mes documents'),
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
    required XFile? file,
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
            color: file != null ? AppColors.success : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              file != null ? Icons.check_circle : icon,
              color: file != null ? AppColors.success : AppColors.gold,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: AppColors.whiteSoft, fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              file != null ? file.name : 'Appuyez pour prendre ou choisir une photo',
              style: const TextStyle(color: Colors.grey, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
