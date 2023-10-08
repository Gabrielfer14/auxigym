import 'package:auxigym/classes/userProvider.dart';
import 'package:auxigym/database/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FichaPage extends StatefulWidget {
  const FichaPage({Key? key}) : super(key: key);

  @override
  _FichaPage createState() => _FichaPage(); //
}

class _FichaPage extends State<FichaPage> {
  double altura = 0.0;
  double peso = 0.0;
  String objetivo = '';

  bool isEditingAltura = false;
  bool isEditingPeso = false;
  bool isEditingObjetivo = false;

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController objetivoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final userId = context.read<UserProvider>().userId;
    final fichaTecnica = await DatabaseHelper.instance.getFichaTecnica(userId!);

    if (fichaTecnica != null) {
      setState(() {
        altura = fichaTecnica.altura;
        peso = fichaTecnica.peso;
        objetivo = fichaTecnica.objetivoUsuario;
        alturaController.text = altura.toStringAsFixed(2);
        pesoController.text = peso.toStringAsFixed(2);
        objetivoController.text = objetivo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Ficha Técnica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEditableField(
              title: 'Altura',
              value: altura.toStringAsFixed(2),
              isEditing: isEditingAltura,
              controller: alturaController,
              onEdit: () {
                setState(() {
                  isEditingAltura = true;
                  alturaController.text = altura.toStringAsFixed(2);
                });
              },
              onSave: () {
                setState(() {
                  altura = double.tryParse(alturaController.text) ?? 0.0;
                  isEditingAltura = false;
                  saveOrUpdateUserData();
                });
              },
            ),
            _buildEditableField(
              title: 'Peso',
              value: peso.toStringAsFixed(2),
              isEditing: isEditingPeso,
              controller: pesoController,
              onEdit: () {
                setState(() {
                  isEditingPeso = true;
                  pesoController.text = peso.toStringAsFixed(2);
                });
              },
              onSave: () {
                setState(() {
                  peso = double.tryParse(pesoController.text) ?? 0.0;
                  isEditingPeso = false;
                  saveOrUpdateUserData();
                });
              },
            ),
            _buildEditableField(
              title: 'Objetivo',
              value: objetivo,
              isEditing: isEditingObjetivo,
              controller: objetivoController,
              onEdit: () {
                setState(() {
                  isEditingObjetivo = true;
                  objetivoController.text = objetivo;
                });
              },
              onSave: () {
                setState(() {
                  objetivo = objetivoController.text;
                  isEditingObjetivo = false;
                  saveOrUpdateUserData();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveOrUpdateUserData() async {
    final userId = context.read<UserProvider>().userId;
    final db = await DatabaseHelper.instance.database;

    final existingData = await db.query(
      'ficha_tecnica',
      where: 'id_usuario = ?',
      whereArgs: [
        userId
      ],
    );

    if (existingData.isNotEmpty) {
      await db.update(
        'ficha_tecnica',
        {
          'altura': altura,
          'peso': peso,
          'objetivo_usuario': objetivo,
        },
        where: 'id_usuario = ?',
        whereArgs: [
          userId
        ],
      );
    } else {
      await db.insert(
        'ficha_tecnica',
        {
          'altura': altura,
          'peso': peso,
          'objetivo_usuario': objetivo,
          'id_usuario': userId,
        },
      );
    }
  }

  Widget _buildEditableField({
    required String title,
    required String value,
    required bool isEditing,
    required TextEditingController controller,
    required VoidCallback onEdit,
    required VoidCallback onSave,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (!isEditing)
              ElevatedButton(
                onPressed: onEdit,
                child: const Text('Editar'),
              ),
          ],
        ),
        if (isEditing)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Novo valor',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: onSave,
                child: const Text('Salvar'),
              ),
            ],
          )
        else
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}
