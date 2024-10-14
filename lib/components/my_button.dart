import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xFF2C3E50),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
            child: Text("Sign In",
                style: TextStyle(
                  color: Color.fromARGB(255, 228, 228, 228),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ))),
      ),
    );
  }
}
