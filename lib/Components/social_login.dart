import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider(color: Colors.black)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                'or',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.black)),
          ],
        ),
        const SizedBox(height: 19),
        const Text(
          'Log in with',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 11),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/70e7aa34d3d734b2d7b5f6bed3152c3dbce8aec14632c1b2f14f133b61237172?placeholderIfAbsent=true&apiKey=00d7018a335e46bbabd3ad8844351700',
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 20),
            Image.network(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/36d268412356f7c1a949574436bc7e64b12543b1d63e88f1b5c2fea67efeff39?placeholderIfAbsent=true&apiKey=00d7018a335e46bbabd3ad8844351700',
              width: 30,
              height: 30,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Facebook',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: 17),
            Text(
              'Gmail',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
