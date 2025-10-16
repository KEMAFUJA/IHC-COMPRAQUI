import 'package:flutter/material.dart';
import '../paleta.dart';
import 'viaje_pedido_pantalla.dart'; // 👈 IMPORTANTE: importa la nueva pantalla

class UbicacionEnvioPantalla extends StatefulWidget {
  final double total;
  const UbicacionEnvioPantalla({super.key, required this.total});

  @override
  State<UbicacionEnvioPantalla> createState() => _UbicacionEnvioPantallaState();
}

class _UbicacionEnvioPantallaState extends State<UbicacionEnvioPantalla> {
  final TextEditingController _direccionController = TextEditingController();

  void _confirmarPedido() {
    if (_direccionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu dirección')),
      );
      return;
    }

    // Aquí redirige a la pantalla de tracking con los parámetros requeridos
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TrackingPedidoPantalla(
          totalPedido: widget.total,
          costoEnvio: 5.0, // puedes modificar o calcular dinámicamente
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación de envío', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Ingresa tu dirección o ubicación exacta para la entrega:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _direccionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Ej. Calle 10 #123, Zona Central',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total a pagar:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Bs ${widget.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _confirmarPedido,
              child: const Text(
                'CONFIRMAR PEDIDO',
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
