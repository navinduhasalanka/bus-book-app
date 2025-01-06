import 'package:bus_book/screens/welcome/signin_screen.dart';
import 'package:bus_book/widgets/welcome_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../services/firbase_auth_services.dart'; // Import FirebaseAuthServices

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignUpKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberPassword = true;

  @override
  Widget build(BuildContext context) {
    return WelcomeScaffold(
      child: Column(
        children: [
          const Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    )),
                child: SingleChildScrollView(
                  child: Form(
                      key: _formSignUpKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Full Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Full Name'),
                              hintText: 'Enter Full Name',
                              hintStyle: const TextStyle(
                                color: Colors.black26,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              hintText: 'Enter Email',
                              hintStyle: const TextStyle(
                                color: Colors.black26,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              hintText: 'Enter Password',
                              hintStyle: const TextStyle(
                                color: Colors.black26,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                              const Text(
                                'Yes, I agree to the Terms and conditions',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formSignUpKey.currentState!.validate() &&
                                      rememberPassword) {
                                    try {
                                      print("Button press detected");
                                      await FirebaseAuthServices().signUp(
                                        email: _emailController.text.trim(),
                                        password:  _passwordController.text.trim(),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Sign up successful!'),
                                        ),
                                      );
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const SignInScreen()));
                                    } catch (e) {
                                      print(e);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Sign up failed: $e'),
                                        ),
                                      );
                                    }
                                  } else if (!rememberPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                              'Please agree to processing of personal details',
                                            )));
                                  }
                                },
                                child: const Text('Sign up')),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.7,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  'Sign up with',
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 0.7,
                                color: Colors.grey.withOpacity(0.5),
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Bootstrap.facebook),
                                color: Colors.blue,
                                onPressed: () {
                                  // Add action for Facebook login here
                                },
                              ),
                              IconButton(
                                icon: const Icon(Bootstrap.google),
                                color: Colors.red,
                                onPressed: () {
                                  // Add action for Google login here
                                },
                              ),
                              IconButton(
                                icon: const Icon(Bootstrap.twitter),
                                color: Colors.blueAccent,
                                onPressed: () {
                                  // Add action for Twitter login here
                                },
                              ),
                              IconButton(
                                icon: const Icon(Bootstrap.apple),
                                color: Colors.black,
                                onPressed: () {
                                  // Add action for Apple login here
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'If you already have an account ',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (e) => const SignInScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
