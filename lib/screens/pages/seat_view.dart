import 'package:bus_book/screens/pages/checkout.dart';
import 'package:flutter/material.dart';

class SeatView extends StatefulWidget {
  const SeatView({super.key});

  @override
  _SeatViewState createState() => _SeatViewState();
}

class _SeatViewState extends State<SeatView> {
  Set<int> selectedSeats = {}; // Store selected seats
  Set<int> bookedSeats = {4, 7, 27, 43, 23, 34}; // Booked seats (red)
  int seatPrice = 500; // Price per seat
  int maxSeats = 10; // Maximum number of seats a user can select

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Seat',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                      'SAMARASINGHE TRAVELS',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '08:00 AM',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Matara - Kaduwela',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      'January 14, 2025',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
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
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8.0),

          // Section 3: Scrollable Seat Grid
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    for (int i = 0; i < 44; i += 4)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int j = 0; j < 2; j++) _buildSeat(i + j + 1),
                              const SizedBox(width: 20),
                              for (int j = 2; j < 4; j++) _buildSeat(i + j + 1),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),

                    // Last row with 5 seats (no middle gap)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 44; i < 49; i++) _buildSeat(i + 1),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Section 4: Bottom Bar (Seat info + price remains)
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display selected seats dynamically (Scrollable Row)
                    selectedSeats.isEmpty
                        ? const Text(
                            'No seats selected',
                            style: TextStyle(color: Colors.grey),
                          )
                        : SizedBox(
                            height: 35, // Keeps height fixed
                            child: Container(
                              width: 250, // Limit the container width to 234px
                              height: 38, // Fixed height of 200px
                              child: SingleChildScrollView(
                                scrollDirection: Axis
                                    .horizontal, // Enables horizontal scrolling
                                child: Row(
                                  children: selectedSeats
                                      .map(
                                        (seat) => Container(
                                          width: 30, // Fixed width for each box
                                          height: 35, // Fixed height for each box
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            border:
                                                Border.all(color: Colors.blue),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$seat',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),

                    const SizedBox(height: 4),

                    // Update total price with moderate font size
                    Text(
                      'LKR ${selectedSeats.length * seatPrice}.00',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize:
                            16, // Adjusted font size to be large but not overwhelming
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: selectedSeats.isNotEmpty
                      ? () {
                          // Navigate to CheckOutPage when button is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOut(
                                  // Your CheckOutPage
                                  //selectedSeats: selectedSeats.toList(), // Passing selected seats
                                  //totalAmount: selectedSeats.length * seatPrice, // Passing total amount
                                  ),
                            ),
                          );
                        }
                      : null, // Disable if no seats selected
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 11), // Button padding
                    decoration: BoxDecoration(
                      gradient: selectedSeats.isNotEmpty
                          ? LinearGradient(
                              colors: [
                                Color(0xFF880000), // Medium red
                                Color(0xFF9E0000), // Lighter red
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [
                                Color(0xFFB0B0B0), // Light grey
                                Color(0xFFD0D0D0), // Lighter grey
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius:
                          BorderRadius.circular(15.0), // Rounded corners
                    ),
                    child: const Text(
                      'CHECKOUT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text color
                        fontSize: 16, // Adjust font size as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Function to build seat widgets
  Widget _buildSeat(int seatNumber) {
    bool isBooked = bookedSeats.contains(seatNumber);
    bool isSelected = selectedSeats.contains(seatNumber);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isBooked) {
            // Show booked seat warning
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('This seat is already booked'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (selectedSeats.contains(seatNumber)) {
            // Toggle seat selection (remove seat if selected again)
            selectedSeats.remove(seatNumber);
          } else if (selectedSeats.length >= maxSeats) {
            // Show warning when trying to select more than max seats
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Maximum 10 seats can be selected'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            // Add seat to selection
            selectedSeats.add(seatNumber);
          }
        });
      },
      child: Container(
        width: 60, // Fixed width for all seats
        height: 70, // Fixed height for all seats
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: isBooked ? Colors.red : Colors.green),
          color: isBooked
              ? Colors.red[100] // Booked seat (Red)
              : (isSelected
                  ? Colors.blue[200]
                  : Colors.green[100]), // Selected seats turn blue
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.event_seat,
              size: 24,
              color: Colors.black,
            ),
            Text(
              '$seatNumber',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
