import 'package:flutter/material.dart';

class CellCard extends StatelessWidget {
  const CellCard({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
        margin: const EdgeInsets.all(1),
        child: child,
      ),
    );
  }
}
