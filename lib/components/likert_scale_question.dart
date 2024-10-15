import 'package:flutter/material.dart';

class LikertScaleQuestion extends StatelessWidget {
  final String question;
  final int? selectedValue;
  final Function(int) onSelect;
  final bool isEnabled;
  final double opacity;

  const LikertScaleQuestion({
    Key? key,
    required this.question,
    required this.selectedValue,
    required this.onSelect,
    required this.isEnabled,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            question,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            textAlign: TextAlign.center,
            // overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              // Calculate size based on distance from center
              double size = 40 - (3 - (index - 3).abs()) * 4;

              return GestureDetector(
                onTap: isEnabled ? () => onSelect(index) : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedValue == index
                            ? (index < 3
                                ? const Color(0xFF37843A)
                                : index > 3
                                    ? const Color(0xFFA32E25)
                                    : Colors.grey)
                            : Colors.white,
                        border: Border.all(color: const Color(0xFFA3E4D7)),
                      ),
                    ),
                    if (selectedValue == index)
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: size * 0.6,
                      ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Agree',
                    style: TextStyle(
                      color: Color(0xFF37843A),
                      fontSize: 12,
                    )),
                Text('Disagree',
                    style: TextStyle(
                      color: Color(0xFFA32E25),
                      fontSize: 12,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Divider
          Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
