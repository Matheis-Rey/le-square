import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/theme.dart';
import '../../services/product_service.dart';
import '../../services/store_service.dart';
import '../../services/auth_service.dart';
import '../../services/storage_service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductService _productService = ProductService();
  final StoreService _storeService = StoreService();
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();
  final ImagePicker _picker = ImagePicker();
  
  List<dynamic> _products = [];
  bool _isLoading = true;
  String? _storeId;

  @override
  void initState() {
    super.initState();
    _loadStoreAndProducts();
  }

  Future<void> _loadStoreAndProducts() async {
    final userId = _authService.currentUser?.id;
    if (userId == null) return;

    final store = await _storeService.getMyStore(userId);
    if (store != null) {
      _storeId = store['id'];
      final products = await _productService.getStoreProducts(_storeId!);
      if (mounted) {
        setState(() {
          _products = products;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _addProduct(String name, String? description, double price, int stock, XFile? imageFile) async {
    if (_storeId == null) return;

    String? imageUrl;
    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      imageUrl = await _storageService.uploadProductImage(
        _storeId!,
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg',
        bytes,
      );
    }

    final result = await _productService.addProduct(
      storeId: _storeId!,
      name: name,
      description: description,
      price: price,
      stock: stock,
      imageUrl: imageUrl,
    );

    if (mounted) {
      if (result['success']) {
        ScaffoldMessenger.of(context
