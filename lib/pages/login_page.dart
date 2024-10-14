import 'package:flutter/material.dart';
import 'package:baidyet/JsonModels/users.dart';
import 'package:baidyet/SQLite/sqlite.dart';
import 'package:baidyet/components/auth_textfield.dart';
import 'package:baidyet/components/my_button.dart';
import 'package:baidyet/pages/home_page.dart';
import 'package:baidyet/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();

  void signUserIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        bool response = await db.login(Users(
          userName: usernameController.text,
          userPassword: passwordController.text,
        ));

        if (response) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          showErrorDialog("Incorrect username or password");
        }
      } catch (e) {
        showErrorDialog("An error occurred. Please try again");
      }
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                          color: Color(0xFF34ACB7),
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
                    "Sign in",
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // password textfield
                  PasswordTextfield(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
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
                    buttonName: "Sign in",
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
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
