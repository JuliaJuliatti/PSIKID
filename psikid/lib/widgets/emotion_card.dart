import 'package:flutter/material.dart';
import '../models/emotion.dart';
import '../pages/emotion_page.dart';

class EmotionCard extends StatelessWidget {
  final Emotion emotion;

  const EmotionCard({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmotionPage(emotion: emotion),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(emotion.image, height: 100),
            SizedBox(height: 20),
            Text(
              emotion.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
