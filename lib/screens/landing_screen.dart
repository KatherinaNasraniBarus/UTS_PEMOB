import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isWide = size.width > 700;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8F5BE3),
              Color(0xFFA76AE4),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: isWide ? 200 : 120,
                      height: isWide ? 200 : 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 30),

                    Text(
                      'Welcome to DevQuiz',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: isWide ? 32 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'Test your knowledge in C++ and Dart!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: isWide ? 18 : 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 50),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A4ED3),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: isWide ? 50 : 30,
                          vertical: isWide ? 20 : 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadowColor: Colors.black45,
                        elevation: 6,
                      ),
                      child: Text(
                        'Start Quiz',
                        style: GoogleFonts.poppins(
                          fontSize: isWide ? 20 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
