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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with EmailAndPasswordValidators {
  ///
  final _signUpFormKey = GlobalKey<FormState>();

  ///
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isInProgress = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
          key: _signUpFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(Sizes.p8),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (text.length < 4) {
                    return 'Too short';
                  }
                  return null;
                },
              ),

              ///
              gapH20,

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
                    password ?? '', EmailPasswordSignInFormType.register),
                obscureText: true,
                autocorrect: false,
                obscuringCharacter: "●",
                textInputAction: TextInputAction.done,
              ),
              const Spacer(),

              ///
              SubmitBtn(
                text: "Signup",
                isInProgress: _isInProgress,
                onPressed: () {
                  signUp();
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
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.goNamed(AppRoute.login.name);
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

  Future<void> signUp() async {
    if (!_signUpFormKey.currentState!.validate()) return;

    ///
    setState(() {
      _isInProgress = true;
    });

    ///
    try {
      UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // The user is now signed in, which will trigger authStateChanges
      User? user = userCredential.user;

      ///
      if (user != null && mounted) {
        context.goNamed(AppRoute.products.name);
      }

    } on FirebaseAuthException catch (e) {
      debugPrint('Error: $e');

      if (mounted) {
        CustomSnackBar.show(
          context,
          message: '${e.message}',
        );
      }
    }

    ///
    setState(() {
      _isInProgress = false;
    });
  }
}
