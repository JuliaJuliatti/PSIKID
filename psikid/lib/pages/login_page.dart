import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'auth.dart'; // <- Import da AuthService
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late VideoPlayerController _controller;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/background_video.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _email.dispose();
    _senha.dispose();
    super.dispose();
  }

  void _login() async {
    final message = await AuthService().login(
      email: _email.text.trim(),
      password: _senha.text.trim(),
    );

    if (message == 'Success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? 'Erro desconhecido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
          else
            Container(color: Colors.black),

          Container(color: Colors.deepPurpleAccent.withOpacity(0.3)),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/PsiKid.png',
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _email,
                            decoration: const InputDecoration(
                              labelText: 'Digite seu email',
                            ),
                          ),
                          TextField(
                            controller: _senha,
                            decoration: const InputDecoration(
                              labelText: 'Digite sua senha',
                            ),
                            obscureText: true,
                            obscuringCharacter: '*',
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            ).copyWith(
                              foregroundColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text('Entrar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
