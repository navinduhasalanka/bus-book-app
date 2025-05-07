import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bus_book/widgets/ticketstatus.dart';

class CheckOut extends StatefulWidget {
  final List<String> selectedSeats;
  final int totalAmount;
  final String fromCity;  // Add these parameters
  final String toCity;
  final String departureTime;
  final String arrivalTime;
  final String busName;

  const CheckOut({
    super.key,
    required this.selectedSeats,
    required this.totalAmount,
    required this.fromCity,  // Add to constructor
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.busName,
  });

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPickupStation;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List<String> stations = ["Station 1", "Station 2", "Station 3", "Station 4", "Station 5"];

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      if (_selectedPickupStation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a pickup station.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Proceeding to payment...")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 123, 118, 117)),
      ),
      body: Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Passenger Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _nameController,
                  label: "Full Name",
                  hint: "Enter your full name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _emailController,
                  label: "Email Address",
                  hint: "Enter your email",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _phoneController,
                  label: "Phone Number",
                  hint: "Enter your phone number",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[\d+]+$'))],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Pickup Station",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          value: _selectedPickupStation,
                          items: stations.map((station) => DropdownMenuItem(
                            value: station,
                            child: Text(station),
                          )).toList(),
                          onChanged: (value) => setState(() {
                            _selectedPickupStation = value;
                            state.didChange(value);
                          }),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Select your pickup station...',
                            hintStyle: const TextStyle(color: Colors.black45),
                            prefixIcon: const Icon(Icons.location_on, color: Colors.black54),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) => value == null ? "Please select a pickup station" : null,
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(state.errorText!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
               TicketStatus(
                  selectedSeats: widget.selectedSeats,
                  totalPrice: widget.totalAmount,
                  fromCity: widget.fromCity,
                  toCity: widget.toCity,
                  departureTime: widget.departureTime,
                  arrivalTime: widget.arrivalTime,  // Make sure this is passed
                  busName: widget.busName,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _validateAndProceed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "PROCEED TO PAY",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon, color: const Color.fromARGB(255, 82, 83, 86)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? "Please enter your $label" : null,
        ),
      ],
    );
  }
}
