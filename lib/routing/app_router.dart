import 'package:cartgo/screens/home_screen.dart';
import 'package:cartgo/screens/products_screen.dart';
import 'package:cartgo/screens/login.dart';
import 'package:cartgo/screens/signup.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  login,
  signup,
  products,
  home,
}

bool loggedIn = false;

// GoRouter router = GoRouter(
//   initialLocation: loggedIn ? '/home' : '/login',
//   debugLogDiagnostics: false,
//   routes: [
//     GoRoute(
//       path: '/login',
//       name: AppRoute.login.name,
//       builder: (context, state) {
//         return const LoginScreen();
//       },
//     ),
//     GoRoute(
//       path: '/signup',
//       name: AppRoute.signup.name,
//       builder: (context, state) {
//         return const SignUpScreen();
//       },
//     ),
//     GoRoute(
//       path: '/home',
//       name: AppRoute.home.name,
//       builder: (context, state) {
//         return const HomeScreen();
//       },
//     ),
//   ],
// );

GoRouter router = GoRouter(
  initialLocation: '/home',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/home',
      name: AppRoute.home.name,
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/login',
      name: AppRoute.login.name,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      name: AppRoute.signup.name,
      builder: (context, state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: '/products_screen',
      name: AppRoute.products.name,
      builder: (context, state) {
        return const ProductsScreen();
      },
    ),
  ],
);
