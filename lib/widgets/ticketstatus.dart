import 'package:flutter/material.dart';

class TicketStatus extends StatelessWidget {
  const TicketStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade400, // Grey border
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                'Your Ticket Report Status',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black, // Dark black title
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey, thickness: 1),
            const SizedBox(height: 24),
            const Text(
              'Your Destination',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black, // Middle black for section title
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: TextStyle(
                          color: Colors.grey[600], // Grey for 'From'
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Matara',
                        style: TextStyle(
                          color: Colors.black, // Grey for 'From'
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '06:15 pm',
                        style: TextStyle(
                          color: Colors.grey[600], // Light black for city names
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'To',
                        style: TextStyle(
                          color: Colors.grey[600], // Light black for city names
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Kaduwela',
                        style: TextStyle(
                          color: Colors.black, // Grey for 'To'
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '08:45 am',
                        style: TextStyle(
                          color: Colors.grey[600], // Light black for city names
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Bus No.   : ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black, // Middle black
                  ),
                ),
                const Text(
                  'NB 4543',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black, // Middle black
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Border around "Your Seats"
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400, // Grey border
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Seats',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87, // Middle black
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildSeatChip('A2'),
                      const SizedBox(width: 8),
                      _buildSeatChip('A3'),
                      const SizedBox(width: 8),
                      _buildSeatChip('A4'),
                      const SizedBox(width: 8),
                      _buildSeatChip('B6'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Border around "Total Fare Price"
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400, // Grey border
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Fare Price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87, // Middle black
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Total Price:\n',
                              style: TextStyle(
                                color: Colors.black87, // Lighter grey for label
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: '(Including all taxes)',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w300, // Keep the same lighter grey
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'LKR 6400.00',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Middle black for price
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatChip(String seatNumber) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        seatNumber,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black, // Middle black for seat numbers
        ),
      ),
    );
  }
}
