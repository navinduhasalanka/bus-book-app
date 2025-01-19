import 'package:bus_book/widgets/ticket_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to hold the selected date
  DateTime? _selectedDate;

  // Variables to hold selected stations
  String? _selectedFromStation;
  String? _selectedToStation;

  // Dummy ticket data
  final List<Map<String, dynamic>> tickets = [
    {'id': 1},
    {'id': 2},
    {'id': 3},
    {'id': 4},
  ];

  // Function to show date picker and update the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
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
    // Calculate button position based on screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          children: [
            // Top gradient area (blue)
            Container(
              height: 400, // Height of the gradient container
              width: double.infinity,
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Departure Terminal
                      const Text(
                        'Departure Terminal',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        height: 45,
                        child: DropdownButtonFormField<String>(
                          value: _selectedFromStation,
                          items: const [
                            DropdownMenuItem(
                                value: 'Station 1', child: Text('Station 1')),
                            DropdownMenuItem(
                                value: 'Station 2', child: Text('Station 2')),
                            DropdownMenuItem(
                                value: 'Station 3', child: Text('Station 3')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedFromStation = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'From....',
                            hintStyle: const TextStyle(color: Colors.black45),
                            prefixIcon: const Icon(
                              Icons.departure_board_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Arrival Terminal
                      const Text(
                        'Arrival Terminal',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        height: 45,
                        child: DropdownButtonFormField<String>(
                          value: _selectedToStation,
                          items: const [
                            DropdownMenuItem(
                                value: 'Station 1', child: Text('Station 1')),
                            DropdownMenuItem(
                                value: 'Station 2', child: Text('Station 2')),
                            DropdownMenuItem(
                                value: 'Station 3', child: Text('Station 3')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedToStation = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'To....',
                            hintStyle: const TextStyle(color: Colors.black45),
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Travel Date
                      const Text(
                        'Travel Date',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 7),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: Container(
                            height: 45,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Select Date',
                                hintStyle:
                                    const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.black54,
                                ),
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _selectedDate != null
                                    ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                                    : '',
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
            ),
            // Solid darker color area (gray)
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFd1d0d6), // Darker grey solid color
                child: tickets.isEmpty
                    ? const Center(
                        child: Text('No tickets available'),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 0, left: 0, right: 0),
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          return TicketView();
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 0),
                      ),
              ),
            ),
          ],
        ),
        // Positioned button at the edge of blue and gray areas
        Positioned(
          left: (screenWidth / 2) -
              75, // Center horizontally (button width is 150)
          top: 400 -
              25, // Position so that half of the button overlaps blue and gray (button height is 50)
          child: SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Handle button press
                if (_selectedFromStation == null ||
                    _selectedToStation == null ||
                    _selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select all fields')),
                  );
                } else {
                  // Proceed to find buses
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Finding buses...')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF880000), // Blue color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                      color: Colors.white, width: 2), // White border
                ),
              ),
              child: const Text(
                'Find Bus',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
