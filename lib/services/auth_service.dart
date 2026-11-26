import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Inscription
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
        },
      );

      if (response.user != null) {
        return {'success': true, 'message': 'Compte créé avec succès'};
      }
      return {'success': false, 'message': 'Erreur lors de l\'inscription'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Connexion
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      return {'success': true, 'message': 'Connexion réussie'};
    } catch (e) {
      return {'success': false, 'message': 'Email ou mot de passe incorrect'};
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // Utilisateur courant
  User? get currentUser => _client.auth.currentUser;
  Stream<AuthState> get authState => _client.auth.onAuthStateChange;
}
