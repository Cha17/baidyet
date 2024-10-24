import 'dart:ui';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, required Widget child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        color: Color(0xFFF2E8DC),
        shape: RoundedRectangleBorder(), // Add the required shape parameter
      ),
      child: Stack(
        children: [
          Positioned(
            left: -screenWidth * 0.5,
            top: -screenHeight * 0.01,
            child: SizedBox(
              width: screenWidth * 2,
              height: screenHeight * 1.2,
              child: Stack(
                children: [
                  // 2nd
                  Positioned(
                    left: screenWidth * -0.16,
                    top: screenHeight * 0.1,
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenWidth * 0.7,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFD166),
                        shape: OvalBorder(),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: screenWidth * 0.1,
                            sigmaY: screenWidth * 0.1),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  // bottom
                  Positioned(
                    left: screenWidth * 0.4,
                    top: screenHeight * 0.94,
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenWidth * 0.7,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFD166),
                        shape: OvalBorder(),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: screenWidth * 0.05,
                            sigmaY: screenWidth * 0.05),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  // right top
                  Positioned(
                    left: screenWidth * 1.3,
                    top: screenHeight * -0.1,
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenWidth * 0.7,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFD166),
                        shape: OvalBorder(),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: screenWidth * 0.10,
                            sigmaY: screenWidth * 0.10),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  // third
                  Positioned(
                    left: screenWidth * 1,
                    top: screenHeight * 0.55,
                    child: Container(
                      width: screenWidth * 0.35,
                      height: screenWidth * 0.35,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFD166),
                        shape: OvalBorder(),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: screenWidth * 0.2,
                            sigmaY: screenWidth * 0.25),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
