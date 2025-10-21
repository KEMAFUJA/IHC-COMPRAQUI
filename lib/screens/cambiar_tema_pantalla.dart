import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tema.dart'; // Usar tu clase Tema que ya tiene ThemeMode

class CambiarTemaPantalla extends StatelessWidget {
  const CambiarTemaPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Provider.of<Tema>(context); // Aquí usas Tema con ThemeMode

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Color / Tema'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Modo Sistema'),
            value: ThemeMode.system,
            groupValue: tema.themeMode,
            onChanged: (value) {
              tema.setTheme(value!);
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Modo Claro'),
            value: ThemeMode.light,
            groupValue: tema.themeMode,
            onChanged: (value) {
              tema.setTheme(value!);
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Modo Oscuro'),
            value: ThemeMode.dark,
            groupValue: tema.themeMode,
            onChanged: (value) {
              tema.setTheme(value!);
            },
          ),
        ],
      ),
    );
  }
}
