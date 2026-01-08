import 'package:flutter/material.dart';

class EMIPage extends StatelessWidget {
  const EMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EMI'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: const Center(child: Text('EMI Page')),
    );
  }
}
