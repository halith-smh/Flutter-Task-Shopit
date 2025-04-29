import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../config/api_config.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';

  bool _isLoading_add = false;
  String _statusMessage = '';

  List<Product> get products => [..._products];
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/products'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Product> loadedProducts = [];

        for (var productData in data['products']) {
          loadedProducts.add(Product.fromJson(productData));
        }

        _products = loadedProducts;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = 'Failed to load products. Please try again.';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'An error occurred: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProducts({required Map<String, dynamic> data}) async {
    _isLoading_add = true;
    _statusMessage = '';
    notifyListeners();

    try {
      final res = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      if (res.statusCode == 201) {
        _statusMessage = 'Product added successfully';
        print('oK');
        _isLoading_add = false;
        await fetchProducts();
      } else {
        _statusMessage = 'Error: ${res.statusCode}';
        print(_statusMessage);
      }
    } catch (e) {
      _statusMessage = 'Error: $e';
      print(_statusMessage);
    }
  }

  Future<void> editProducts({
    required Map<String, dynamic> data,
    required productId,
  }) async {
    try {
      final res = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/products/${productId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      if (res.statusCode == 200) {
        print('Product Updated Successfully');
        await fetchProducts();
      } else {
        print('Error happend while updating');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProducts({required String productId}) async {
    notifyListeners();

    try {
      final res = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/products/$productId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode == 200) {
        print('Success: Product Deleted....');
        await fetchProducts();
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
