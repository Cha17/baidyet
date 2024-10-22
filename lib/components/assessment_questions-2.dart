// Financial personality dimensions and scoring system
class FinancialTraitScore {
  double spenderSaver = 0; // -1 (Spender) to 1 (Saver)
  double riskTolerance = 0; // -1 (Conservative) to 1 (Aggressive)
  double planningStyle = 0; // -1 (Spontaneous) to 1 (Methodical)
  double financialAwareness = 0; // -1 (Novice) to 1 (Expert)
}

enum FinancialPersonality {
  conservativePlanner,
  balancedBuilder,
  riskTaker,
  spontaneousSpender,
  wealthMaximizer,
  securitySeeker
}

class AssessmentQuestion {
  final String id;
  final String category;
  final String question;
  final List<String>? options;  // Added to store the options
  final Map<String, double> scoreMapping;
  final String type;
  final double? min;
  final double? max;
  final int? divisions;

  AssessmentQuestion({
    required this.id,
    required this.category,
    required this.question,
    required this.type,
    this.min,
    this.max,
    this.divisions,
    required this.scoreMapping,
  }) : options = scoreMapping.keys.toList();  // Automatically create options from scoreMapping keys
}

class AssessmentQuestionService {
  // Make this static so it can be accessed directly
  static List<AssessmentQuestion> getAssessmentQuestions() {
    return [
      AssessmentQuestion(
        id: 'spending_1',
        category: 'spending',
        question: 'How do you typically handle unexpected income?',
        type: 'radio',
        scoreMapping: {
          'Save it immediately': 1.0,
          'Save most, spend some': 0.5,
          'Spend most, save some': -0.5,
          'Spend it immediately': -1.0,
        },
      ),
      AssessmentQuestion(
        id: 'spending_2',
        category: 'spending',
        question: 'How often do you make impulse purchases?',
        type: 'radio',
        scoreMapping: {
          'Never': 1.0,
          'Rarely': 0.5,
          'Sometimes': -0.5,
          'Frequently': -1.0,
        },
      ),
      AssessmentQuestion(
        id: 'risk_1',
        category: 'risk',
        question: 'How would you react to a 20% drop in your investments?',
        type: 'radio',
        scoreMapping: {
          'Buy more while prices are low': 1.0,
          'Hold and wait it out': 0.5,
          'Sell some to prevent further losses': -0.5,
          'Sell everything immediately': -1.0,
        },
      ),
      AssessmentQuestion(
        id: 'risk_2',
        category: 'risk',
        question: 'What\'s your preferred investment approach?',
        type: 'radio',
        scoreMapping: {
          'High-risk, high-reward': 1.0,
          'Moderate risk and returns': 0.5,
          'Low-risk, steady returns': -0.5,
          'No risk, guaranteed returns': -1.0,
        },
      ),
      // Add more questions as needed
    ];
  }

  // Optional: If you still want to get questions by category
  static Map<String, List<AssessmentQuestion>> getQuestionsByCategories() {
    final allQuestions = getAssessmentQuestions();
    final Map<String, List<AssessmentQuestion>> categorizedQuestions = {};
    
    for (var question in allQuestions) {
      if (!categorizedQuestions.containsKey(question.category)) {
        categorizedQuestions[question.category] = [];
      }
      categorizedQuestions[question.category]!.add(question);
    }
    
    return categorizedQuestions;
  }
}


class Question {
  final String text;
  final Map<String, double> scoreMapping;

  const Question(this.text, this.scoreMapping);
}


