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
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    // 🔹 Skala UI responsif
    double scale = screenWidth < 400
        ? 0.9
        : screenWidth < 600
        ? 1.0
        : screenWidth < 900
        ? 1.1
        : 1.25;

    String backgroundImage = widget.category == 'Dart'
        ? 'assets/images/dart_background.png'
        : 'assets/images/c++_background.png';

    final Question currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20 * scale, vertical: 10 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🔹 Header adaptif
                    Container(
                      height: screenHeight * 0.35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(backgroundImage),
                          fit: BoxFit.cover,
                          alignment: const Alignment(0, -0.4),
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20 * scale),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.category} Quiz',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26 * scale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6 * scale),
                                Text(
                                  'Welcome, ${widget.userName}',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16 * scale,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30 * scale),

                    // Kontainer soal responsif
                    Transform.scale(
                      scale: scale <= 1.0 ? 1.0 : 1.05,
                      child: _buildQuestionCard(currentQuestion, scale),
                    ),
                    SizedBox(height: 20 * scale),

                    // Tombol Next responsif
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: ElevatedButton(
                        onPressed:
                        _selectedOptionIndex != null ? _goToNextQuestion : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 55 * scale),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          disabledBackgroundColor: Colors.grey[300],
                        ),
                        child: Text(
                          _currentQuestionIndex == _questions.length - 1
                              ? 'Finish'
                              : 'Next',
                          style: TextStyle(
                              fontSize: 18 * scale, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 40 * scale),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Question question, double scale) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10 * scale),
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double fontScale =
          constraints.maxWidth < 400 ? 0.9 : constraints.maxWidth < 700 ? 1.0 : 1.2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 16 * fontScale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10 * fontScale),
              Text(
                question.questionText,
                style: TextStyle(
                  fontSize: 18 * fontScale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 25 * fontScale),
              ...List.generate(
                question.options.length,
                    (index) {
                  bool isSelected = _selectedOptionIndex == index;
                  return _buildOptionTile(
                    question.options[index],
                    isSelected,
                        () => _onOptionSelected(index),
                    fontScale,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOptionTile(
      String text, bool selected, VoidCallback onTap, double fontScale) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15 * fontScale),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 16 * fontScale,
            vertical: 12 * fontScale,
          ),
          decoration: BoxDecoration(
            color: selected ? Colors.purple[50] : Colors.grey[100],
            border: Border.all(
              color: selected ? Colors.purple : Colors.grey[300]!,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15 * fontScale),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16 * fontScale,
              color: selected ? Colors.purple : Colors.black87,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
