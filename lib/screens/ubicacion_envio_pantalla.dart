import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../paleta.dart';
import '../providers/productos.dart';
import 'viaje_pedido_pantalla.dart';

class UbicacionEnvioPantalla extends StatefulWidget {
  final double total;

  const UbicacionEnvioPantalla({super.key, required this.total});

  @override
  State<UbicacionEnvioPantalla> createState() => _UbicacionEnvioPantallaState();
}

class _UbicacionEnvioPantallaState extends State<UbicacionEnvioPantalla> {
  final TextEditingController _direccionController = TextEditingController();
  final appTheme = AppTheme();
  // 🔹 Función para confirmar el pedido
  // Valida que se haya ingresado una dirección y luego navega a la pantalla de tracking
  void _confirmarPedido(Productos productosProvider) {
    if (_direccionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu dirección')),
      );
      return;
    }

    // Aquí podrías pasar también los productos o IDs si lo requieres
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TrackingPedidoPantalla(
          totalPedido: widget.total,
          costoEnvio: 5.0, // costo fijo o calculado dinámicamente
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(); // Para colores de la UI

    // 🔹 Obtener la información de los productos usando Provider
    final productosProvider = Provider.of<Productos>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubicación de envío',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Texto de instrucción
            const Text(
              'Ingresa tu dirección o ubicación exacta para la entrega:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // 🔹 Campo de texto para la dirección
            TextField(
              controller: _direccionController,
              maxLines: 3,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                hintText: 'Ej. Calle 10 #123, Zona Central',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Mostrar total a pagar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total a pagar:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Bs ${widget.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: appTheme.primaryColor,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // 🔹 Botón para confirmar pedido
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appTheme.primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _confirmarPedido(productosProvider),
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
