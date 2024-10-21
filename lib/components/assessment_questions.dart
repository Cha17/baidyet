class AssessmentQuestion {
  final String question;
  final String type;
  final List<String>? options;
  final double? min;
  final double? max;
  final int? divisions;

  AssessmentQuestion({
    required this.question,
    required this.type,
    this.options,
    this.min,
    this.max,
    this.divisions,
  });
}

List<AssessmentQuestion> getAssessmentQuestions() {
  return [
    AssessmentQuestion(
      question: 'How would you describe your current spending habits?',
      type: 'radio',
      options: [
        'Very frugal',
        'Moderately careful',
        'Somewhat careless',
        'Often overspend'
      ],
    ),
    AssessmentQuestion(
      question:
          'What are your primary financial goals? (Select all that apply)',
      type: 'checkbox',
      options: [
        'Save for emergencies',
        'Pay off debt',
        'Invest for retirement',
        'Save for a major purchase'
      ],
    ),
    AssessmentQuestion(
      question: 'How often do you track your expenses?',
      type: 'radio',
      options: ['Daily', 'Weekly', 'Monthly', 'Rarely or never'],
    ),
    AssessmentQuestion(
      question: 'What percentage of your income do you currently save?',
      type: 'slider',
      min: 0.0,
      max: 50.0,
      divisions: 10,
    ),
    AssessmentQuestion(
      question:
          'How confident are you in your ability to manage your finances?',
      type: 'radio',
      options: [
        'Very confident',
        'Somewhat confident',
        'Not very confident',
        'Not confident at all'
      ],
    ),
    AssessmentQuestion(
      question: 'How do you prefer to manage your budget?',
      type: 'radio',
      options: [
        'Manually',
        'Using a spreadsheet',
        'Using a budgeting app',
        'I don\'t have a budget'
      ],
    ),
    AssessmentQuestion(
      question: 'What is your current level of debt?',
      type: 'slider',
      min: 0.0,
      max: 100000.0,
      divisions: 20,
    ),
    AssessmentQuestion(
      question: 'How often do you review your financial goals?',
      type: 'radio',
      options: ['Monthly', 'Quarterly', 'Annually', 'Never'],
    ),
    AssessmentQuestion(
      question: 'What is your primary source of financial advice?',
      type: 'radio',
      options: [
        'Financial advisor',
        'Online resources',
        'Friends and family',
        'I don\'t seek financial advice'
      ],
    ),
    AssessmentQuestion(
      question: 'How would you rate your overall financial knowledge?',
      type: 'radio',
      options: ['Excellent', 'Good', 'Fair', 'Poor'],
    ),
    AssessmentQuestion(
      question: 'How do you handle unexpected expenses?',
      type: 'radio',
      options: [
        'I have an emergency fund',
        'I use credit cards',
        'I borrow from friends or family',
        'I struggle to cover them'
      ],
    ),
    AssessmentQuestion(
      question: 'What is your current credit score range?',
      type: 'radio',
      options: [
        'Excellent (800-850)',
        'Good (740-799)',
        'Fair (670-739)',
        'Poor (300-669)'
      ],
    ),
    AssessmentQuestion(
      question: 'How often do you review your credit report?',
      type: 'radio',
      options: ['Annually', 'Every few years', 'Rarely', 'Never'],
    ),
    AssessmentQuestion(
      question: 'What is your preferred method of saving?',
      type: 'radio',
      options: [
        'Savings account',
        'Investments',
        'Cash',
        'I don\'t save regularly'
      ],
    ),
    AssessmentQuestion(
      question: 'How do you prioritize your financial goals?',
      type: 'radio',
      options: [
        'Short-term goals first',
        'Long-term goals first',
        'Balance between short-term and long-term',
        'I don\'t have a clear strategy'
      ],
    ),
  ];
}
