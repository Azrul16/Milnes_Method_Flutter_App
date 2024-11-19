import 'package:flutter/material.dart';
import 'milnes_screen.dart';

void main() {
  runApp(const MilnesApp());
}

class MilnesApp extends StatelessWidget {
  const MilnesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milne\'s Method Solver',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MilnesScreen(),
    );
  }
}
