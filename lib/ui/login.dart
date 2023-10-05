import 'package:auxigym/database/db.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<bool> checkCredentials(String username, String password) async {
  final db = await DatabaseHelper.instance.database;
  final result = await db.query(
    'usuario',
    where: 'nome_usuario = ? AND senha_usuario = ?',
    whereArgs: [
      username,
      password
    ],
  );

  return result.isNotEmpty; // Retorna verdadeiro se encontrar um usuário com as credenciais fornecidas.
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Nome de Usuário'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String username = usernameController.text;
                  String password = passwordController.text;

                  bool isAuthenticated = await checkCredentials(username, password);

                  if (isAuthenticated) {
                    // Autenticação bem-sucedida, navegue para a tela principal
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // Exiba uma mensagem de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nome de usuário ou senha incorretos.'),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  // Navegue para a página de registro quando o botão "Registrar" for pressionado.
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
