import 'package:flutter/material.dart';
import '../paleta.dart';
import '../widgets/animacion_card.dart';
import '../widgets/card_item.dart';
import 'viaje_pedido_pantalla.dart';

class MiPedidoPantalla extends StatefulWidget {
  const MiPedidoPantalla({super.key});

  @override
  State<MiPedidoPantalla> createState() => _MiPedidoPantallaState();
}

class _MiPedidoPantallaState extends State<MiPedidoPantalla> {
  // 📌 Lista de pedidos simulada (puedes conectarla a tu backend después)
  final List<Map<String, dynamic>> pedidosActivos = [
    {
      "id": 101,
      "productos": [
        {"nombre": "Hamburguesa clásica", "cantidad": 2},
        {"nombre": "Refresco", "cantidad": 2},
      ],
      "total": 52.00,
      "envio": 5.00,
      "estado": "Preparando",
    },
    {
      "id": 102,
      "productos": [
        {"nombre": "Pizza familiar", "cantidad": 1},
        {"nombre": "Agua 500ml", "cantidad": 3},
      ],
      "total": 80.00,
      "envio": 6.00,
      "estado": "En camino",
    },
  ];

  Color _estadoColor(String estado) {
    switch (estado) {
      case "Preparando":
        return Colors.orange;
      case "En camino":
        return Colors.blue;
      case "Entregado":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟦 Header con degradado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.9),
                    AppTheme.primaryColor,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mis Pedidos',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Aquí puedes ver y hacer seguimiento a tus pedidos activos',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 📊 Contador de pedidos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Activos', '${pedidosActivos.length}', Icons.local_shipping),
                    _buildStatItem('Completados', '0', Icons.check_circle_outline),
                    _buildStatItem('Cancelados', '0', Icons.cancel_outlined),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🛍️ Lista de pedidos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: pedidosActivos.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 80),
                        child: Text(
                          'No tienes pedidos activos 😔',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 16),
                          child: Text(
                            'Pedidos Activos',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        ...List.generate(pedidosActivos.length, (index) {
                          final pedido = pedidosActivos[index];

                          // 📦 Descripción corta de productos
                          final resumenProductos = pedido["productos"]
                              .map<String>((p) =>
                                  "${p["cantidad"]} x ${p["nombre"]}")
                              .join(", ");

                          final total = (pedido["total"] + pedido["envio"])
                              .toStringAsFixed(2);

                          return AnimacionCard(
                            index: index,
                            child: CardItem(
                              icon: Icons.receipt_long,
                              title: 'Pedido #${pedido["id"]}',
                              subtitle:
                                  '$resumenProductos\nTotal: Bs $total - Estado: ${pedido["estado"]}',
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _estadoColor(pedido["estado"]),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  pedido["estado"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TrackingPedidoPantalla(
                                      totalPedido: pedido["total"],
                                      costoEnvio: pedido["envio"],
                                    ),
                                  ),
                                );
                              },
                              secondaryButton: TextButton(
                                onPressed: () {
                                  setState(() {
                                    pedidosActivos.removeAt(index);
                                  });
                                },
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
