// 

import 'package:cartgo/controllers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cartgo/controllers/auth_controller.dart';
import 'package:cartgo/shared_components/product_card.dart';
import 'package:cartgo/constants/app_sizes.dart';
import 'package:cartgo/constants/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'e-Shop',
          style: TextStyle(
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontSize: Sizes.p20,
          ),
        ),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: kWhiteColor,
            ),
            tooltip: "logout",
            onPressed: () {
              Provider.of<AuthenticationController>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {

          ///
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          ///
          if (productProvider.products.isEmpty) {
            return const Center(child: Text('No products available'));
          }


          ///
          return RefreshIndicator(
            onRefresh: () => productProvider.fetchProducts(),
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: Sizes.p20,
                  crossAxisSpacing: Sizes.p12,
                ),
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  final product = productProvider.products[index];
                  return ProductCard(
                    product: product,
                    discountApplied: productProvider.isDiscounted,
                  );
                },
              ),
            ),
          );

          
        },
      ),
    );
  }
}