import 'package:cartgo/screens/login.dart';
import 'package:cartgo/screens/products_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(

      /// stream from Firebase Auth that emits events when auth state changes
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {

        /// check if user is authenticated
        if (snapshot.hasData) {
          /// If user is logged in, show the Products Screen
          return const ProductsScreen();
        }
        else {

          /// If user is not logged in, show the Login Screen
          return const LoginScreen();
        }

      },
    );
  }
}
