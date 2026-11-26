import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.gold, AppColors.goldDark],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('S', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.black), textAlign: TextAlign.center,),
                  ),
                  const SizedBox(height: 16),
                  const Text('Créer un compte', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.whiteSoft)),
                  const SizedBox(height: 32),

                  // Nom complet
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(color: AppColors.whiteSoft),
                    decoration: const InputDecoration(labelText: 'Nom complet'),
                    validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
                  ),
                  const SizedBox(height: 16),

                  // Téléphone
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: AppColors.whiteSoft),
                    decoration: const InputDecoration(labelText: 'Numéro de téléphone'),
                    validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: AppColors.whiteSoft),
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
                  ),
                  const SizedBox(height: 16),

                  // Mot de passe
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: AppColors.whiteSoft),
                    decoration: const InputDecoration(labelText: 'Mot de passe'),
                    validator: (v) => v!.length < 6 ? 'Minimum 6 caractères' : null,
                  ),
                  const SizedBox(height: 24),

                  // Bouton
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Inscription en cours...'), backgroundColor: AppColors.success),
                          );
                        }
                      },
                      child: const Text('S\'inscrire'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Lien connexion
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
                    child: const Text('Déjà un compte ? Se connecter', style: TextStyle(color: AppColors.gold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
