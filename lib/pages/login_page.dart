import 'package:baidyet/components/auth_textfield.dart';
import 'package:baidyet/components/my_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // test editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              const Icon(
                Icons.account_balance_wallet_rounded,
                size: 80,
                color: Color(0xFF34ACB7),
              ),
              // Image.asset(
              //   "images/baidyet.png",
              //   width: 200,
              //   height: 200,
              // ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "b",
                    style: TextStyle(
                      color: Color(0xFF2C3E50),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "ai",
                    style: TextStyle(
                      color: Color(0xFFFF7F50),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "dyet",
                    style: TextStyle(
                      fontFamily: 'DancingScript',
                      color: Color(0xFF2C3E50),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Text(
                "Log in",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),
              // username textfield
              AuthTextfield(
                controller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),

              const SizedBox(height: 20),

              // password textfield
              AuthTextfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot passowrd
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 10),

              // // or continue with
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         child: Text(
              //           "or continue with",
              //           style: TextStyle(
              //             color: Colors.grey[700],
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // const SizedBox(height: 40),

              // // google facebook
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // facebook button
              //     SquareTile(imagePath: 'images/facebook.png'),

              //     SizedBox(width: 20),

              //     // google button
              //     SquareTile(imagePath: 'images/google.png'),
              //   ],
              // ),

              // const SizedBox(height: 40),

              // sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet? ",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Register now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
