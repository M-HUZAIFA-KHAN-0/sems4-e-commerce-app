import 'package:flutter/material.dart';

class AddonsPage extends StatelessWidget {
  const AddonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addons'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: const Center(child: Text('Addons Page')),
    );
  }
}
