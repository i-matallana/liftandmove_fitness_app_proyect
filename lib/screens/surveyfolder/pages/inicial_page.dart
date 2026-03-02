import 'package:flutter/material.dart';

class InicialPage extends StatelessWidget {
  final VoidCallback onNext;

  const InicialPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Pregunta 1"),
        Row(
          children: [
            ElevatedButton(onPressed: onNext, child: Text("Siguiente")),
          ],
        ),
      ],
    );
  }
}