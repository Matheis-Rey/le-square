import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'register_screen.dart';
import '../main_screen.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

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

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: AppColors.whiteSoft),
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) {
                      if (v!.isEmpty) return 'Champ obligatoire';
                      if (!v.contains('@')) return 'Email invalide';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: AppColors.whiteSoft),
                    decoration: const InputDecoration(labelText: 'Mot de passe'),
                    validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);
                          
                          final result = await _authService.signIn(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          setState(() => _isLoading = false);

                          if (result['success']) {
                            if (mounted) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
                            }
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(result['message']), backgroundColor: AppColors.error),
                              );
                            }
                          }
                        }
                      },
                      child: _isLoading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.black, strokeWidth: 2))
                          : const Text('Se connecter'),
                    ),
                  ),
                  const SizedBox(height: 16),

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
