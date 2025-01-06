import 'package:bus_book/widgets/welcome_scaffold.dart';
import 'package:flutter/material.dart';

class Stataesscmc extends StatefulWidget {
  const Stataesscmc({super.key});

  @override
  State<Stataesscmc> createState() => _StataesscmcState();
}

class _StataesscmcState extends State<Stataesscmc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const WelcomeScaffold(
        child: Text(
          'Hello, thisa eckext!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        notchMargin: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.home_filled,
                color: Colors.purple.shade900,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.calendar_month_outlined,
                color: Colors.purple.shade900,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.lightbulb_outline,
                color: Colors.purple.shade900,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.purple.shade900,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
