import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationController extends ChangeNotifier {
  AuthenticationController() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoginInProgress = false;
  bool _isSignUpInProgress = false;

  User? get user => _user;

  bool get isLoginInProgress => _isLoginInProgress;
  bool get isSignUpInProgress => _isSignUpInProgress;

  void setLoginInProgress(bool value) {
    _isLoginInProgress = value;
    notifyListeners();
  }

  void setSignUpInProgress(bool value) {
    _isSignUpInProgress = value;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    ///
    setLoginInProgress(true);

    /// sign in with email and password
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      ///
      setLoginInProgress(false);
      rethrow;
    }

    ///
    setLoginInProgress(false);
  }

  Future<void> signUp(String email, String password) async {
    ///
    setSignUpInProgress(true);

    /// sign up with email and password
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      ///
      setSignUpInProgress(false);
      rethrow;
    }

     ///
    setSignUpInProgress(false);
  }

}
