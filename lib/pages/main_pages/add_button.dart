import 'package:baidyet/components/app_layout.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      child: Center(
        child: Text('Add Page'),
      ),
    );
  }
}