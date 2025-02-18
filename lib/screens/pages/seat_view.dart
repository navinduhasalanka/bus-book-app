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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                'Front',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          // Add space between "Front" label and the seat grid
          const SizedBox(height: 16.0),

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
                                _buildSeat(context, i + j + 1),
                              // Middle space only for non-last rows
                              const SizedBox(width: 20),
                              for (int j = 2; j < 4; j++)
                                _buildSeat(context, i + j + 1),
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
                          _buildSeat(context, i + 1),
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

  Widget _buildSeat(BuildContext context, int seatNumber) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(seatNumber: seatNumber),
          ),
        );
      },
      child: Container(
        width: 50,
        height: 60,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.event_seat,
              size: 20,
              color: Colors.grey,
            ),
            Text(
              '$seatNumber',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final int seatNumber;

  const DetailPage({super.key, required this.seatNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat $seatNumber'),
      ),
      body: Center(
        child: Text(
          'Details for Seat $seatNumber',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
