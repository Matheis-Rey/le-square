import 'package:supabase_flutter/supabase_flutter.dart';

class StoreService {
  final SupabaseClient _client = Supabase.instance.client;

  // Créer une boutique
  Future<Map<String, dynamic>> createStore({
    required String ownerId,
    required String name,
    String? description,
  }) async {
    try {
      final response = await _client.from('stores').insert({
        'owner_id': ownerId,
        'name': name,
        'description': description,
        'is_active': true,
      }).select().single();

      return {'success': true, 'data': response};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Récupérer ma boutique
  Future<Map<String, dynamic>?> getMyStore(String ownerId) async {
    try {
      final response = await _client
          .from('stores')
          .select()
          .eq('owner_id', ownerId)
          .maybeSingle();
      return response;
    } catch (e) {
      return null;
    }
  }

  // Vérifier si j'ai une boutique
  Future<bool> hasStore(String ownerId) async {
    final store = await getMyStore(ownerId);
    return store != null;
  }
}
