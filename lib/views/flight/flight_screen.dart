import 'package:flutter/material.dart';

class FlightScreen extends StatelessWidget {
  const FlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Details'),
      ),
      body: const Center(
        child: Text('Flight Details Screen'),
      ),
    );
  }
}
