import 'package:baidyet/components/assessment_questions-2.dart';
import 'package:baidyet/components/app_layout.dart';
import 'package:baidyet/pages/budget_input.dart';
import 'package:baidyet/pages/main_pages/assessmentResult.dart';
import 'package:flutter/material.dart';
import 'package:baidyet/components/financial_assessment.dart';

class FinancialAssessment extends StatefulWidget {
  @override
  _FinancialAssessmentState createState() => _FinancialAssessmentState();
}

class _FinancialAssessmentState extends State<FinancialAssessment> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  Map<String, dynamic> assessmentData = {};
  int currentPage = 0;
  int lastAnsweredQuestionIndex = -1;
  static const int questionsPerPage = 10;

  late List<AssessmentQuestion> questions;

  Map<String, String> answers = {};

//Function para sa pagkasubmit pero may error pa ung processAssessment method
  void submitAssessment() async {
    final results = await Financial_Assessment.processAssessment(answers);
    /*print(results);
    final double overallScore = results['overall_score'];*/

    // Navigate to results page with personality profile
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            assessmentResult(results: results, answers: answers),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    questions = AssessmentQuestionService.getAssessmentQuestions();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showDescriptionDialog());
  }

  void _showDescriptionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Financial Assessment'),
          content: const Text(
              'This assessment will help us understand your current financial situation and goals. '
              'It consists of 15 questions about your spending habits, savings, and financial knowledge. '
              'Your answers will be used to provide personalized financial advice and recommendations.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Start Assessment'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  int get totalPages => (questions.length / questionsPerPage).ceil();

  List<AssessmentQuestion> get currentPageQuestions {
    int start = currentPage * questionsPerPage;
    int end = start + questionsPerPage;
    return questions.sublist(
        start, end > questions.length ? questions.length : end);
  }

  Widget _buildQuestionWidget(AssessmentQuestion question, int index) {
    int globalIndex = currentPage * questionsPerPage + index;
    bool isEnabled = globalIndex <= lastAnsweredQuestionIndex + 1;
    double opacity = isEnabled ? 1.0 : 0.5;

    Widget questionWidget;

    switch (question.type) {
      case 'radio':
        questionWidget = Column(
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ...question.options!.map((option) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: _buildCustomRadioButton(
                    option,
                    option == assessmentData['q$globalIndex'],
                    isEnabled
                        ? () {
                            setState(() {
                              assessmentData['q$globalIndex'] = option;
                              _onQuestionAnswered(globalIndex);
                            });
                          }
                        : null,
                  ),
                )),
          ],
        );
        break;
      case 'checkbox':
        questionWidget = Column(
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ...(question.options as List<String>).map((option) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: _buildCustomCheckbox(
                    option,
                    (assessmentData['q$globalIndex']
                            as Map<String, bool>?)?[option] ??
                        false,
                    isEnabled
                        ? (bool? value) {
                            setState(() {
                              assessmentData['q$globalIndex'] = {
                                ...(assessmentData['q$globalIndex']
                                        as Map<String, bool>? ??
                                    {}),
                                option: value ?? false
                              };
                              _onQuestionAnswered(globalIndex);
                            });
                          }
                        : null,
                  ),
                )),
          ],
        );
        break;
      case 'slider':
        questionWidget = Column(
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Slider(
              activeColor: const Color(0xFF1A2A57),
              thumbColor: const Color(0xFF1A2A57),
              value:
                  (assessmentData['q$globalIndex'] as double?) ?? question.min!,
              min: question.min!,
              max: question.max!,
              divisions: question.divisions,
              label:
                  '${((assessmentData['q$globalIndex'] as double?) ?? question.min)?.round()}',
              onChanged: isEnabled
                  ? (double value) {
                      setState(() {
                        assessmentData['q$globalIndex'] = value;
                        _onQuestionAnswered(globalIndex);
                      });
                    }
                  : null,
            ),
            Text(
              '${((assessmentData['q$globalIndex'] as double?) ?? question.min)?.round()}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
        break;
      default:
        questionWidget = const SizedBox.shrink();
    }

    return Opacity(
      opacity: opacity,
      child: IgnorePointer(
        ignoring: !isEnabled,
        child: questionWidget,
      ),
    );
  }

  Widget _buildCustomRadioButton(
      String label, bool isSelected, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1A2A57).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20,
              color: isSelected ? const Color(0xFF1A2A57) : Colors.grey,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF1A2A57) : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCheckbox(
      String label, bool isChecked, ValueChanged<bool?>? onChanged) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged(!isChecked) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isChecked
              ? const Color(0xFF1A2A57).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              size: 20,
              color: isChecked ? const Color(0xFF1A2A57) : Colors.grey,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  void _onQuestionAnswered(int globalIndex) {
    setState(() {
      if (globalIndex > lastAnsweredQuestionIndex) {
        lastAnsweredQuestionIndex = globalIndex;
      }
    });
  }

  void _nextPage() {
    if (currentPage < totalPages - 1) {
      setState(() {
        currentPage++;
      });
      // Scroll to the top of the next page
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      // Process the assessment data
      print(assessmentData);
      // Navigate to the next screen or generate budget plans
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const BudgetInputScreen()),
      );
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  double get progress {
    return (lastAnsweredQuestionIndex + 1) / questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[350],
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF1A2A57)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                children: [
                  ...currentPageQuestions.asMap().entries.map((entry) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildQuestionWidget(entry.value, entry.key),
                          ),
                          if (entry.key < currentPageQuestions.length - 1)
                            const Divider(),
                          const SizedBox(height: 12),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPage > 0)
                        ElevatedButton(
                          onPressed: _previousPage,
                          child: const Text('Previous'),
                        )
                      else
                        const SizedBox(), // Empty SizedBox for spacing when there's no Previous button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A2A57)),
                        onPressed: lastAnsweredQuestionIndex >=
                                    (currentPage + 1) * questionsPerPage - 1 ||
                                (currentPage == totalPages - 1 &&
                                    lastAnsweredQuestionIndex ==
                                        questions.length - 1)
                            ? currentPage == totalPages - 1
                                ? submitAssessment
                                : _nextPage
                            : null,
                        child: Text(
                            style: const TextStyle(color: Color(0xFFE4E4E4)),
                            currentPage == totalPages - 1 ? 'Submit' : 'Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
