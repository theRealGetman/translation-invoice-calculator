import 'package:flutter/material.dart';
import 'package:invoice_calculator/presentation/pages/home/home_page.dart';

class InvoiceCalculatorApp extends StatelessWidget {
  const InvoiceCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
