import 'package:flutter/material.dart';
import '../widgets/category_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz(String category) {
    String userName = _nameController.text.trim();

    if (userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name first!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          category: category,
          userName: userName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isWide = size.width > 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints:
            const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildHeader(size, isWide),
                  _buildContent(context, isWide),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Bagian Header
  Widget _buildHeader(Size size, bool isWide) {
    return Container(
      height: isWide ? 320 : size.height * 0.45,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/header_bg.png'),
          fit: BoxFit.cover,
          alignment: isWide ? const Alignment(0, -0.25) : Alignment.topCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 48.0 : 24.0,
          vertical: isWide ? 1.0 : 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Your Name :',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Fimelia Anadiba',
                hintStyle: TextStyle(
                  color: Colors.purpleAccent.withOpacity(0.5),
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              style: TextStyle(
                color: Colors.purple[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isWide ? 30 : size.height * 0.05),
          ],
        ),
      ),
    );
  }

  // 🔹 Bagian Konten Bawah
  Widget _buildContent(BuildContext context, bool isWide) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 60.0 : 30.0,
        vertical: isWide ? 40.0 : 30.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CategoryButton(
            title: 'C++',
            imagePath: 'assets/images/cpp_logo.png',
            color: Colors.purple[800]!,
            onTap: () => _startQuiz('C++'),
          ),
          const SizedBox(height: 20),

          CategoryButton(
            title: 'Dart',
            imagePath: 'assets/images/dart_logo.png',
            color: Colors.purple[800]!,
            onTap: () => _startQuiz('Dart'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
