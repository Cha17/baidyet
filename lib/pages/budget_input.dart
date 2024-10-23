import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetInputScreen extends StatefulWidget {
  const BudgetInputScreen({Key? key}) : super(key: key);

  @override
  _BudgetInputScreenState createState() => _BudgetInputScreenState();
}

class ExpenseCategory {
  String name;
  String amount;
  String priority;
  bool flexible;

  ExpenseCategory({
    required this.name,
    this.amount = '',
    this.priority = 'medium',
    this.flexible = true,
  });
}

class _BudgetInputScreenState extends State<BudgetInputScreen> {
  String totalBudget = '';
  String paymentFrequency = 'monthly';
  String savingsGoal = '';
  String newExpenseText = '';
  String? selectedCategory;
  String? selectedExpense;

  List<ExpenseCategory> categories = [
    ExpenseCategory(
        name: 'Bills & Utilities', priority: 'high', flexible: false),
    ExpenseCategory(name: 'Food & Groceries', priority: 'high', flexible: true),
    ExpenseCategory(name: 'Transportation', priority: 'medium', flexible: true),
  ];

  // Predefined expense categories with examples
  final Map<String, List<String>> expenseSuggestions = {
    'Bills & Utilities': [
      'Rent/Mortgage',
      'Electricity Bill',
      'Water Bill',
      'Internet Service',
      'Phone Plan',
      'Cable/Streaming Services',
      'Home Insurance',
      'Property Tax'
    ],
    'Food & Groceries': [
      'Weekly Groceries',
      'Work Lunches',
      'Coffee/Beverages',
      'Dining Out',
      'Food Delivery',
      'Specialty Foods',
      'Pet Food'
    ],
    'Transportation': [
      'Car Payment',
      'Fuel/Gas',
      'Public Transit Pass',
      'Car Insurance',
      'Vehicle Maintenance',
      'Parking Fees',
      'Ride-sharing Services'
    ],
    'Healthcare': [
      'Health Insurance',
      'Medications',
      'Doctor Visits',
      'Dental Care',
      'Vision Care',
      'Fitness Memberships',
      'Mental Health Services'
    ],
    'Personal Care': [
      'Haircuts',
      'Cosmetics',
      'Personal Hygiene',
      'Clothing',
      'Laundry/Dry Cleaning',
      'Spa/Massage'
    ],
    // Add more categories as needed
  };

  void handleNewExpense() {
    if (selectedExpense != null || newExpenseText.trim().isNotEmpty) {
      setState(() {
        categories.add(
          ExpenseCategory(
            name: selectedExpense ?? newExpenseText.trim(),
            priority: 'medium',
            flexible: true,
          ),
        );
        newExpenseText = '';
        selectedExpense = null;
        selectedCategory = null;
      });
    }
  }

  void removeCategory(int index) {
    setState(() {
      categories.removeAt(index);
    });
  }

  double getTotalAllocated() {
    return categories.fold(
        0, (sum, cat) => sum + (double.tryParse(cat.amount) ?? 0));
  }

  double getRemaining() {
    return (double.tryParse(totalBudget) ?? 0) - getTotalAllocated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Planning'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Budget Input Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Total Budget Input
                      _buildLabelWithTooltip(
                        'Total Budget Amount',
                        'Your total income after taxes that\'s available for budgeting',
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // no default icon for the peso, so this is the alternative
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 9),
                            child: Text(
                              '₱',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Enter your total budget',
                        ),
                        onChanged: (value) =>
                            setState(() => totalBudget = value),
                      ),
                      const SizedBox(height: 16),

                      // Payment Frequency
                      _buildLabelWithTooltip(
                        'Payment Frequency',
                        'How often you receive your income',
                      ),
                      DropdownButtonFormField<String>(
                        value: paymentFrequency,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'weekly',
                          'biweekly',
                          'monthly',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => paymentFrequency = value);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Savings Goal
                      _buildLabelWithTooltip(
                        'Savings Goal',
                        'Amount you aim to save each period. Recommended: 20% of your income',
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.savings),
                          border: OutlineInputBorder(),
                          hintText: 'Enter your savings target',
                        ),
                        onChanged: (value) =>
                            setState(() => savingsGoal = value),
                      ),
                      const SizedBox(height: 24),

                      // Expense Categories Section
                      const Text(
                        'Expense Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Category Selection Dropdown
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select Category',
                        ),
                        items: expenseSuggestions.keys.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                            selectedExpense = null;
                          });
                        },
                      ),
                      const SizedBox(height: 8),

                      // Expense Selection Dropdown
                      if (selectedCategory != null)
                        DropdownButtonFormField<String>(
                          value: selectedExpense,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Select Expense',
                          ),
                          items: expenseSuggestions[selectedCategory]!
                              .map((String expense) {
                            return DropdownMenuItem<String>(
                              value: expense,
                              child: Text(expense),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => selectedExpense = value);
                          },
                        ),
                      const SizedBox(height: 8),

                      // Custom Expense Input
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Or enter custom expense...',
                              ),
                              onChanged: (value) =>
                                  setState(() => newExpenseText = value),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: handleNewExpense,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Expense List
                      ...categories.asMap().entries.map((entry) {
                        final index = entry.key;
                        final category = entry.value;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        category.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          prefixText: '\₱',
                                          border: OutlineInputBorder(),
                                        ),
                                        controller: TextEditingController(
                                            text: category.amount),
                                        onChanged: (value) {
                                          setState(() {
                                            categories[index].amount = value;
                                          });
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => removeCategory(index),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: category.priority,
                                        decoration: const InputDecoration(
                                          labelText: 'Priority',
                                        ),
                                        items: ['high', 'medium', 'low']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value.toUpperCase()),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              categories[index].priority =
                                                  value;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: category.flexible,
                                          onChanged: (value) {
                                            if (value != null) {
                                              setState(() {
                                                categories[index].flexible =
                                                    value;
                                              });
                                            }
                                          },
                                        ),
                                        const Text('Flexible'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),

                      // Summary Section
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Allocated:'),
                          Text(
                            '\₱${getTotalAllocated().toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Remaining:'),
                          Text(
                            '\₱${getRemaining().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getRemaining() < 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),

                      if (getRemaining() < 0)
                        Card(
                          color: Colors.red.shade100,
                          margin: const EdgeInsets.only(top: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.warning, color: Colors.red.shade700),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'You have exceeded your total budget by \₱${(-getRemaining()).toStringAsFixed(2)}',
                                    style:
                                        TextStyle(color: Colors.red.shade700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelWithTooltip(String label, String tooltip) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.info_outline, size: 16),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tooltip),
                duration: const Duration(seconds: 3),
              ),
            );
          },
        ),
      ],
    );
  }
}
