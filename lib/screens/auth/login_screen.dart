import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
                  const Text('Se connecter', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.whiteSoft)),
                  const SizedBox(height: 32),

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
                    validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
                  ),
                  const SizedBox(height: 24),

                  // Bouton
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Connexion en cours...'), backgroundColor: AppColors.success),
                          );
                        }
                      },
                      child: const Text('Se connecter'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Lien inscription
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                    },
                    child: const Text('Pas encore de compte ? S\'inscrire', style: TextStyle(color: AppColors.gold)),
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
