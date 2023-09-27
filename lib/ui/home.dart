import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo ao AuxiGym'),
        backgroundColor: Color.fromARGB(255, 196, 13, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Comece seu treino agora!',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 196, 13, 0),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de treino quando o botão for pressionado
                Navigator.pushNamed(context, '/treino');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 196, 13, 0),
              ),
              child: Text('Iniciar Treino'),
            ),
            SizedBox(height: 20),
            Text(
              'frase motivacional',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
