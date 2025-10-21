import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../paleta.dart';
import '../providers/resenas.dart';

class ResenaPantalla extends StatefulWidget {
  const ResenaPantalla({super.key});

  @override
  State<ResenaPantalla> createState() => _ResenaPantallaState();
}

class _ResenaPantallaState extends State<ResenaPantalla> {
  int estrellas = 0; // Contador de estrellas seleccionadas
  final TextEditingController _comentarioController = TextEditingController();

  // 🔹 Construye un icono de estrella
  Widget _buildStar(int index) {
    return IconButton(
      icon: Icon(
        index < estrellas ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 36,
      ),
      onPressed: () {
        setState(() {
          estrellas = index + 1; // Actualiza cantidad de estrellas
        });
      },
    );
  }

  // 🔹 Función para enviar reseña
  // Guarda la reseña usando Provider y muestra un mensaje de confirmación
  void _enviarResena(BuildContext context, Resenas resenasProvider) {
    if (estrellas == 0 || _comentarioController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa la reseña y comentario')),
      );
      return;
    }

    // Guardar la reseña usando el provider
    resenasProvider.agregarResena({
      'estrellas': estrellas,
      'comentario': _comentarioController.text.trim(),
      'fecha': DateTime.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Reseña enviada!')),
    );

    // Regresa al menú principal
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(); // ⚠️ Instancia de AppTheme

    // 🔹 Obtenemos el provider de reseñas
    final resenasProvider = Provider.of<Resenas>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dejar reseña'),
        backgroundColor: appTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Califica tu experiencia',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // 🔹 Fila de estrellas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index)),
            ),
            const SizedBox(height: 24),

            // 🔹 Campo de texto para comentario
            TextField(
              controller: _comentarioController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Escribe tu comentario...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 🔹 Botón enviar reseña
            ElevatedButton(
              onPressed: () => _enviarResena(context, resenasProvider),
              style: ElevatedButton.styleFrom(
                backgroundColor: appTheme.primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Enviar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
