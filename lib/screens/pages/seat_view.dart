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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: widget.seats.map((seatData) {
                  final seatNumber = seatData['seatNumber'].toString();
                  final isBooked = bookedSeats.contains(seatNumber);
                  final isSelected = selectedSeats.contains(seatNumber);

                  return GestureDetector(
                    onTap: () {
                      if (isBooked) return;
                      setState(() {
                        if (isSelected) {
                          selectedSeats.remove(seatNumber);
                        } else if (selectedSeats.length < maxSeats) {
                          selectedSeats.add(seatNumber);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Maximum 10 seats can be selected'), duration: Duration(seconds: 2)));
                        }
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isBooked ? Colors.red[100] : isSelected ? Colors.blue[200] : Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isBooked ? Colors.red : Colors.green, width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.event_seat, size: 24),
                          Text(seatNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
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
                        fromCity: widget.fromCity,  // Pass these values
                        toCity: widget.toCity,
                        departureTime: widget.departureTime,
                        arrivalTime: widget.arrivalTime, // Or pass from SeatView's parameters
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
}
