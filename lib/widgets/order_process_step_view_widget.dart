import 'package:flutter/material.dart';



class StepCircle extends StatelessWidget {
  final bool active;
  final bool done;
  final String label;
  final int stepNumber;

  const StepCircle({
    required this.active,
    required this.label,
    this.done = false,
    this.stepNumber = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: active ? Colors.green : Colors.grey.shade300,
          child: done
              ? const Icon(Icons.check, color: Colors.white, size: 18)
              : Text('$stepNumber', style: TextStyle(color: active ? Colors.white : Colors.black),),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}




class StepLine extends StatelessWidget {
  final bool active;
  const StepLine({required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 18),
        color: active ? Colors.green : Colors.grey.shade300,
      ),
    );
  }
}