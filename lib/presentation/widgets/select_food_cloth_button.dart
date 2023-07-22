
import 'package:flutter/material.dart';

class SelectFoodClotheButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  SelectFoodClotheButton({
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
