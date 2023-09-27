import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Nome de Usuário'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implemente a lógica de autenticação aqui
                  // Verifique se os valores inseridos coincidem com as credenciais válidas
                  String username = usernameController.text;
                  String password = passwordController.text;

                  if (username == 'teste' && password == 'teste') {
                    // Autenticação bem-sucedida, navegue para a tela principal
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // Exiba uma mensagem de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nome de usuário ou senha incorretos.'),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
