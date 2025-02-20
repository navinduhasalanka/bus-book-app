import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the required package

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  String? _selectedPickupStation;

  final List<String> stations = [
    "Station 1",
    "Station 2",
    "Station 3",
    "Station 4",
    "Station 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Passenger Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              buildInputField(
                label: "Full Name",
                hint: "Enter your full name",
                icon: Icons.person,
              ),

              const SizedBox(height: 16),

              buildInputField(
                label: "Email Address",
                hint: "Enter your email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // Phone Number Field with number and + symbol only
              buildInputField(
                label: "Phone Number",
                hint: "Enter your phone number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[\d+]+$')),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                "Pickup Station",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                height: 45,
                child: DropdownButtonFormField<String>(
                  value: _selectedPickupStation,
                  items: stations.map((station) {
                    return DropdownMenuItem(
                      value: station,
                      child: Text(station),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPickupStation = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Select your pickup station...',
                    hintStyle: const TextStyle(color: Colors.black45),
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon, color: Colors.red),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your $label";
            }
            return null;
          },
        ),
      ],
    );
  }
}
