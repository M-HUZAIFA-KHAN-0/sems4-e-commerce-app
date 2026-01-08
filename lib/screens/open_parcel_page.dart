import 'package:flutter/material.dart';

class OpenParcelPage extends StatelessWidget {
  const OpenParcelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Parcel'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: const Center(child: Text('Open Parcel Page')),
    );
  }
}
