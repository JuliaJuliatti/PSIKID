import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


//Tela Get 
class TelaGet extends StatefulWidget {
  const TelaGet({super.key});

  @override
  State<TelaGet> createState() => _TelaGetState();
}

class _TelaGetState extends State<TelaGet> {
  String? conselhos; //variavel assincrona.

  @override 
  void initState(){ //funcao que inicia toda vez que entrar no app.
  super.initState();
  getConselhos();
  }


  void getConselhos() async {
    final response = await http.get(Uri.parse("https://api.adviceslip.com/advice"));//variavel que pega os dados
    //da api.
    if (response.statusCode == 200){ //verifica se o status da comunicação está 200 /ok.
        final data = jsonDecode(response.body);
        setState(() {
          conselhos = data['slip']['advice'];
      });
    } else {
      setState(() {
        conselhos = "Nao tem conselhos disponiveis";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("Minha pagina de get")),
      body: Center(
          child: conselhos == null ? CircularProgressIndicator() :  Text(conselhos!)  ,

      )
    );
  }
}