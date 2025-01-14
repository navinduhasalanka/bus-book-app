import 'package:flutter/material.dart';
import 'ticket_view.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Debug TicketView")),
      body: Center(
        child: TicketView(),
        
      ),
    );
  }
}
