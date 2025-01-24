import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final void Function() ? onPressed;

  const PrimaryButton({required this.label,this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: Theme.of(context).colorScheme.primary,
          minimumSize: Size(double.infinity, 45)),
    );
  }
}
