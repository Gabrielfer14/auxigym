import 'package:flutter/material.dart';
import 'package:auxigym/ui/home.dart';
import 'package:auxigym/ui/login.dart';
import 'package:auxigym/ui/registro.dart';

void main() {
  runApp(MaterialApp(
    title: "Bem-vindo ao AuxiGym",
    initialRoute: '/login', // Defina a rota inicial como a tela de login
    routes: {
      '/login': (context) => const LoginPage(), // Rota para a tela de login
      '/home': (context) => const Home(), // Rota para a tela inicial
      '/register': (context) => const RegisterPage(),
    },
  ));
}
