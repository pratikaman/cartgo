import 'package:cartgo/constants/app_sizes.dart';
import 'package:cartgo/constants/colors.dart';
import 'package:cartgo/routing/app_router.dart';
import 'package:cartgo/shared_components/snack_bar.dart';
import 'package:cartgo/shared_components/submit_button.dart';
import 'package:cartgo/utils/email_password_validator.dart';
import 'package:cartgo/utils/string_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with EmailAndPasswordValidators {
  final _loginFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isInProgress = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "e-Shop",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: Sizes.p32,
          ),
        ),
        backgroundColor: kBackgoundColor,
      ),

      ///
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// email field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(Sizes.p8),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) => emailErrorText(email ?? ''),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                inputFormatters: <TextInputFormatter>[
                  ValidatorInputFormatter(
                      editingValidator: EmailEditingRegexValidator()),
                ],
              ),

              ///
              gapH20,

              /// password field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(Sizes.p8),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => passwordErrorText(
                    password ?? '', EmailPasswordSignInFormType.logIn),
                obscureText: true,
                autocorrect: false,
                obscuringCharacter: "●",
                textInputAction: TextInputAction.done,
              ),
              const Spacer(),

              ///
              SubmitBtn(
                text: "Login",
                isInProgress: _isInProgress,
                onPressed: () {
                  // context.goNamed(AppRoute.home.name);
                  signIn();
                },
              ),

              ///
              Container(
                margin: const EdgeInsets.only(top: Sizes.p12),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: Sizes.p20),
                    children: [
                      const TextSpan(
                        text: 'New here? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Signup',
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.goNamed(AppRoute.signup.name);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() {
      _isInProgress = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Error: $e');

      if (mounted) {
        CustomSnackBar.show(
          context,
          message: '${e.message}',
        );
      }
    }
    setState(() {
      _isInProgress = false;
    });
  }
}
