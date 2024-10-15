import 'package:flutter/material.dart';
import 'package:baidyet/components/likert_scale_question.dart';
import 'package:baidyet/components/my_button.dart';

class QuestionnaireWidget extends StatefulWidget {
  const QuestionnaireWidget({Key? key}) : super(key: key);

  @override
  _QuestionnaireWidgetState createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> {
  int _currentPage = 0;
  late List<List<int?>> _answers;
  String? _errorMessage;
  bool _showQuestionnaire = false;

  final List<List<String>> questionPages = [
    List.generate(
        10, (index) => "Question ${index + 1}. This is question ${index + 1}."),
    List.generate(10,
        (index) => "Question ${index + 11}. This is question ${index + 11}."),
    // Add more pages of 10 questions as needed
  ];

  @override
  void initState() {
    super.initState();
    _answers = List.generate(
      questionPages.length,
      (index) => List.filled(questionPages[index].length, null),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _showInitialDialog());
  }

  void _showInitialDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Assessment Required"),
          content: const Text(
            "We need to assess you so that the AI can create a personal budget plan tailored just for you. "
            "Please make sure you are confident with your answers, as you cannot return to previous pages once you move forward.",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Start Assessment"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _showQuestionnaire = true;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _selectAnswer(int questionIndex, int value) {
    setState(() {
      _answers[_currentPage][questionIndex] = value;
      _errorMessage = null; // Clear error message when an answer is selected
    });
  }

  bool _areAllQuestionsAnswered() {
    return _answers[_currentPage].every((answer) => answer != null);
  }

  void _nextPage() {
    if (_areAllQuestionsAnswered()) {
      if (_currentPage < questionPages.length - 1) {
        setState(() {
          _currentPage++;
          _errorMessage = null;
        });
      } else {
        _onComplete();
      }
    } else {
      setState(() {
        _errorMessage = "Please answer all questions before proceeding.";
      });
    }
  }

  void _onComplete() {
    // Handle the completed questionnaire
    print('All answers: $_answers');
    // You can add more logic here, such as navigating to a new page or showing a completion dialog
  }

  double _calculateProgress() {
    int totalQuestions = questionPages.flatten().length;
    int answeredQuestions =
        _answers.flatten().where((answer) => answer != null).length;
    return answeredQuestions / totalQuestions;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress bar
                LinearProgressIndicator(
                  value: _calculateProgress(),
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF34ACB7)),
                  borderRadius: BorderRadius.circular(12),
                ),
                const SizedBox(height: 30),

                // Questions and Next button
                Expanded(
                  child: ListView.builder(
                    itemCount: questionPages[_currentPage].length +
                        1, // +1 for the Next button
                    itemBuilder: (context, index) {
                      if (index < questionPages[_currentPage].length) {
                        // Question
                        bool isAnswered = _answers[_currentPage][index] != null;
                        bool isFirstUnanswered = !isAnswered &&
                            _answers[_currentPage]
                                .take(index)
                                .every((answer) => answer != null);
                        double opacity =
                            isAnswered || isFirstUnanswered ? 1.0 : 0.5;

                        return LikertScaleQuestion(
                          question: questionPages[_currentPage][index],
                          selectedValue: _answers[_currentPage][index],
                          onSelect: (value) => _selectAnswer(index, value),
                          isEnabled: true,
                          opacity: opacity,
                        );
                      } else {
                        // Next button
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            if (_errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            MyButton(
                              onTap: _nextPage,
                              buttonName:
                                  _currentPage < questionPages.length - 1
                                      ? "Next →"
                                      : "Complete",
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          if (!_showQuestionnaire)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

// Extension method to flatten nested lists
extension ListFlatten<T> on List<List<T>> {
  List<T> flatten() => expand((element) => element).toList();
}
