import 'package:bus_book/widgets/booked_ticket_view.dart';
import 'package:flutter/material.dart';

class BookedTicket extends StatelessWidget {
  const BookedTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced margin
      padding: const EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Slightly smaller border radius
        border: Border.all(
          color: const Color(0xFF9E0000),
          width: 1.5, // Slightly thinner border
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6, // Reduced blur
            offset: const Offset(0, 3), // Adjusted shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Samarasinghe",
            style: TextStyle(
              fontSize: 14, // Reduced font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF9E0000),
            ),
          ),
          const SizedBox(height: 6), // Reduced spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "06:15 PM",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Transform.translate(
                offset: const Offset(0, 8), // Adjusted position
                child: const Icon(Icons.directions_bus, color: Color(0xFF9E0000), size: 24), // Smaller icon
              ),
              const Text(
                "08:45 AM",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Matara", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text("Kaduwela", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6), // Reduced spacing
          const Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.grey, size: 16), // Smaller icons
              SizedBox(width: 3),
              Text("AC", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(width: 6),
              Icon(Icons.star, color: Colors.amber, size: 16),
              SizedBox(width: 3),
              Text("4.5", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(width: 6),
              Icon(Icons.wifi, color: Colors.grey, size: 16),
              SizedBox(width: 3),
              Text("Internet", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(width: 6),
              Icon(Icons.chair, color: Colors.grey, size: 16),
              SizedBox(width: 3),
              Text("49 seats", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 10), // Reduced spacing
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookedTicketView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Smaller button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // Slightly smaller button
                ),
              ),
              child: const Text(
                "View Ticket",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), // Smaller text
              ),
            ),
          ),
        ],
      ),
    );
  }
}