import 'package:cartgo/controllers/auth_controller.dart';
import 'package:cartgo/screens/login.dart';
import 'package:cartgo/screens/products_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Consumer<AuthenticationController >(
      builder: (context, authProvider, _) {
        if (authProvider.user != null) {
          // If user is logged in, show the Products Screen
          return const ProductsScreen();
        } else {
          // If user is not logged in, show the Login Screen
          return const LoginScreen();
        }
      },
    );
  }
}
