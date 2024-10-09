import 'package:baidyet/Components/login_form.dart';
import 'package:baidyet/Components/signup_prompt.dart';
import 'package:baidyet/Components/social_login.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF2E8DC),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(37, 30, 37, 0),
                child: Column(
                  children: [
                    Image.asset(
                      "images/logo2.png",
                    ),
                    const SizedBox(height: 13),
                    const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 31),
                    const LoginForm(),
                    const SizedBox(height: 19),
                    const SocialLogin(),
                  ],
                ),
              ),
              const SignupPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}
