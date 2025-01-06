import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to hold the selected date
  DateTime? _selectedDate;

  // Function to show date picker and update the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top gradient area (200 pixels) with text and text fields
        Container(
          height: 400,  // Height of the gradient container
          width: double.infinity,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                const Center(
                  child: Text(
                    'Search Buses',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White color for better contrast
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Departure Terminal',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white, // White color for better contrast
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  height: 45, // Reduced height for the box
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Station';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),  // Padding reduced for smaller height
                      fillColor: Colors.white,
                      filled: true, // Sets the background color to white
                      hintText: 'From....',
                      hintStyle: const TextStyle(
                        color: Colors.black45, // Slightly darker placeholder color
                      ),
                      prefixIcon: const Icon(
                        Icons.departure_board_outlined, // Icon for journey start
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
                const SizedBox(height: 20),
                const Text(
                  'Arrival Terminal',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white, // White color for better contrast
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  height: 45, // Reduced height for the box
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Station';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),  // Padding reduced for smaller height
                      fillColor: Colors.white,
                      filled: true, // Sets the background color to white
                      hintText: 'To....',
                      hintStyle: const TextStyle(
                        color: Colors.black45, // Slightly darker placeholder color
                      ),
                      prefixIcon: const Icon(
                        Icons.location_on, // Icon for destination
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
                const SizedBox(height: 20),
                const Text(
                  'Travel Date',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white, // White color for better contrast
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  height: 45, // Reduced height for the box
                  child: GestureDetector(
                    onTap: () => _selectDate(context), // Open date picker when clicked
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: TextEditingController(
                            text: _selectedDate != null
                                ? '${_selectedDate!.toLocal()}'.split(' ')[0]
                                : ''),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),  // Padding reduced for smaller height
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Select Date',
                          hintStyle: const TextStyle(
                            color: Colors.black45,
                          ),
                          prefixIcon: const Icon(
                            Icons.calendar_today,
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
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        // Solid darker color area from 200px down to the bottom
        Expanded(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFd1d0d6), // Darker grey solid color
            child: const Center(
              child: Text(
                'Home screen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
