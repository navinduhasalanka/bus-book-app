import 'package:flutter/material.dart';
import 'package:bus_book/screens/pages/checkout.dart';

class SeatView extends StatefulWidget {
  final List<Map<String, dynamic>> seats;
  final String busName;
  final String fromCity;
  final String toCity;
  final String departureTime;
  final String arrivalTime;
  final String departureDate;
  final int ticketPrice;
  final List<Map<String, dynamic>> busCitiesAndTimes;

  const SeatView({
    super.key,
    required this.seats,
    required this.busName,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.departureDate,
    required this.ticketPrice,
    required this.busCitiesAndTimes,
  });

  @override
  _SeatViewState createState() => _SeatViewState();
}

class _SeatViewState extends State<SeatView> {
  Set<String> selectedSeats = {};
  final int maxSeats = 10;
  
  // Configuration for bus layout
  final int totalRows = 8;
  final int totalColumns = 5;
  final int seatsPerColumn = 8;

  @override
  Widget build(BuildContext context) {
    final bookedSeats = widget.seats
        .where((seat) => seat['availability'] == 'booked')
        .map((seat) => seat['seatNumber'].toString())
        .toSet();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Seat', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.busName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(widget.departureTime, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${widget.fromCity} - ${widget.toCity}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    Text(widget.departureDate, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          _buildSeatLegend(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildBusLayout(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedSeats.isNotEmpty)
                      SizedBox(
                        width: 250,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: selectedSeats.map((seat) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue),
                              ),
                              child: Text(seat),
                            )).toList(),
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      'LKR ${selectedSeats.length * widget.ticketPrice}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedSeats.isNotEmpty ? const Color(0xFF9E0000) : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: selectedSeats.isNotEmpty ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOut(
                        selectedSeats: selectedSeats.toList(),
                        totalAmount: selectedSeats.length * widget.ticketPrice,
                        fromCity: widget.fromCity,
                        toCity: widget.toCity,
                        departureTime: widget.departureTime,
                        arrivalTime: widget.arrivalTime,
                        busName: widget.busName,
                      ),
                    ),
                  ) : null,
                  child: const Text('CHECKOUT', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem(Colors.green[100]!, Colors.green, 'Available'),
          const SizedBox(width: 16),
          _buildLegendItem(Colors.blue[200]!, Colors.blue, 'Selected'),
          const SizedBox(width: 16),
          _buildLegendItem(Colors.red[100]!, Colors.red, 'Booked'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color fillColor, Color borderColor, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor, width: 1.5),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBusLayout() {
    // Create a grid layout for the bus seats
    return Column(
      children: [
        // Front of the bus indicator
        Container(
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Text('FRONT', style: TextStyle(fontWeight: FontWeight.bold))),
        ),
        // Bus seat layout
        Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: List.generate(totalRows, (rowIndex) {
            return TableRow(
              children: List.generate(totalColumns, (colIndex) {
                // Calculate the seat number based on column-first order
                // Each column has seatsPerColumn (9) seats except for the middle column
                // which is empty for rows 0-7 (first 8 rows)
                
                // Check if this is the middle column (index 2) and not the last row
                if (colIndex == 2 && rowIndex < 7) {
                  // This is the aisle (middle column)
                  return const SizedBox(width: 30, height: 70);
                }
                
                // Calculate seat index based on column-first ordering
                int seatIndex = colIndex * seatsPerColumn + rowIndex;
                
                // Check if we have a seat at this position
                if (seatIndex < widget.seats.length) {
                  final seatData = widget.seats[seatIndex];
                  final seatNumber = seatData['seatNumber'].toString();
                  final isBooked = seatData['availability'] == 'booked';
                  final isSelected = selectedSeats.contains(seatNumber);
                  
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        if (isBooked) return;
                        setState(() {
                          if (isSelected) {
                            selectedSeats.remove(seatNumber);
                          } else if (selectedSeats.length < maxSeats) {
                            selectedSeats.add(seatNumber);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Maximum 10 seats can be selected'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        });
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: isBooked ? Colors.red[100] : isSelected ? Colors.blue[200] : Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isBooked ? Colors.red : isSelected ? Colors.blue : Colors.green, width: 1.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.event_seat, size: 20),
                            Text(seatNumber, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  // No seat at this position
                  return const SizedBox(width: 45, height: 45);
                }
              }),
            );
          }),
        ),
        // Back of the bus indicator
        Container(
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Text('BACK', style: TextStyle(fontWeight: FontWeight.bold))),
        ),
      ],
    );
  }
}