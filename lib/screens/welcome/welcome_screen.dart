import 'package:bus_book/screens/welcome/signin_screen.dart';
import 'package:bus_book/screens/welcome/signup_screen.dart';
import 'package:bus_book/widgets/welcome_button.dart';
import 'package:bus_book/widgets/welcome_scaffold.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(top: 250.0),
              child: Column( 
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 36.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Enter personal details to your account',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Expanded(
                      child: WelcomeButton(
                        buttonText: 'Sign in',
                        onTap: SignInScreen(),
                        color: Colors.transparent,
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: WelcomeButton(
                        buttonText: 'Sign up',
                        onTap: SignUpScreen(),
                        color: Colors.white,
                        textColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
