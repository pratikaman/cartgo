import 'package:cartgo/home_screen.dart';
import 'package:cartgo/login.dart';
import 'package:cartgo/signup.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  login,
  signup,
  home,
}

bool loggedIn = false;

GoRouter router = GoRouter(
  initialLocation: loggedIn ? '/home' : '/login',
  debugLogDiagnostics: false,
  routes: [
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
      path: '/home',
      name: AppRoute.home.name,
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
  ],
);
