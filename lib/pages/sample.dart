import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Budget',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                // Combined Budget Overview and Breakdown
                _buildCombinedBudgetSection(),
                const SizedBox(height: 20),

                // AI Suggestions and Controls
                _buildAISuggestionSection(),
                const SizedBox(height: 20),

                // Budget Categories Performance
                _buildCategoryPerformance(),
                const SizedBox(height: 20),

                // Recent Transactions
                _buildRecentTransactions(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBudgetSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCombinedBudgetSection() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Monthly Budget',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  '₱90,000',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBudgetStat('Spent', '₱45,000', Colors.red),
                    _buildBudgetStat('Remaining', '₱45,000', Colors.green),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Divider(),
          ),
          // Budget Breakdown
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Monthly Budget Breakdown',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See All'),
                    ),
                  ],
                ),
                _buildBudgetItem('Housing', '₱50,000 - 80,000', 0.7),
                _buildBudgetItem('Food', '₱30,000 - 50,000', 0.5),
                _buildBudgetItem('Transportation', '₱10,000 - 15,000', 0.3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAISuggestionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI Suggestion Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.amber),
                    SizedBox(width: 8),
                    Text(
                      'AI Budget Assistant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Consider allocating 5% more to your savings category to meet your long-term goals.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAIActionButton(
                      'Optimize Budget',
                      Icons.auto_fix_high,
                      () => _showOptimizeBudgetDialog(),
                    ),
                    _buildAIActionButton(
                      'Smart Adjust',
                      Icons.trending_up,
                      () => _showSmartAdjustDialog(),
                    ),
                    _buildAIActionButton(
                      'Get Insights',
                      Icons.lightbulb_outline,
                      () => _showInsightsDialog(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAIActionButton(
      String label, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPerformance() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Category Performance',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildPerformanceChart(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Text('Budget Performance Chart'),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Recent Budget Adjustments',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildTransactionItem(
            'AI Optimized Food Budget',
            '+₱2,000',
            'Recommended adjustment based on spending patterns',
            DateTime.now(),
          ),
          _buildTransactionItem(
            'Smart Savings Allocation',
            '+₱3,000',
            'AI-suggested savings increase',
            DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildBudgetItem(String category, String range, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category),
              Text(range),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      String title, String amount, String reason, DateTime date) {
    return ListTile(
      title: Text(title),
      subtitle: Text(reason),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount,
            style: TextStyle(
              color: amount.startsWith('+') ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${date.day}/${date.month}/${date.year}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetStat(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  // Dialog Methods
  void _showOptimizeBudgetDialog() {
    // Implement AI budget optimization dialog
  }

  void _showSmartAdjustDialog() {
    // Implement smart adjustment dialog
  }

  void _showInsightsDialog() {
    // Implement insights dialog
  }

  void _showAddBudgetSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add New Budget Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Budget Amount',
                border: OutlineInputBorder(),
                prefixText: '₱',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Add Budget Category'),
            ),
          ],
        ),
      ),
    );
  }
}
