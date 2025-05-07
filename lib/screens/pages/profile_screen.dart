import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String id;
  final String userName;
  final String email;
  final String mobile;
  
  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.mobile,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      mobile: json['mobile'],
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isPasswordVisible = false; // Track password visibility
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  String _rawResponse = '';
  
  User? _user;
  
  // Text controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    
    try {
      // Replace with your actual user ID
      const userId = '6819ef6621723f2611d8da74';
      final response = await http.get(
        Uri.parse('http://localhost:8000/api/users/mobile/$userId'),
      );
      
      // Store raw response for display
      setState(() {
        _rawResponse = 'Status Code: ${response.statusCode}\n'
            'Response Body: ${response.body}';
      });
      
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final user = User.fromJson(jsonData);
        
        setState(() {
          _user = user;
          _nameController.text = user.userName;
          _emailController.text = user.email;
          _mobileController.text = user.mobile;
          _passwordController.text = '********'; // Password placeholder
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _errorMessage = 'Failed to load user data. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchUserData,
          ),
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: Colors.red))
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // Centered Profile Icon
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  if (_hasError)
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.red.shade100,
                      width: double.infinity,
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red.shade900),
                      ),
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // User Name Label & Field
                  const Text(
                    "User Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _nameController,
                    readOnly: true,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.grey[600]),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Email Address Label & Field
                  const Text(
                    "Email Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _emailController,
                    readOnly: true,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.grey[600]),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Mobile Number Label & Field
                  const Text(
                    "Mobile Number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _mobileController,
                    readOnly: true,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      prefixIcon: Icon(Icons.phone, color: Colors.grey[600]),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Password Label & Field
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _passwordController,
                    readOnly: true,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // No HTTP Response Card
                  
                  // Removed Update Button
                ],
              ),
            ),
          ),
      );
  }
}