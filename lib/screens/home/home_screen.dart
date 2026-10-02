import 'package:flutter/material.dart';
import 'counter_section.dart';
import 'database_section.dart';
import 'top_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            children: [
              TopSection(),
              CounterSection(),
              DatabaseSection(),
            ],
          ),
        ),
      ),
    );
  }
}

