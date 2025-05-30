import 'package:flutter/material.dart';
import '../models/emotion.dart';

class EmotionPage extends StatelessWidget {
  final Emotion emotion;

  const EmotionPage({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(emotion.name)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(emotion.image, height: 150),
            SizedBox(height: 20),
            Text(
              emotion.description,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
