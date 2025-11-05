import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  final String userName;

  const QuizScreen({
    super.key,
    required this.category,
    required this.userName,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with AutomaticKeepAliveClientMixin {
  final List<Question> _cppQuestions = [
    Question(
      questionText: 'What is the "cout" in C++?',
      options: [
        'A standard output stream',
        'A standard input stream',
        'A standard file stream',
        'A standard data type'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'Which operator is used for pointers?',
      options: ['&', '*', '->', '#'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What does "OOP" stand for?',
      options: [
        'Open-Object Programming',
        'Optimal-Oriented Programming',
        'Operational Object Process',
        'Object-Oriented Programming'
      ],
      correctAnswerIndex: 3,
    ),
    Question(
      questionText: 'Which keyword is used to define a class in C++?',
      options: ['define', 'struct', 'class', 'object'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which of the following is a valid comment in C++?',
      options: [
        '/* This is a comment */',
        '<!-- Comment -->',
        '# This is a comment',
        '** Comment **'
      ],
      correctAnswerIndex: 0,
    ),
  ];

  final List<Question> _dartQuestions = [
    Question(
      questionText: 'What is Dart primarily used for?',
      options: [
        'Web development',
        'Mobile and web apps (with Flutter)',
        'Game development',
        'Data Science'
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What symbol is used to denote string interpolation in Dart?',
      options: ['#', '\$', '&', '%'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Which keyword is used to declare a constant in Dart?',
      options: ['final', 'let', 'const', 'var'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which function is the entry point of a Dart program?',
      options: ['init()', 'start()', 'run()', 'main()'],
      correctAnswerIndex: 3,
    ),
    Question(
      questionText: 'Which data type is used to store true or false values in Dart?',
      options: ['String', 'bool', 'Boolean', 'bit'],
      correctAnswerIndex: 1,
    ),
  ];

  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  int _score = 0;

  List<Question> get _questions =>
      widget.category == 'Dart' ? _dartQuestions : _cppQuestions;

  @override
  bool get wantKeepAlive => true;

  void _onOptionSelected(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _goToNextQuestion() {
    if (_selectedOptionIndex ==
        _questions[_currentQuestionIndex].correctAnswerIndex) {
      _score += 20;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text(
          'Your score: $_score / 100',
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final Question currentQuestion = _questions[_currentQuestionIndex];

    String backgroundImage = widget.category == 'Dart'
        ? 'assets/images/dart_background.png'
        : 'assets/images/c++_background.png';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(size, backgroundImage),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: _buildQuestionCard(currentQuestion),
              ),
            ),
            const SizedBox(height: 10),
            _buildNextButton(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // 🔹 Header
  Widget _buildHeader(Size size, String backgroundImage) {
    return Container(
      height: size.height * 0.40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
          alignment: const Alignment(0, -0.4),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.category} Quiz',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome, ${widget.userName}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // 🔹 lebih dekat ke atas
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${_currentQuestionIndex + 1}/${_questions.length}',
            style: const TextStyle(
              color: Colors.purple,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            question.questionText,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 25),
          ...List.generate(question.options.length, (index) {
            bool isSelected = _selectedOptionIndex == index;
            return _buildOptionTile(
              optionText: question.options[index],
              isSelected: isSelected,
              onTap: () => _onOptionSelected(index),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required String optionText,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple[50] : Colors.grey[100],
            border: Border.all(
              color: isSelected ? Colors.purple : Colors.grey[300]!,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            optionText,
            style: TextStyle(
              color: isSelected ? Colors.purple : Colors.black87,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: _selectedOptionIndex != null ? _goToNextQuestion : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          disabledBackgroundColor: Colors.grey[300],
          shadowColor: Colors.purple.withOpacity(0.4),
          elevation: 6,
        ),
        child: Text(
          _currentQuestionIndex == _questions.length - 1 ? 'Finish' : 'Next',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
