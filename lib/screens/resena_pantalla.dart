import 'package:flutter/material.dart';
import '../paleta.dart';

class ResenaPantalla extends StatefulWidget {
  const ResenaPantalla({super.key});

  @override
  State<ResenaPantalla> createState() => _ResenaPantallaState();
}

class _ResenaPantallaState extends State<ResenaPantalla> {
  int estrellas = 0;
  final TextEditingController _comentarioController = TextEditingController();

  Widget _buildStar(int index) {
    return IconButton(
      icon: Icon(
        index < estrellas ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 36,
      ),
      onPressed: () {
        setState(() {
          estrellas = index + 1;
        });
      },
    );
  }

  void _enviarResena() {
    // Aquí podrías guardar la reseña en tu backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Reseña enviada!')),
    );

    // Regresa al menú principal
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dejar reseña'),
        backgroundColor: AppTheme.primaryColor,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index)),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _comentarioController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Escribe tu comentario...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _enviarResena,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Enviar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
