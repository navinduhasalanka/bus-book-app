import 'package:flutter/material.dart';

class WelcomeScaffold extends StatelessWidget {
  const WelcomeScaffold({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Use a gradient for the background
          Container(
            width: double.infinity,
            height: double.infinity,
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
          SafeArea(
            child: child!,
          ),
        ],
      ),
    );
  }
}
