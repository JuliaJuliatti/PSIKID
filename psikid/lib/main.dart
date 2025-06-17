import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/diario_page.dart';
import 'pages/cadastro.dart'; // <- nova importação
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PsiKidApp());
}

class PsiKidApp extends StatelessWidget {
  const PsiKidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PsiKid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Poppins',
      ),
      home: const Cadastro(), // <- Começa pelo cadastro
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/diario': (context) => const DiaryPage(),
      },
    );
  }
}
