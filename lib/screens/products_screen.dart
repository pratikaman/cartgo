// import 'dart:convert';

// import 'package:cartgo/product_card.dart';
// import 'package:cartgo/constants/app_sizes.dart';
// import 'package:cartgo/constants/colors.dart';
// import 'package:cartgo/domain/product.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<List<Product>> fetchProducts() async {
//   final response = await http.get(Uri.parse('https://dummyjson.com/products'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     List<dynamic> jsonList = json.decode(response.body)["products"];
//     print(jsonList[0]['thumbnail']);

//     return jsonList.map((json) => Product.fromMap(json)).toList();
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({super.key});

//   @override
//   State<ProductsScreen> createState() => _ProductsScreenState();
// }

// class _ProductsScreenState extends State<ProductsScreen> {
//   late Future<List<Product>> futureProducts;

//   @override
//   void initState() {
//     super.initState();
//     futureProducts = fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'e-Shop',
//           style: TextStyle(
//             color: kWhiteColor,
//             fontWeight: FontWeight.bold,
//             fontSize: Sizes.p20,
//           ),
//         ),
//         backgroundColor: kPrimaryColor,
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.logout,
//               color: kWhiteColor,
//             ),
//             tooltip: "logout",
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(Sizes.p12),
//         child: FutureBuilder(
//           future: futureProducts,
//           builder:
//               (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}, please try again later.');
//             }

//             if (snapshot.hasData) {
//               return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.5,
//                   mainAxisSpacing: Sizes.p20,
//                   crossAxisSpacing: Sizes.p12,
//                 ),
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final product = snapshot.data![index];
//                   return ProductCard(product: product);
//                 },
//               );
//             }

//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:cartgo/shared_components/product_card.dart';
import 'package:cartgo/constants/app_sizes.dart';
import 'package:cartgo/constants/colors.dart';
import 'package:cartgo/domain/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ///
  late Future<List<Product>> futureProducts;

  ///
  late FirebaseRemoteConfig remoteConfig;

  ///
  bool isDiscounted = false;

  ///
  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body)["products"];

      return jsonList.map((json) => Product.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> initRemoteConfig() async {
    remoteConfig = FirebaseRemoteConfig.instance;

    ///
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    ///
    await remoteConfig.setDefaults(const {
      "'isDiscounted'": false,
    });

    ///
    isDiscounted = remoteConfig.getBool('isDiscounted');

    ///
    await remoteConfig.fetchAndActivate();

    ///
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();

      setState(() {
        isDiscounted = remoteConfig.getBool('isDiscounted');
      });
    });
  }

  Future<void> _refreshProducts() async {
    setState(() {
      futureProducts = fetchProducts();
    });
  }

  @override
  void initState() {
    super.initState();

    ///
    initRemoteConfig();
    
    ///
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
        actions: [

          ///
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: kWhiteColor,
            ),
            tooltip: "logout",
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),

      ///
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p12),

          ///
          child: FutureBuilder(
            future: futureProducts,
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              ///
              if (snapshot.hasError) {
                return Center(
                  child:
                      Text('Error: ${snapshot.error}, please try again later.'),
                );
              }

              ///
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
                    return ProductCard(
                        product: product, discountApplied: isDiscounted);
                  },
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
