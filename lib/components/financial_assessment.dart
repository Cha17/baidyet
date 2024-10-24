class Financial_Assessment {
  // Financial personality types
  static const String CONSERVATIVE = 'Conservative';
  static const String MODERATE = 'Moderate';
  static const String AGGRESSIVE = 'Aggressive';
  //Map<String, String> answers = {};
  
  // Assessment categories and their weights
  static const Map<String, double> categoryWeights = {
    'risk_tolerance': 0.3,
    'spending_habits': 0.3,
    'savings_behavior': 0.2,
    'investment_preferences': 0.2,
  };

  static Future<Map<String, dynamic>> processAssessment(Map<String, String> answers) async {
    try {
      //all of these used to be private methods, but i removed the underscore so 
      // Calculate scores for each category
      Map<String, double> categoryScores = calculateCategoryScores(answers);
      
      // Calculate overall score
      double overallScore = calculateOverallScore(categoryScores);
      
      // Determine financial personality
      String personalityType = determinePersonalityType(overallScore);
      
      // Generate recommendations based on personality
      List<String> recommendations = generateRecommendations(personalityType);

      return {
        'personality_type': personalityType,
        'overall_score': overallScore,
        'category_scores': categoryScores,
        'recommendations': recommendations,
      };
    } catch (e) {
      throw Exception('Error processing assessment: $e');
    }
  }

  static Map<String, double> calculateCategoryScores(Map<String, String> answers) {
    Map<String, double> scores = {};
    
    // Process risk tolerance questions
    scores['risk_tolerance'] = _processRiskToleranceScore(answers);
    
    // Process spending habits questions
    scores['spending_habits'] = _processSpendingHabitsScore(answers);
    
    // Process savings behavior questions
    scores['savings_behavior'] = _processSavingsBehaviorScore(answers);
    
    // Process investment preferences questions
    scores['investment_preferences'] = _processInvestmentPreferencesScore(answers);
    
    return scores;
  }

  static double calculateOverallScore(Map<String, double> categoryScores) {
    double totalScore = 0;
    
    categoryScores.forEach((category, score) {
      totalScore += score * (categoryWeights[category] ?? 0);
    });
    
    return totalScore;
  }

  static String determinePersonalityType(double overallScore) {
    if (overallScore < 40) {
      return CONSERVATIVE;
    } else if (overallScore < 70) {
      return MODERATE;
    } else {
      return AGGRESSIVE;
    }
  }

  static double _processRiskToleranceScore(Map<String, String> answers) {
    double score = 0;
    // Add your risk tolerance scoring logic here
    // Example:
    if (answers.containsKey('risk_q1')) {
      score += _convertAnswerToScore(answers['risk_q1']!);
    }
    return score;
  }

  static double _processSpendingHabitsScore(Map<String, String> answers) {
    double score = 0;
    // Add your spending habits scoring logic here
    return score;
  }

  static double _processSavingsBehaviorScore(Map<String, String> answers) {
    double score = 0;
    // Add your savings behavior scoring logic here
    return score;
  }

  static double _processInvestmentPreferencesScore(Map<String, String> answers) {
    double score = 0;
    // Add your investment preferences scoring logic here
    return score;
  }

  static double _convertAnswerToScore(String answer) {
    // Convert Likert scale or multiple choice answers to numerical scores
    // Example implementation:
    switch (answer.toLowerCase()) {
      case 'strongly_disagree':
        return 0;
      case 'disagree':
        return 25;
      case 'neutral':
        return 50;
      case 'agree':
        return 75;
      case 'strongly_agree':
        return 100;
      default:
        return 0;
    }
  }

  static List<String> generateRecommendations(String personalityType) {
    switch (personalityType) {
      case CONSERVATIVE:
        return [
          'Consider low-risk investment options like bonds and fixed deposits',
          'Focus on building an emergency fund',
          'Start with basic budgeting techniques',
        ];
      case MODERATE:
        return [
          'Look into a balanced portfolio of stocks and bonds',
          'Explore automated saving and investing tools',
          'Consider moderate-risk investment options',
        ];
      case AGGRESSIVE:
        return [
          'Research growth stocks and high-yield investments',
          'Consider diversifying into different asset classes',
          'Look into advanced investment strategies',
        ];
      default:
        return ['Create a basic budget', 'Start saving regularly'];
    }
  }
}