import 'dart:convert';
import 'package:bus_book/widgets/ticket_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _selectedDate;
  String? _selectedFromStation;
  String? _selectedToStation;
  List<String> stations = [];
  List<Map<String, dynamic>> tickets = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchStations();
  }

  Future<void> _fetchStations() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/api/buses/stationsList'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          stations = data.cast<String>();
        });
      }
    } catch (e) {
      print('Error fetching stations: $e');
    }
  }

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

  Future<void> _findBuses() async {
    if (_selectedFromStation == null || 
        _selectedToStation == null || 
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      tickets = [];
    });

    final String fromCity = _selectedFromStation!;
    final String toCity = _selectedToStation!;
    final String departureDate =
        "${_selectedDate!.year.toString().padLeft(4, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";

    final String apiUrl =
        "http://localhost:8000/api/buses?fromCity=$fromCity&toCity=$toCity&DepartureDate=$departureDate";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          tickets = data.cast<Map<String, dynamic>>();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch buses: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF540000),
                    Color(0xFF880000),
                    Color(0xFF9E0000),
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
                          items: stations
                              .map((station) => DropdownMenuItem(
                                    value: station,
                                    child: Text(station),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFromStation = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'From....',
                            hintStyle: const TextStyle(color: Colors.black45),
                            prefixIcon: const Icon(
                              Icons.departure_board_outlined,
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
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        height: 45,
                        child: DropdownButtonFormField<String>(
                          value: _selectedToStation,
                          items: stations
                              .map((station) => DropdownMenuItem(
                                    value: station,
                                    child: Text(station),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedToStation = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'To....',
                            hintStyle: const TextStyle(color: Colors.black45),
                            prefixIcon: const Icon(
                              Icons.location_on,
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
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFd1d0d6),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : tickets.isEmpty
                        ? const Center(
                            child: Text('No tickets available'),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 0, left: 0, right: 0),
                            itemCount: tickets.length,
                            itemBuilder: (context, index) {
                              final bus = tickets[index];
                              final String fromCity = _selectedFromStation!;
                              final String toCity = _selectedToStation!;
                              List<Map<String, dynamic>> allCities =
                                  List<Map<String, dynamic>>.from(
                                      bus['busCitiesAndTimes'] ?? []);

                              Map<String, dynamic>? departureCity;
                              Map<String, dynamic>? arrivalCity;

                              for (var city in allCities) {
                                if (city['cityName'] == fromCity && departureCity == null) {
                                  departureCity = city;
                                }
                                if (city['cityName'] == toCity) {
                                  arrivalCity = city;
                                }
                              }

                              List<Map<String, dynamic>> filteredCities = [];
                              if (departureCity != null && arrivalCity != null) {
                                filteredCities.add(departureCity);
                                filteredCities.add(arrivalCity);
                              }

                              return TicketView(
                                busName: bus['busName'] ?? '',
                                busPlateNo: bus['busPlateNo'] ?? '',
                                busType: bus['busType'] ?? '',
                                busOwnership: bus['busOwnership'] ?? '',
                                busAmenities: List<String>.from(bus['busAmenities'] ?? []),
                                recommends: bus['recommends'] ?? 0,
                                busCitiesAndTimes: filteredCities,
                                busTicketPrice: bus['busTicketPrice'] ?? 0,
                                busDepartureDate: bus['busDepartureDate'] ?? '',
                                seats: List<Map<String, dynamic>>.from(bus['seats'] ?? []),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 0),
                          ),
              ),
            ),
          ],
        ),
        Positioned(
          left: (screenWidth / 2) - 75,
          top: 400 - 25,
          child: SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              onPressed: _findBuses,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF880000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                      color: Colors.white, width: 2),
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
