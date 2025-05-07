import 'package:bus_book/screens/pages/seat_view.dart';
import 'package:flutter/material.dart';

class TicketView extends StatelessWidget {
  final String busName;
  final String busPlateNo;
  final String busType;
  final String busOwnership;
  final List<String> busAmenities;
  final int recommends;
  final List<Map<String, dynamic>> busCitiesAndTimes;
  final num busTicketPrice;
  final String busDepartureDate;
  final List<Map<String, dynamic>> seats;

  const TicketView({
    Key? key,
    required this.busName,
    required this.busPlateNo,
    required this.busType,
    required this.busOwnership,
    required this.busAmenities,
    required this.recommends,
    required this.busCitiesAndTimes,
    required this.busTicketPrice,
    required this.busDepartureDate,
    required this.seats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get first and last city/time if available
    final fromCity = busCitiesAndTimes.isNotEmpty
        ? busCitiesAndTimes.first['cityName'] ?? ''
        : '';
    final toCity = busCitiesAndTimes.length > 1
        ? busCitiesAndTimes.last['cityName'] ?? ''
        : '';
    final fromTime = busCitiesAndTimes.isNotEmpty
        ? busCitiesAndTimes.first['arrivalTime'] ?? ''
        : '';
    final toTime = busCitiesAndTimes.length > 1
        ? busCitiesAndTimes.last['arrivalTime'] ?? ''
        : '';

    // Count available seats
    final availableSeats = seats
        .where((seat) => seat['availability'] == 'available')
        .length;
    final totalSeats = seats.length;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF9E0000),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  busName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9E0000),
                  ),
                ),
                Text(
                  busPlateNo,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      fromTime,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(0, 12),
                      child: const Icon(Icons.directions_bus,
                          color: Color(0xFF9E0000), size: 30),
                    ),
                    const Spacer(),
                    Text(
                      toTime,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      fromCity,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Spacer(),
                    Text(
                      toCity,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (busAmenities.contains('AC'))
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.ac_unit, color: Colors.grey, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "AC",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          recommends.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    if (busAmenities.contains('Internet/Wifi'))
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.wifi, color: Colors.grey, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "Internet",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.chair, color: Colors.grey, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          "$totalSeats seats",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rs. $busTicketPrice /per seat",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "$availableSeats seats available",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SeatView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E0000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Reserve Seat",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
