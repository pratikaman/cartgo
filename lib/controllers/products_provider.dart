import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cartgo/model/product.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  late bool _isDiscounted;
  late FirebaseRemoteConfig _remoteConfig;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get isDiscounted => _isDiscounted;

  ProductProvider() {
    initRemoteConfig();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body)["products"];
        _products = jsonList.map((json) => Product.fromMap(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> initRemoteConfig() async {

    ///
    _remoteConfig = FirebaseRemoteConfig.instance;

    ///
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));


    ///
    await _remoteConfig.setDefaults(const {
      "isDiscounted": false,
    });

    ///
    _isDiscounted = _remoteConfig.getBool('isDiscounted');

    ///
    await _remoteConfig.fetchAndActivate();
    _isDiscounted = _remoteConfig.getBool('isDiscounted');
    notifyListeners();

    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
      _isDiscounted = _remoteConfig.getBool('isDiscounted');
      notifyListeners();
    });

  }
}