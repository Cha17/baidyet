import 'package:flutter/material.dart';

class SignupPrompt extends StatelessWidget {
  const SignupPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 199),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/54bd906b6757647505f98baeb484a0add9839db9411f2d5c584ecaf3e3ec0d17?placeholderIfAbsent=true&apiKey=00d7018a335e46bbabd3ad8844351700'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF333333),
            ),
            children: [
              TextSpan(text: "Don't have an account yet? "),
              TextSpan(
                text: 'Sign up',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A2A57),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
