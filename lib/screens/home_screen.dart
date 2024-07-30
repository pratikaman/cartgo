import 'dart:convert';

import 'package:cartgo/product_card.dart';
import 'package:cartgo/constants/app_sizes.dart';
import 'package:cartgo/constants/colors.dart';
import 'package:cartgo/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> jsonList = json.decode(response.body)["products"];
    print(jsonList[0]['thumbnail']);

    return jsonList.map((json) => Product.fromMap(json)).toList();

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: FutureBuilder(
          future: futureProducts,
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}, please try again later.');
            }
        
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: Sizes.p20,
                  crossAxisSpacing: Sizes.p12,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return ProductCard(product: product);
                },
              );
            }
        
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
