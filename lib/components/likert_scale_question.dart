import 'package:flutter/material.dart';

class LikertScaleQuestion extends StatelessWidget {
  final String question;
  final int? selectedValue;
  final Function(int) onSelect;

  const LikertScaleQuestion({
    Key? key,
    required this.question,
    required this.selectedValue,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            return GestureDetector(
              onTap: () => onSelect(index),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedValue == index
                      ? (index < 3
                          ? Colors.green
                          : index > 3
                              ? Colors.red
                              : Colors.grey)
                      : Colors.white,
                  border: Border.all(color: Colors.grey),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Agree', style: TextStyle(color: Colors.green)),
            Text('Disagree', style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 1,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
