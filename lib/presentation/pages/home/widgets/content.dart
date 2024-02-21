import 'package:flutter/material.dart';
import 'package:invoice_calculator/presentation/pages/home/widgets/table.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Invoice Calculator'),
      ),
      body: const HomeTable(),
    );
  }
}
