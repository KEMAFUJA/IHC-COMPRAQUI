import 'dart:async';
import 'package:flutter/material.dart';
import '../paleta.dart';
import 'resena_pantalla.dart'; // 👈 nueva pantalla de reseña

class TrackingPedidoPantalla extends StatefulWidget {
  final double totalPedido;
  final double costoEnvio;

  const TrackingPedidoPantalla({super.key, required this.totalPedido, required this.costoEnvio});

  @override
  State<TrackingPedidoPantalla> createState() => _TrackingPedidoPantallaState();
}

class _TrackingPedidoPantallaState extends State<TrackingPedidoPantalla> {
  bool buscandoRepartidor = true;
  int etapa = 0;

  final List<String> etapas = [
    'De ida a la tienda',
    'Haciendo el pedido',
    'Recibiendo pedido',
    'De ida a destino',
    'Destino'
  ];

  Map<String, String> repartidor = {
    "nombre": "Juan Pérez",
    "marca": "Bajaj",
    "modelo": "Boxer 150",
    "placa": "1234-XYZ",
    "celular": "+591 77777777",
    "foto": "https://cdn-icons-png.flaticon.com/512/147/147144.png"
  };

  @override
  void initState() {
    super.initState();
    // Simula búsqueda de delivery
    Timer(const Duration(seconds: 3), () {
      setState(() => buscandoRepartidor = false);
      _iniciarProgreso();
    });
  }

  void _iniciarProgreso() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (etapa < etapas.length - 1) {
        setState(() => etapa++);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool entregado = etapa >= etapas.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento del pedido'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: buscandoRepartidor
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppTheme.primaryColor),
                  SizedBox(height: 16),
                  Text('Buscando repartidor...'),
                ],
              ),
            )
          : entregado
              ? _pedidoEntregado()
              : _pedidoEnCamino(),
    );
  }

  Widget _pedidoEnCamino() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                '🗺️ Mapa (simulado)',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black54),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: etapas.map((e) {
                  int i = etapas.indexOf(e);
                  bool completado = i <= etapa;
                  return Expanded(
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: completado ? Colors.green : Colors.red.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: etapas.map((e) {
                  int i = etapas.indexOf(e);
                  bool completado = i <= etapa;
                  return Expanded(
                    child: Text(
                      e,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: completado ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(repartidor['foto']!),
                    radius: 30,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(repartidor['nombre']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${repartidor['marca']} ${repartidor['modelo']}'),
                        Text('Placa: ${repartidor['placa']}'),
                        Text('Celular: ${repartidor['celular']}'),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '⏳ Tiempo estimado de llegada: ${(etapas.length - etapa) * 5} min',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pedidoEntregado() {
    double total = widget.totalPedido + widget.costoEnvio;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text('¡Su pedido llegó!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            CircleAvatar(
              backgroundImage: NetworkImage(repartidor['foto']!),
              radius: 40,
            ),
            const SizedBox(height: 16),
            Text(repartidor['nombre']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('${repartidor['marca']} ${repartidor['modelo']}'),
            Text('Placa: ${repartidor['placa']}'),
            Text('Celular: ${repartidor['celular']}'),
            const SizedBox(height: 24),
            Text(
              '💰 Total: Bs ${total.toStringAsFixed(2)} (Pedido: Bs ${widget.totalPedido.toStringAsFixed(2)} + Envío: Bs ${widget.costoEnvio.toStringAsFixed(2)})',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ResenaPantalla()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('¡Recoger!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
