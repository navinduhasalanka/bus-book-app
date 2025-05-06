import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BackendTest extends StatefulWidget {
  const BackendTest({Key? key}) : super(key: key);

  @override
  State<BackendTest> createState() => _BackendTestState();
}

class _BackendTestState extends State<BackendTest> {
  String? _data;
  bool _loading = false;
  String? _error;

  Future<void> _fetchStations() async {
    setState(() {
      _loading = true;
      _error = null;
      _data = null;
    });

    try {
      final response = await http.get(
        Uri.parse('http://localhost:8000/api/buses/stationsList'),
      );
      if (response.statusCode == 200) {
        // Try to decode as JSON, else fallback to plain text
        try {
          final decoded = json.decode(response.body);
          setState(() {
            _data = const JsonEncoder.withIndent('  ').convert(decoded);
          });
        } catch (_) {
          setState(() {
            _data = response.body;
          });
        }
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to connect: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backend Test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _loading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _fetchStations,
                      child: const Text('Fetch Stations List'),
                    ),
                    const SizedBox(height: 24),
                    if (_error != null)
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    if (_data != null)
                      SingleChildScrollView(
                        child: SelectableText(
                          _data!,
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
