import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient _client = Supabase.instance.client;
  static const String bucketDocuments = 'documents';
  static const String bucketProducts = 'products';

  // Initialiser les buckets (à faire une fois dans Supabase)
  Future<void> setupBuckets() async {
    try {
      await _client.storage.createBucket(bucketDocuments, public: false);
      await _client.storage.createBucket(bucketProducts, public: true);
    } catch (e) {
      // Les buckets existent probablement déjà
    }
  }

  // Upload une image de CNI
  Future<String?> uploadKycDocument(String userId, String fileName, List<int> fileBytes) async {
    try {
      final path = '$userId/$fileName';
      await _client.storage.from(bucketDocuments).uploadBinary(
            path,
            Uint8List.fromList(fileBytes),
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );
      return _client.storage.from(bucketDocuments).getPublicUrl(path);
    } catch (e) {
      return null;
    }
  }

  // Upload une image de produit
  Future<String?> uploadProductImage(String storeId, String fileName, List<int> fileBytes) async {
    try {
      final path = '$storeId/$fileName';
      await _client.storage.from(bucketProducts).uploadBinary(
            path,
            Uint8List.fromList(fileBytes),
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );
      return _client.storage.from(bucketProducts).getPublicUrl(path);
    } catch (e) {
      return null;
    }
  }
}
