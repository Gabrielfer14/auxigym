import 'package:flutter/material.dart';
import 'package:auxigym/ui/home.dart';
import 'package:auxigym/ui/login.dart'; // Importe a classe da tela de login

void main() {
  runApp(MaterialApp(
    title: "Bem-vindo ao AuxiGym",
    initialRoute: '/login', // Defina a rota inicial como a tela de login
    routes: {
      '/login': (context) => LoginPage(), // Rota para a tela de login
      '/home': (context) => Home(), // Rota para a tela inicial
    },
  ));
}
