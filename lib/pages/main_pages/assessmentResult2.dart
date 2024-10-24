import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 360),
            padding: const EdgeInsets.fromLTRB(27, 32, 27, 84),
            decoration: BoxDecoration(
              color: const Color(0xFFF2E8DC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/00293f90631b6c5e7965e200654e0e2fe71c7c7a36955044cb8a6e73f7591140?placeholderIfAbsent=true&apiKey=d9ab5e89ebd74f84b27c29f6eff51744',
                    width: double.infinity,
                    fit: BoxFit.contain,
                    semanticLabel: 'Assessment completion illustration',
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Assessment Done!',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 240,
                  child: Text(
                    'Based on the assessment, the kind of budgeter you are is',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 75),
                Text(
                  'Kind of User',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 31),
                Container(
                  width: 210,
                  height: 210,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Description descriptiondaadas description description description description gsadkjaj description description description description description description',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    height: 1.42,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 139),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A2A57),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Generate Budget Plans',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFF3E9E9),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}