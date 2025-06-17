import 'package:flutter/material.dart';
import '../data/emotions_list.dart';
import '../widgets/emotion_card.dart';
import 'login_page.dart';
import 'diario_page.dart';
import 'mapa.dart';
import 'getConcelhos.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _openDiario(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DiaryPage()),
    );
  }

  void _openMapa(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Mapa()),
    );
  }

  void _openConselho(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaGet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PsiKid'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(16.0),
              children: emotions.map((e) => EmotionCard(emotion: e)).toList(),
            ),
          ),

          // Botão: Diário de Emoções
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () => _openDiario(context),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFff9a9e),
                      Color(0xFFfad0c4),
                      Color(0xFFfad0c4),
                      Color(0xFFfbc2eb),
                      Color(0xFFa18cd1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: const [
                    Icon(Icons.emoji_objects, size: 32, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Meu Diário de Emoções',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botão: Conheça nossa clínica
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: ElevatedButton.icon(
              onPressed: () => _openMapa(context),
              icon: const Icon(Icons.map),
              label: const Text('Conheça nossa clínica'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Botão: Receba um conselho
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: ElevatedButton.icon(
              onPressed: () => _openConselho(context),
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Receba um conselho'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
