import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient _client = Supabase.instance.client;

  // Ajouter un produit
  Future<Map<String, dynamic>> addProduct({
    required String storeId,
    required String name,
    String? description,
    required double price,
    required int stock,
    String? imageUrl,
  }) async {
    try {
      final response = await _client.from('products').insert({
        'store_id': storeId,
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'image_url': imageUrl,
      }).select().single();

      return {'success': true, 'data': response};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Récupérer mes produits
  Future<List<dynamic>> getStoreProducts(String storeId) async {
    try {
      final response = await _client
          .from('products')
          .select()
          .eq('store_id', storeId)
          .order('created_at', ascending: false);
      return response;
    } catch (e) {
      return [];
    }
  }

  // Supprimer un produit
  Future<bool> deleteProduct(String productId) async {
    try {
      await _client.from('products').delete().eq('id', productId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
