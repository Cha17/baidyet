import 'package:baidyet/components/app_layout.dart';
import 'package:baidyet/components/custom_textfield.dart';
import 'package:baidyet/components/my_button.dart';
import 'package:baidyet/pages/main_pages/home_page.dart';
import 'package:flutter/material.dart';

class BudgetInputScreen extends StatefulWidget {
  const BudgetInputScreen({super.key});

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

  final Map<String, List<String>> expenseSuggestions = {
    'Bills & Utilities': [
      'Rent/Mortgage',
      'Electricity Bill',
      'Water Bill',
      'Internet Service',
      'Phone Plan',
      'Cable/Streaming Services',
    ],
    'Food & Groceries': [
      'Weekly Groceries',
      'Work Lunches',
      'Coffee/Beverages',
      'Dining Out',
      'Food Delivery',
    ],
    'Transportation': [
      'Car Payment',
      'Fuel/Gas',
      'Public Transit Pass',
      'Car Insurance',
      'Vehicle Maintenance',
    ],
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
    return AppLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBudgetSection(),
              const SizedBox(height: 24),
              _buildExpenseSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x4D797B7E),
            Color(0x0D797B7E),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Total Budget Amount',
            tooltip:
                'Your total income after taxes that\'s available for budgeting',
            isNumber: true,
            prefixIcon: const Icon(Icons.attach_money),
            hintText: 'Enter your total budget',
            onChanged: (value) => setState(() => totalBudget = value),
          ),
          const SizedBox(height: 16),
          Text(
            'Payment Frequency',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: paymentFrequency,
            dropdownColor: Colors.grey[200],
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF1A2A57),
                ),
              ),
            ),
            items: ['weekly', 'biweekly', 'monthly'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.toUpperCase()),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) setState(() => paymentFrequency = value);
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Savings Goal',
            tooltip:
                'Amount you aim to save each period. Recommended: 20% of your income',
            isNumber: true,
            prefixIcon: const Icon(Icons.savings),
            hintText: 'Enter your savings target',
            onChanged: (value) => setState(() => savingsGoal = value),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x33929396),
            Color(0x33929396),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 16),

          // Category Selection
          DropdownButtonFormField<String>(
            value: selectedCategory,
            dropdownColor: Colors.grey[200],
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(),
              ),
              hintText: 'Select Category',
              hintStyle: const TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF1A2A57),
                ),
              ),
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

          // Expense Selection
          if (selectedCategory != null)
            DropdownButtonFormField<String>(
              value: selectedExpense,
              dropdownColor: Colors.grey[200],
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Expense',
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1A2A57)),
                ),
              ),
              items:
                  expenseSuggestions[selectedCategory]!.map((String expense) {
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
                child: CustomTextField(
                  hintText: 'Or enter custom expense...',
                  onChanged: (value) => setState(() => newExpenseText = value),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: handleNewExpense,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: const Color(0xFF1A2A57),
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Expense List
          ..._buildExpenseList(),

          const Divider(height: 32, color: Colors.white30),
          MyButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            buttonName: 'Generate Budget Plans',
          )
          // // Summary Section
          // _buildSummarySection(),
        ],
      ),
    );
  }

  List<Widget> _buildExpenseList() {
    return categories.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      icon: const Icon(Icons.delete_rounded,
                          color: Color.fromARGB(255, 177, 39, 29)),
                      onPressed: () => removeCategory(index),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: category.priority,
                      dropdownColor: Colors.grey[50],
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Priority',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      items: ['high', 'medium', 'low'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            categories[index].priority = value;
                          });
                        }
                      },
                    ),
                  ),
                  Checkbox(
                    value: category.flexible,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          categories[index].flexible = value;
                        });
                      }
                    },
                  ),
                  const Text(
                    'Flexible',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              // const SizedBox(height: 12),
              // CustomTextField(
              //   isNumber: true,
              //   prefixIcon: const Icon(Icons.attach_money, size: 16),
              //   controller: TextEditingController(text: category.amount),
              //   onChanged: (value) {
              //     setState(() {
              //       categories[index].amount = value;
              //     });
              //   },
              // ),
            ],
          ),
        ),
      );
    }).toList();
  }

  // Widget _buildSummarySection() {
  //   return Column(
  //     children: [
  //       const Divider(height: 32, color: Colors.white30),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           const Text('Total Allocated:',
  //               style: TextStyle(color: Colors.white)),
  //           Text(
  //             '\$${getTotalAllocated().toStringAsFixed(2)}',
  //             style: const TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 8),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           const Text('Remaining:', style: TextStyle(color: Colors.white)),
  //           Text(
  //             '\$${getRemaining().toStringAsFixed(2)}',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: getRemaining() < 0 ? Colors.red : Colors.green,
  //             ),
  //           ),
  //         ],
  //       ),
  //       if (getRemaining() < 0)
  //         Card(
  //           color: Colors.red.withOpacity(0.2),
  //           margin: const EdgeInsets.only(top: 16),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 const Icon(Icons.warning, color: Colors.red),
  //                 const SizedBox(width: 8),
  //                 Expanded(
  //                   child: Text(
  //                     'You have exceeded your total budget by \$${(-getRemaining()).toStringAsFixed(2)}',
  //                     style: const TextStyle(color: Colors.red),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }
}
