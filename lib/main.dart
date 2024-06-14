import 'package:flutter/material.dart';
import 'package:invoice_calculator/data/local_storage/work_item_storage.dart';
import 'package:invoice_calculator/presentation/app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    Provider<WorkItemStorage>(
      create: (context) => WorkItemStorage(sharedPreferences),
      child: const InvoiceCalculatorApp(),
    ),
  );
}
