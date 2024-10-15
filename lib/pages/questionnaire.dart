import 'package:baidyet/components/likert_scale_question.dart';
import 'package:baidyet/components/my_button.dart';
import 'package:flutter/material.dart';

class QuestionnaireWidget extends StatefulWidget {
  const QuestionnaireWidget({Key? key}) : super(key: key);

  @override
  _QuestionnaireWidgetState createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> {
  int _currentQuestionIndex = 0;
  late List<int?> _answers;

  final List<String> questions = [
    "Question No. 1. Question No. 1. Question No. 1.",
    "Question No. 2. Question No. 2. Question No. 2.",
    // Add more questions as needed
  ];

  @override
  void initState() {
    super.initState();
    _answers = List.filled(questions.length, null);
  }

  void _selectAnswer(int value) {
    setState(() {
      _answers[_currentQuestionIndex] = value;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _onComplete();
    }
  }

  void _onComplete() {
    List<int> finalAnswers = _answers.whereType<int>().toList();
    // Handle the completed questionnaire
    print('Answers: $finalAnswers');
    // You can add more logic here, such as navigating to a new page or showing a completion dialog
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EAE2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / questions.length,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 24),

          // Questions
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Opacity(
                  opacity: index == _currentQuestionIndex ? 1.0 : 0.5,
                  child: LikertScaleQuestion(
                    question: questions[index],
                    selectedValue: _answers[index],
                    onSelect:
                        index == _currentQuestionIndex ? _selectAnswer : (_) {},
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Next button
          MyButton(
            onTap:
                _answers[_currentQuestionIndex] != null ? _nextQuestion : null,
            buttonName: "Next →",
          ),
        ],
      ),
    );
  }
}
