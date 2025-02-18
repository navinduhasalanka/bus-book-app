import 'package:flutter/material.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Use a Scaffold for proper layout
      appBar: AppBar(
        title: const Text('Checkout'), // Add an AppBar
      ),
      body: const Center( // Center the text
        child: Text(
          'This is the checkout page.', // The text you want to display
          style: TextStyle( // Style the text (optional)
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}