import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo ao AuxiGym'),
        backgroundColor: const Color.fromARGB(255, 196, 13, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Comece seu treino agora!',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 196, 13, 0),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de treino quando o botão for pressionado
                Navigator.pushNamed(context, '/treino');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 196, 13, 0),
              ),
              child: const Text('Iniciar Treino'),
            ),
            const SizedBox(height: 20),
            const Text(
              'frase motivacional',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
