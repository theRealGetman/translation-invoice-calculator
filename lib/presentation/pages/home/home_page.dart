import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_calculator/presentation/pages/home/bloc/home_cubit.dart';
import 'package:invoice_calculator/presentation/pages/home/widgets/content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..addNewItem(),
      child: const HomePageContent(),
    );
  }
}
