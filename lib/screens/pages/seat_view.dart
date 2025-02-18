import 'package:flutter/material.dart';

class SeatView extends StatelessWidget {
  const SeatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Seat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Section 1: Travel Details
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SAMARASINGHE TRAVELS ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '08:00 AM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Matara - Kaduwela',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'January 14, 2025',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Section 2: Front Label
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Text(
                  'Front',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Add space between "Front" label and the seat grid
          const SizedBox(height: 8.0),

          // Section 3: Scrollable Seat Grid
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Generate rows of seats (rows with 4 seats each except the last row)
                    for (int i = 0; i < 44; i += 4)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int j = 0; j < 2; j++)
                                _buildSeat(i + j + 1),
                              // Middle space only for non-last rows
                              const SizedBox(width: 20),
                              for (int j = 2; j < 4; j++)
                                _buildSeat(i + j + 1),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),

                    // Last row with 5 seats (no middle gap)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 44; i < 49; i++)
                          _buildSeat(i + 1),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Section 4: Bottom Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'No seats selected',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'LKR 0.00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle next button click
                  },
                  child: const Text('NEXT →'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeat(int seatNumber) {
    // Define the set of seat numbers to be colored red
    Set<int> redSeats = {4, 7, 27, 43, 23, 34};

    // Check if the current seat number is in the set of red seats
    bool isRedSeat = redSeats.contains(seatNumber);

    // Colors for the seat and border
    Color borderColor = isRedSeat ? Colors.red : Colors.green;
    Color seatBackgroundColor = isRedSeat ? Colors.red[100]! : Colors.green[100]!;

    return Container(
      width: 60,
      height: 70,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderColor), // Border color for the seat
        color: seatBackgroundColor, // Seat background color
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_seat,
            size: 24,
            color: Colors.black, // Icon color for all seats
          ),
          Text(
            '$seatNumber',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black, // Text color for all seats
            ),
          ),
        ],
      ),
    );
  }
}
