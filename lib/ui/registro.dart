import 'package:flutter/material.dart';
import 'package:auxigym/database/db.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Idade'),
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    int age = int.tryParse(ageController.text) ?? 0;
                    String email = emailController.text;

                    if (username.isEmpty || password.isEmpty || age <= 0 || email.isEmpty) {
                      // Exibe uma mensagem de erro se algum campo estiver vazio ou a idade for inválida.
                      _showSnackBar(context, 'Preencha todos os campos corretamente.');
                      return;
                    }

                    bool isExistingUser = await checkExistingUser(username, email);

                    if (isExistingUser) {
                      // Exib uma mensagem de erro se o usuário já estiver registrado.
                      _showSnackBar(context, 'Usuário já registrado.');
                    } else {
                      // Realiza o registro, inserindo os dados no banco de dados
                      await insertUser(username, password, age, email);

                      // Exibe uma mensagem de sucesso
                      _showSnackBar(context, 'Registro bem-sucedido!');

                      // Após o registro bem-sucedido, você pode navegar de volta para a tela de login ou
                      // para a tela inicial do aplicativo.
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para exibir um SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
