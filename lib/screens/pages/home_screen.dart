import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top gradient area (100 pixels)
        Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF001f54), // Dark blue
                Color(0xFF003f88), // Medium blue
                Color(0xFF00509e), // Lighter blue
              ],
            ),
          ),
        ),
        // Solid darker color area from 100px down to the bottom
        Expanded(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFd1d0d6), // Darker grey solid color
            child: const Center(
              child: Text(
                'Home screen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
