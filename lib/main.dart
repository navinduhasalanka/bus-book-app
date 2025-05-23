import 'package:bus_book/firebase_options.dart';
import 'package:bus_book/screens/pages/checkout.dart';
import 'package:bus_book/screens/pages/home_screen.dart';
import 'package:bus_book/screens/pages/seat_view.dart';
import 'package:bus_book/screens/welcome/welcome_screen.dart';
import 'package:bus_book/widgets/booked_ticket.dart';
import 'package:bus_book/widgets/navigation_menu.dart';
import 'package:bus_book/widgets/ticket_view.dart';
import 'package:bus_book/widgets/ticketstatus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const WelcomeScreen()
    );
  }
}

