import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:psikid/pages/home_page.dart';
import 'package:psikid/pages/login_page.dart'; // página de login com vídeo
import 'auth.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
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

  void _cadastrar() async {
    final message = await AuthService().registration(
      email: _email.text.trim(),
      password: _senha.text.trim(),
    );

    if (message != null && message.contains('Sucess')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message ?? 'Erro ao cadastrar')),
    );
  }

  void _limpar() {
    _email.clear();
    _senha.clear();
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
                            onPressed: _cadastrar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            ).copyWith(
                              foregroundColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text('Cadastrar'),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _limpar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            ).copyWith(
                              foregroundColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text('Limpar credenciais'),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              'Já tem conta? Fazer login',
                              style: TextStyle(color: Colors.deepPurple),
                            ),
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
