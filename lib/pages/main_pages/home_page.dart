import 'package:baidyet/components/app_layout.dart';
import 'package:baidyet/components/constants/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showBottomNav: true,
      currentIndex: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 24,
                        child: const Icon(Icons.person,
                            color: Colors.grey, size: 30),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
              const SizedBox(height: 24),

              // Budget Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Budget', // Get User's Name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Left to spend for next 15 days',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '₱ 50,000',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(
                            255, 230, 104, 95), // Overspent amount in red
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.8,
                      backgroundColor: Colors.grey,
                      valueColor: const AlwaysStoppedAnimation<Color>(yColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Spent ₱85,000',
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[100]),
                        ),
                        Text(
                          'Limit ₱50,000',
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[100]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Report Card
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Report',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View All',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildReportItem(
                            'Income', '₱ 100,000', Icons.arrow_upward),
                        _buildReportItem(
                            'Expenses', '₱ 85,000', Icons.arrow_downward),
                        _buildReportItem(
                            'Balance', '₱ 44,200', Icons.account_balance),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Commonly Used Section
              const Text(
                'Commonly Used',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCommonItem(
                    'Budget',
                    Icons.bar_chart,
                  ),
                  _buildCommonItem('Saving Plan', Icons.savings),
                  _buildCommonItem('My Budgets', Icons.folder),
                  _buildCommonItem('Category', Icons.grid_view),
                ],
              ),
              const SizedBox(height: 24),

              // AI Insights Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.lightbulb, color: Colors.amber),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Based on your spending habits, you could save ₱403,150 next month by reducing dining out expenses.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildReportItem(String title, String amount, IconData icon) {
  return Column(
    children: [
      Icon(icon, color: Colors.amber),
      const SizedBox(height: 8),
      Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
      const SizedBox(height: 4),
      Text(
        amount,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _buildCommonItem(String title, IconData icon) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.amber),
      ),
      const SizedBox(height: 8),
      Text(
        title,
        style: const TextStyle(fontSize: 12),
      ),
    ],
  );
}
