import 'package:flutter/material.dart';

class QuestionOne extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const QuestionOne({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Pregunta 1"),
        Row(
          children: [
            ElevatedButton(onPressed: onBack, child: Text("Atrás")),
            ElevatedButton(onPressed: onNext, child: Text("Siguiente")),
          ],
        ),
      ],
    );
  }
}