import 'package:flutter/material.dart';
import './preview.dart';
import '../colors/my_colors.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Screen',
          style: TextStyle(color: CustomColors.white),
        ),
        backgroundColor: CustomColors.blue,
      ),
      body: const SingleChildScrollView(
        child: Preview(),
      ),
    );
  }
}
