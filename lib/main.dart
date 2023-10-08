import 'package:auxigym/classes/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auxigym/ui/ficha.dart';
import 'package:auxigym/ui/home.dart';
import 'package:auxigym/ui/login.dart';
import 'package:auxigym/ui/registro.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bem-vindo ao AuxiGym",
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Home(),
        '/register': (context) => const RegisterPage(),
        '/ficha': (context) => const FichaPage(),
      },
    );
  }
}
