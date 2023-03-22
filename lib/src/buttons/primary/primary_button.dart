import 'package:aphrodite/aphrodite.dart';
import 'package:aphrodite/src/buttons/button.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  // The callback when this button is pressed
  final VoidCallback onPressed;

  // The child element inside this button
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,

      // Decoration of the standalone button
      baseDecoration: BoxDecoration(
        color: BetterColours.blue,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
          ),
        ],
      ),

      // Decoration of the button once hovered
      hoverDecoration: BoxDecoration(
        color: BetterColours.blue.shade600,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
          ),
        ],
      ),

      // Decoration of the button when clicked down
      clickDecoration: BoxDecoration(
        color: BetterColours.blue.shade700,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade400,
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),

      // Internal padding of the child
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
