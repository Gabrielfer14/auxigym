<<<<<<< HEAD
import 'package:auxigym/classes/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Acesse o UserProvider para obter o nome do usuário
    final userProvider = Provider.of<UserProvider>(context);
    final nomeUsuario = userProvider.nomeUsuario; // Suponha que o UserProvider tenha um atributo chamado 'nomeUsuario'

    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo ao AuxiGym, $nomeUsuario'), // Use o nome do usuário aqui
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de edição/criação de ficha técnica quando o botão for pressionado
                Navigator.pushNamed(context, '/ficha');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 196, 13, 0),
              ),
              child: const Text('Editar/Criar Ficha Técnica'),
            ),
          ],
        ),
      ),
    );
  }
}
=======
import 'package:auxigym/classes/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Acesse o UserProvider para obter o nome do usuário
    final userProvider = Provider.of<UserProvider>(context);
    final nomeUsuario = userProvider.nomeUsuario; // Suponha que o UserProvider tenha um atributo chamado 'nomeUsuario'

    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo ao AuxiGym, $nomeUsuario'), // Use o nome do usuário aqui
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de edição/criação de ficha técnica quando o botão for pressionado
                Navigator.pushNamed(context, '/ficha');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 196, 13, 0),
              ),
              child: const Text('Editar/Criar Ficha Técnica'),
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> e78620e70940a89767d71d34241caed7bc70025f
