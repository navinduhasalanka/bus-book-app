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
                  Color(0xFF540000), // Dark red
                  Color(0xFF880000), // Medium red
                  Color(0xFF9E0000), // Lighter red
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
