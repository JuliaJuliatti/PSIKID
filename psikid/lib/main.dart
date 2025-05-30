import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/diario_page.dart'; // <= importe a nova página
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

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        Widget home = const LoginPage();
        if (snapshot.connectionState == ConnectionState.waiting) {
          home = const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.data == true) {
          home = HomePage();
        }

        return MaterialApp(
          title: 'PsiKid',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: 'Poppins',
          ),
          home: home,
          routes: {
            '/diario': (context) => const DiaryPage(), // <- aqui adiciona a rota
          },
        );
      },
    );
  }
}
